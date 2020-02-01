package com.zmkj.platform.controller;

import com.alibaba.fastjson.JSONObject;
import com.zmkj.platform.common.MemCache;
import com.zmkj.platform.entity.*;
import com.zmkj.platform.service.*;
import com.zmkj.platform.util.*;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

//@Controller
public class StartControllerCopy {
    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private FreeCardService freeCardService;

    @Autowired
    private PriceLogService priceLogService;

    //控制层调用
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private PriceService priceService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ReglogService reglogService;

    //商品业务类
    @Autowired
    private CommodityService commodityService;

    //代理业务类
    @Autowired
    private AgentsService agentsService;

    @Autowired
    private HttpServletRequest request;


    @Autowired
    private ExpressService expressService;

    @Autowired
    private PclassService pclassService;

    @Autowired
    private PhoneCardService phoneCardService;

    /**
     * 首页
     * @return
     */
    @RequestMapping({"/","/index"})
    public String indexPage(String o,String d){
        //获取站长信息
        if(! getIndexInfo()){
            return "err";
        }
        if(d != null){
            request.setAttribute("diy","ok");
        }
        request.setAttribute("pclass",MemCache.get("website_class"));
        request.setAttribute("costs",MemCache.get("website_cost"));
        request.setAttribute("config",MemCache.get("website_config"));
        if(o != null){
            request.getSession().setAttribute("openid",o);
            if(d != null){
                return "redirect:/index?d=true";
            }
            return "redirect:/index";
        }
        return "index";
    }

    /**
     * 套餐列表
     * @param aid 代理ID
     * @param pcid  分类ID
     * @return
     */
    @RequestMapping("/list")
    public String listPage(String aid,String pcid){
        if(! checkParam(aid,pcid)){
            //缺少参数
            return "err";
        }

        Integer[] param = stringToInteger(aid,pcid);
        if(param == null){
            return "err";
        }

        //获取站长信息
        if(! getIndexInfo()){
            return "err";
        }


        Agents system_agent = (Agents)MemCache.get("system_admin");
        List<Commodity> commodityList = commodityService.getCommodityList(param[0],param[1],system_agent.getId());
        request.setAttribute("commodityList",commodityList);
        request.setAttribute("pclass",MemCache.get("website_class"));
        request.setAttribute("tempClassId",param[1]);
        return "list";
    }

    /**
     * 购买页面
     * @param aid 代理ID
     * @param cid 商品ID
     * @return
     */
    @RequestMapping("/pay")
    public String payPage(String aid,String cid){
        if(! checkParam(aid,cid)){
            //缺少参数
            return "err";
        }
        Integer[] param = stringToInteger(aid,cid);
        if(param == null){
            return "err";
        }
        //获取站长信息
        if(! getIndexInfo()){
            return "err";
        }

        //查询单个商品
        Commodity commodity = commodityService.getCommodity(param[0],param[1],null);
        request.setAttribute("pay_commodity",commodity);

        return "pay";
    }


    /**
     * 开通代理
     * @return
     */
    @RequestMapping("/reg")
    public String reg(Agents regAgent,String paytype){
        if(true){
            return "index";
        }
        //获取站长信息
        if(! getIndexInfo()){
            return "err";
        }
        if(regAgent != null && regAgent.getPassword() != null && regAgent.getAccount() != null && paytype != null){
            Agents system_admin = (Agents) MemCache.get("system_admin");
            //开通代理
            Agents user_agent = (Agents) request.getSession().getAttribute("agent");
            regAgent.setParentId(user_agent.getId());
            if(user_agent.getAgentPrice() == 0 || user_agent.getAgentPrice() < 0){
                //免费开通

                //添加
                agentsService.createAgent(regAgent,user_agent.getId());

                //记录日志
                reglogService.saveLog(regAgent.getId()+"#free",0);


                return "redirect:/reg.html";

            }else{
                //收费开通
                String no = System.currentTimeMillis()+"";
                Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
                System.out.println("提交代理订单："+no);
                regAgent.setMoney(user_agent.getMoney());
                regAgent.setId(user_agent.getId());
                MemCache.put("regAgent_"+no,regAgent);
                MemCache.put("agentPrice_"+no,user_agent.getAgentPrice());
                    return "redirect:http://zm921.com:82/pay/epayapi.php?no="+no+"&name="+user_agent.getDomain()+"-001&money="+user_agent.getAgentPrice()+"&type="+paytype+"&url="+config.get("pay_url").toString()+"&id="+config.get("pay_id").toString()+"&key="+config.get("pay_key").toString();

            }
        }
        return "reg";
    }




    @RequestMapping("/checkAccount")
    @ResponseBody
    public int checkAccount(String a){
        return agentsService.getAccountNum(a);
    }

    @RequestMapping("/checkDomain")
    @ResponseBody
    public int checkDomain(String d){
        return agentsService.getDomainNum(d);
    }


    /**
     * 付款完成开通代理的接口 由php调用
     * @param no
     * @return
     */
    @RequestMapping("/regPaySuccess")
    @ResponseBody
    public int regPaySuccess(String no){
        Agents regAgent = (Agents) MemCache.get("regAgent_"+no);
        Double price = (Double) MemCache.get("agentPrice_"+no);
        Agents system_admin = (Agents) MemCache.get("system_admin");
        if(no != null && regAgent != null && price != null){
            System.out.println("代理验证成功："+no);
            //添加
            //删除缓存
            MemCache.put("regAgent_"+no,null);
            MemCache.put("agentPrice_"+no,null);
            Agents tempAgent = new Agents();
            tempAgent.setId(regAgent.getId());
            tempAgent.setMoney(regAgent.getMoney()+price);
            agentsService.updateAgent(tempAgent);
            regAgent.setMoney(0.0);
            regAgent.setId(null);
            int result =0;
            //try{
                result = agentsService.createAgent(regAgent,system_admin.getId());
                reglogService.saveLog(regAgent.getId()+"#"+no,price);
            /*}catch (Exception e){
                result = 2;
            }*/

            return result;
        }else{
            System.out.println("代理验证失败："+no);
        }
        return 0;
    }

    /**
     * 单号查询
     * @param phone
     * @return
     */
    @RequestMapping("/express")
    public String express(String phone){
        if(phone != null){
            //查询
            List<Express> expressList = expressService.getList(phone);
            request.setAttribute("expressList",expressList);
        }
        return "express";
    }


    /**
     * 创建订单
     * @return
     */
    @RequestMapping(value="/createOrder",method= RequestMethod.POST)
    public String createOrder(Order order,Integer cid,Integer count,Integer ppid){
        String no = System.currentTimeMillis()+"";
        order.setNumber(no);
        order.setAgent(((Agents)request.getSession().getAttribute("agent")));
        Commodity commodity = new Commodity();
        commodity.setId(cid);
        order.setCount(count);
        order.setStatus(0);
        //价格
        Price price = priceService.getPriceById(ppid);
        order.setTotalPrice(price.getPrice() * count);
        order.setCommodity(commodity);
        order.setPid(price);
        orderService.createOrder(order);
        Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
        MemCache.put(order.getNumber(),order);



        return "redirect:http://zm921.com:82/pay2/epayapi.php?no="+order.getNumber()+"&name="+order.getAgent().getDomain()+"-cid:"+cid+"&money="+order.getTotalPrice()+"&type="+order.getPayType()+"&url="+config.get("pay_url").toString()+"&id="+config.get("pay_id").toString()+"&key="+config.get("pay_key").toString();
        //return "redirect:"+order.getNumber();
    }

    /**
     * 处理订单 php调用接口 对外不暴漏
     * @return
     */
    @RequestMapping("/orderPaySuccess")
    @ResponseBody
    public int orderPaySuccess(String no){
        Order order = (Order)MemCache.get(no);
        if(order == null){
            return 0;
        }
        Agents agent = order.getAgent();
        Commodity commodity = null;
        if(agent.getParentId() == 0){
            commodity = commodityService.getCommodity(agent.getId(),order.getCommodity().getId(),null);
            agent.setMoney(agent.getMoney() + (order.getCount() * commodity.getPrice()) );
            agentsService.updateAgent(agent);
        }else{
            commodity = commodityService.getCommodity(agent.getId(),order.getCommodity().getId(),agent.getParentId());
            isAddMoney(order.getAgent(),commodity,order.getCount(),true);
        }
        return orderService.updateOrder(1,order.getNumber());
    }

    /**
     * 购买成功 给父级分钱
     * @return
     */
    public void isAddMoney(Agents userAgent,Commodity commodity,Integer count,boolean isOne){
        if(userAgent != null){
            if(userAgent.getParentId() == 0){
                //如果是主站跳过
                userAgent.setMoney( userAgent.getMoney() + (commodity.getAgentPrice() * count));
                agentsService.updateAgent(userAgent);
                return;
            }
            double p =  0;
            if(isOne){
                p = commodity.getPrice()-commodity.getParentPrice();
            }else{
                p = commodity.getAgentPrice()-commodity.getParentPrice();
            }

            userAgent.setMoney( userAgent.getMoney()  + (p* count));
            agentsService.updateAgent(userAgent);
            userAgent.getParentId();
            Agents tagent = agentsService.getAgentsById(userAgent.getParentId());
            Commodity tcommodity;
            if(tagent.getParentId() == 0){
                tcommodity = commodityService.getCommodity(tagent.getId(),commodity.getId(),1);
            }else{
                tcommodity = commodityService.getCommodity(tagent.getId(),commodity.getId(),tagent.getParentId());
            }

            isAddMoney(tagent,tcommodity,count,false);
        }
    }

    /**
     * 进入中心
     * @return
     */
    @RequestMapping("/start")
    public String start(String iccid,String d){

        Agents agent = (Agents) request.getSession().getAttribute("agent");
        if(agent == null){
            return "redirect:/index";
        }
        if(iccid != null){
            Map<String,Object> phoneMap = phoneCardService.getPhoneCardByIccid(iccid);
            if(phoneMap == null){
                request.setAttribute("start_note","卡号输入错误！");
                if(d!=null){
                    request.setAttribute("diy","ok");
                }
                return "index";
            }

            request.getSession().setAttribute("phoneCard",phoneMap);
            if(d != null){
                return "redirect:/start?d=t";
            }else{
                return "redirect:/start";
            }
        }else{
            Map<String,Object> phoneMap = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
            if(phoneMap == null){
                if(d != null){
                    return "redirect:/index?d=true";
                }else{
                    return "redirect:/index";
                }

            }
            List<Feedback> feedbackLIst = feedbackService.getMyFeedback(phoneMap.get("iccid").toString());
            int feedCount = 0;
            for(Feedback feedback:feedbackLIst){
                if(Integer.parseInt(feedback.getStatus().toString())==1){
                    feedCount++;
                }
            }
            request.setAttribute("feedCount",feedCount);
            phoneMap = phoneCardService.getPhoneCardByIccid(phoneMap.get("iccid").toString());
            request.getSession().setAttribute("phoneCard",phoneMap);
            Map<String,Object> phoneInfo = phoneCardService.getPhoneCardByMsisdn(phoneMap.get("msisdn").toString());
            if(phoneInfo.get("phone") == null){
                request.setAttribute("grant","true");
            }else{
                request.setAttribute("grant","false");
            }
            if(d != null){
                return "start2";
            }else{
                return "start";
            }
        }
    }

    /**
     * 套餐列表
     * @return
     */
    @RequestMapping("/setmeal")
    public String setmeal(Integer setmeal,String status,String d){
        Agents agent = (Agents) request.getSession().getAttribute("agent");
        if(agent == null){
            if(d != null){
                return "redirect:/index?d=true";
            }
            return "redirect:/index";
        }
        Map<String,Object> phoneMap = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneMap == null){
            if(d != null){
                return "redirect:/index?d=true";
            }
            return "redirect:/index";
        }
        if(setmeal == null){
            List<Commodity> setmealList = commodityService.getClassCommodity(agent.getId(),(Integer)phoneMap.get("pcid"),null,null);
            if(setmealList.size() < 1){
                setmealList = null;
            }
            request.setAttribute("setmealList",setmealList);
            if(d != null){
                return "setmeal2";
            }
            int pcid = Integer.parseInt(phoneMap.get("pcid").toString());

            request.setAttribute("pclass",pclassService.getPclassById(pcid));
            return "setmeal";

        }else{
            //创建订单

            boolean isNow = status.indexOf("down") == -1;
            Price price = priceService.getPriceByAidAndCid(agent.getId(),setmeal);
            String no = System.currentTimeMillis()+"";
            Order order = new Order();
            String type = "";
            if(d != null){
                order.setPayType("other");
            } else if(isNow){
                //当月生效
                order.setPayType("now");
                type = "当月生效";
                //request.setAttribute("statusType",type);
            }else{
                //次月生效
                order.setPayType("down");
                type = "次月生效";
                //request.setAttribute("statusType",type);
            }
            order.setNumber(no);
            order.setXdPhone(phoneMap.get("iccid").toString());
            order.setStatus(0);
            order.setCount(1);
            int pcid = Integer.parseInt(phoneMap.get("pcid").toString());
            if(pcid == 4){
                order.setSfid(String.valueOf(CoreFunction.ydQuery(phoneMap.get("msisdn").toString())));
            }
            order.setPid(price);
            order.setTotalPrice(price.getPrice());
            order.setAgent(agent);

            if(request.getSession().getAttribute("address") == null){
                if(d != null){
                    return "redirect:/index?d=true";
                }
                return "redirect:/index";
            }
            order.setXdAddress(request.getSession().getAttribute("address").toString());
            Commodity commodity = new Commodity();
            commodity.setId(setmeal);
            order.setCommodity(commodity);
            orderService.createOrder(order);

            Commodity tc = commodityService.getCommodity(agent.getId(),price.getCommodity().getId(),null);

            Map<String,String> mm = new HashMap<>();
            String error = "";
            try{
                SybPayService service = new SybPayService();

                BigDecimal c = BigDecimal.valueOf(price.getPrice());
                BigDecimal x = BigDecimal.valueOf(100);
                long b = c.multiply(x).longValue();

                Map<String, String> map = service.pay(b, no, "W02", "物联卡流量充值", "暂无备注", request.getSession().getAttribute("openid").toString(), "123","http://www.kelangtongxin.com/pay/setMealPaySuccess","","","","");
                String payinfo = map.get("payinfo");
                net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(payinfo);

                if(payinfo == null){
                    System.out.println("发起支付时出现错误："+map.get("retmsg"));
                    System.out.println(map.toString());
                    //request.setAttribute("payinfo","error");
                    error = "ok";
                }else{
                    //request.setAttribute("tc",tc);
                    //request.setAttribute("no",no);
                    mm = jsonObject;
                    //request.setAttribute("payinfo",mm);
                }
            }catch (Exception e){
                System.out.println("创建订单失败,openid："+request.getSession().getAttribute("openid"));
                //request.setAttribute("payinfo","error");
                error = "ok";
            }
            Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");

            try {
                if(d != null){
                    return "redirect:http://www."+config.get("domain").toString()+"/paying?d=t&tname="+ URLEncoder.encode(tc.getName(),"UTF-8") +"&price="+tc.getPrice()+"&type="+URLEncoder.encode(type,"UTF-8")+"&domain="+agent.getDomain()+"&appId="+mm.get("appId")+"&timeStamp="+mm.get("timeStamp")+"&nonceStr="+mm.get("nonceStr")+"&p="+mm.get("package")+"&signType="+mm.get("signType")+"&paySign="+mm.get("paySign")+"&error="+error;
                }else{
                    return "redirect:http://www."+config.get("domain").toString()+"/paying?tname="+ URLEncoder.encode(tc.getName(),"UTF-8") +"&price="+tc.getPrice()+"&type="+URLEncoder.encode(type,"UTF-8")+"&domain="+agent.getDomain()+"&appId="+mm.get("appId")+"&timeStamp="+mm.get("timeStamp")+"&nonceStr="+mm.get("nonceStr")+"&p="+mm.get("package")+"&signType="+mm.get("signType")+"&paySign="+mm.get("paySign")+"&error="+error;
                }

            }catch (Exception e){
                return "";
            }
        }
    }


    @RequestMapping("/paying")
    public String paying(String d,String error,String tname,String price,String type,String domain,String appId,String timeStamp,String nonceStr,String p,String signType,String paySign){
        Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
        if(domain == null){
            return "redirect:http://baidu.com";
        }

        if(error.equals("ok")){
            request.setAttribute("payinfo","error");
            return "olpay";
        }
        if(d != null){
            request.setAttribute("diy","ok");
        }

        Map<String,String> payinfo = new HashMap<>();
        payinfo.put("appId",appId);
        payinfo.put("timeStamp",timeStamp);
        payinfo.put("nonceStr",nonceStr);
        payinfo.put("package",p);
        payinfo.put("signType",signType);
        payinfo.put("paySign",paySign);
        request.setAttribute("payinfo",payinfo);
        request.setAttribute("tname",tname);
        request.setAttribute("type",type);
        request.setAttribute("price",price);
        request.setAttribute("domain",domain);
        request.setAttribute("domain2",config.get("domain").toString());

        return "olpay";
    }

    @RequestMapping("/checkNo")
    @ResponseBody
    public int checkNo(String no){
        Order order =  orderService.getOrderByNo(no);
        if(order == null){
            return -1;
        }
        return order.getStatus();
    }


    /**
     *
     */

    /**
     * 获取本站信息，如果本站不存在则返回假。
     * @return
     */
    public boolean getIndexInfo(){

        String domain = request.getServerName();
        String[] strArray = domain.split("\\.");

        //根据名字
        Agents agent = agentsService.getAgents(strArray[0]);
        if(agent == null){
            request.setAttribute("errorText","该站点未开通");
            return false;
        }
        request.getSession().setAttribute("config",MemCache.get("website_config"));
        request.getSession().setAttribute("agent",agent);
        Agents system_admin = (Agents) MemCache.get("system_admin");
        MemCache.put("website_class",pclassService.getPclass(null,null));
//        MemCache.put("website_class",pclassService.getPclass(system_admin.getId(),agent.getId()));
        return true;
    }


    /**
     * 检查参数，如果参数错误返回假
     * @return
     */
    public boolean checkParam(String... param){

        for(String p : param){
            if(p == null){
                request.setAttribute("errorText","非法请求:1001");
                return false;
            }
        }
        return true;
    }


    /**
     * 字符串转整型
     * @param param
     * @return
     */
    public Integer[] stringToInteger(String... param){
        Integer[] integers = new Integer[param.length];
        for(int i = 0;i<param.length;i++){
            System.out.println(param[i]);
            try{
                integers[i] = Integer.parseInt(param[i]);
            }catch (Exception e){
                //参数非法
                System.out.println(e.getMessage());
                request.setAttribute("errorText","非法请求:1002");
                return null;
            }
        }
        return integers;
    }

    @RequestMapping("/gofreecard")
    public String gofreecard(){
        Map<String,Object> phoneMap = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneMap == null){
            return "redirect:/index";
        }
        if(freeCardService.checkData(Integer.parseInt(phoneMap.get("id").toString())) > 0){
            request.setAttribute("isHave","ok");
        }
        return "freecard";
    }

    @RequestMapping("/freecard")
    @ResponseBody
    public int freeCard(String i,String name,String phone,String address){
        Map<String,Object> phoneMap = phoneCardService.getPhoneCardByIccid(i);
        if(phoneMap == null){
            return 0;
        }

        if(phoneMap.get("cid")==null&&phoneMap.get("upcid")==null && phoneMap.get("ccid")==null){
            return 0;
        }
        Integer pcid = Integer.parseInt(phoneMap.get("pcid").toString());
        int count = pclassService.checkFreeCard(pcid);
        if(count > 0){
            int result = 0;
            try {
                Map<String,Object> saveFreeCard = new HashMap<String,Object>();
                saveFreeCard.put("name",name);
                saveFreeCard.put("phone",phone);
                saveFreeCard.put("address",address);
                saveFreeCard.put("pid",phoneMap.get("id"));
                result = freeCardService.saveData(saveFreeCard);
            }catch (Exception e){
                System.out.println("补卡失败:"+e.getMessage());
            }

            return result;
        }
        return 0;
    }


    @RequestMapping("/status")
    @ResponseBody
    public Object stauts(String i){

        return CoreFunction.ydInfo(i);
    }

    @RequestMapping("/private/open")
    @ResponseBody
    public int privateOpen(String iccid){

        Map<String,Object> map = phoneCardService.getPhoneCardByIccid(iccid);
        String m = map.get("msisdn").toString();
        String a = CoreFunction.ydInfo(m);
        int result = -1;
        if(a.equals("库存")){
            result = CoreFunction.ydFunction(m,2);
        }else{
            result = CoreFunction.ydFunction(m,1);
        }
        return result;
    }

    @RequestMapping("/private/stop")
    @ResponseBody
    public int privateStop(String iccid){

        Map<String,Object> map = phoneCardService.getPhoneCardByIccid(iccid);
        String m = map.get("msisdn").toString();
        String a = CoreFunction.ydInfo(m);
        int result = CoreFunction.ydFunction(m,0);
        return result;
    }


    @RequestMapping("/test")
    @ResponseBody
    public Object tests(String i,Integer t) throws IOException {

        String xie = "";
        //补卡套餐
        List<String> phones = phoneCardService.getTempPhones();

        for(String str:phones){
            Map<String,Object> maps = phoneCardService.getPhoneCardByIccid(str);

            String m = maps.get("msisdn").toString();

            double d = CoreFunction.ydQuery(m);

            if(d > 51200){
                CoreFunction.ydFunction(m,0);
                xie += "\r\n 卡号："+str+"；用量："+d+",超过50G已经停机";
            }else{
                xie += "\r\n 卡号："+str+"；用量："+d;
            }

        }


        String path = "e:\\qhl.txt";
        File file = new File(path);
        if(!file.exists()){
            file.getParentFile().mkdirs();
        }
        file.createNewFile();

        // write
        FileWriter fw = new FileWriter(file, true);
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write(xie);
        bw.flush();
        bw.close();
        fw.close();

        // read
        FileReader fr = new FileReader(file);
        BufferedReader br = new BufferedReader(fr);
        String str = br.readLine();
        System.out.println(str);



      //取消本月套餐的
      /*List<String> phones = phoneCardService.getTempPhones();
        for(String str : phones){


            int b = phoneCardService.取消次月套餐(str);
            System.out.println(b);
        }

        double a = CoreFunction.dxQuery("1410344516160");
        System.out.println("流量"+a);*/
        return 1;
        //return  CoreFunction.ydFunction2(i,t);

    }

    @RequestMapping("/我想查/{name}")
    @ResponseBody
    public String test(@PathVariable String name){
        String userAddress = name;
        if(userAddress != null){
            Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
            String[] noaddress = config.get("noaddress").toString().split("#");
            for(String s : noaddress){
                if(userAddress.indexOf(s) != -1){
                    return "禁用";
                }
            }
        }

        return "通过";
    }

    @RequestMapping("/wxpublic/verify_wx_token")
    @ResponseBody
    public String verifyWXToken(HttpServletRequest request) throws AesException {
        String msgSignature = request.getParameter("signature");
        String msgTimestamp = request.getParameter("timestamp");
        String msgNonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
        if(msgSignature == null){
            return "hello";
        }
        if (WXPublicUtils.verifyUrl(msgSignature, msgTimestamp, msgNonce)) {
            return echostr;
        }
        return null;
    }

    @RequestMapping("/wxpublic/result/{diy}")
    public String wxResult(String code,String state,@PathVariable String diy){
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("appid","wx09593ca188ca98a0"));
        paramList.add(new BasicNameValuePair("secret","95b2fc8ea98f1711ff2513de0dccc8f7"));
        paramList.add(new BasicNameValuePair("code",code));
        paramList.add(new BasicNameValuePair("grant_type","authorization_code"));

        String openid = "";
        try {
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.weixin.qq.com/sns/oauth2/access_token",paramList,false);
            openid = (String) jsonObject.get("openid");
            request.getSession().setAttribute("openid",openid);

        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        if(diy != null && diy.equals("ok")){
            return "redirect:http://"+ state +"."+configMap.get("domain").toString()+"/index?d=t&o="+openid;
        }
        return "redirect:http://"+ state +"."+configMap.get("domain").toString()+"/index?o="+openid;
    }


    @RequestMapping("/grant")
    public String grant(String d){
        Map<String,Object> map = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(map == null){
            return "redirect:/index";
        }
        if(d != null){
            request.setAttribute("diy","ok");
        }
        return "grant";
    }

    /**
     * 实名认证
     * @return
     */
    @RequestMapping("/grantSubmit")
    @ResponseBody
    public int grantSubmit(String name,String phone,String sfid,String code){
        if(phone == null || code == null){
            //参数不正确
            return -1;
        }
        Map<String,Object> phoneInfo = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneInfo == null){
            //未获取到卡信息
            return -2;
        }
        String phoneCode = (String) phoneInfo.get("phoneCode");
        if(phoneCode == null){
            //没有获取验证码
            return -3;
        }else if(phoneCode.equals(code)){
            //验证成功
            Map<String,Object> updatePhone = new HashMap<String,Object>();
            updatePhone.put("id",phoneInfo.get("id"));
            updatePhone.put("name",name);
            updatePhone.put("phone",phone);
            updatePhone.put("sfid",sfid);
            int i = 0;
            try{
                i = phoneCardService.update(updatePhone);
            }catch (Exception e){
                return -10;//重复认证
            }
            return i;
        }else{
            //验证码错误
            return -4;
        }

    }

    @RequestMapping("/address")
    @ResponseBody
    public int address(String address){
        request.getSession().setAttribute("address",address);
        return 1;
    }

    /**
     * 流量查询
     * @return
     */
    @RequestMapping("/query")
    public String dxQuery(){
        Agents agetnAdmin = (Agents) MemCache.get("system_admin");
        String p = "";
        Map<String,Object> map = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(map == null){
            return "redirect:/index";
        }
        String s = "";
        if(map == null){
            return "-1";
        }

        p = map.get("iccid").toString();
        Map<String,Object> phoneInfo = phoneCardService.getPhoneCardByMsisdn(p);
        if(phoneInfo.get("phone") == null){
            request.setAttribute("setmeal","noInfo");
            return "query";
        }
        double outData = 0;
        int pcid = Integer.parseInt(phoneInfo.get("pcid").toString());
        if(map.get("cid")==null){
            request.setAttribute("setmeal",null);
            if(map.get("upcid") != null){
                Commodity upcommodity = commodityService.getCommodity(agetnAdmin.getId(),Integer.parseInt(map.get("upcid").toString()),null);
                request.setAttribute("upsetmeal",upcommodity);
            }
            return "query";
        }
        switch (pcid){
            case 3:
                String[] r = BaseHlper.sign("queryTraffic", p, null);
                try {
                    List<NameValuePair> params = new ArrayList<NameValuePair>();
                    params.add(new BasicNameValuePair("method","queryTraffic"));
                    params.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
                    params.add(new BasicNameValuePair("action","ADD"));
                    params.add(new BasicNameValuePair("access_number",p));
                    params.add(new BasicNameValuePair("passWord",r[0]));
                    params.add(new BasicNameValuePair("sign",r[1]));
                    s = (String)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",params,true);
                }catch (Exception e){
                    return e.getMessage();
                }
                Map<String,Object> res = new HashMap<String,Object>();
                double resultData = Double.parseDouble(s.substring(s.indexOf("<TOTAL_BYTES_CNT>")+"<TOTAL_BYTES_CNT>".length(),s.indexOf("</TOTAL_BYTES_CNT>")-2));
                outData = resultData;
                break;
            case 4:
                double data = CoreFunction.ydQuery(p);
                if(data != -1){
                    Calendar tc = Calendar.getInstance();
                    tc.setTime(new Date());
                    tc.add(Calendar.MONTH,-1);
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
                    String lastStr = formatter.format(tc.getTime());
                    Date date = (Date) map.get("gotime");

                    Date date2 = new Date();
                    if(date.getMonth() != date2.getMonth()){
                        String upData = stringRedisTemplate.opsForValue().get("yd30w"+phoneInfo.get("msisdn").toString()+lastStr);
                        if(upData != null){
                            data = data + Double.parseDouble(upData);
                        }
                    }


                    outData = data - Double.parseDouble(map.get("old_data")!=null?map.get("old_data").toString():"0.0");
                }

                break;
            default:
                break;
        }
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        double xujia = Double.parseDouble(configMap.get("number").toString());

        Commodity commodity = commodityService.getCommodity(agetnAdmin.getId(),Integer.parseInt(map.get("cid").toString()),null);
        if(commodity != null && commodity.getName().indexOf("无限") != -1){
            commodity.setNote(null);
        }
        commodity.setImgUrl(outData/xujia+"M");
        request.setAttribute("setmeal",commodity);
        request.setAttribute("startenddata",phoneCardService.getStartEndDate(1,map.get("iccid").toString()));
        return "query";
    }

    /**
     * 反馈列表
     * @param note
     * @return
     */
    @RequestMapping("/feedback")
    public String feedback(String note){
        Map<String,Object> phoneCard = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneCard == null){
            return "redirect:/index";
        }
        if(note != null){
            feedbackService.addFeedback(phoneCard.get("iccid").toString(),note);
            return "redirect:/feedbackList";
        }

        return "feedback";
    }

    @RequestMapping("/feedbackList")
    public String feedbacklist (){
        Map<String,Object> phoneCard = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneCard == null){
            return "redirect:/index";
        }

        List<Feedback> feedbackList = feedbackService.getMyFeedback(phoneCard.get("iccid").toString());
        if(feedbackList.size()==0){
            feedbackList = null;
        }

        int count = orderService.getByPhoneCount(phoneCard.get("iccid").toString());
        if(count > 0){
            request.setAttribute("okfankui","false");
        }else{
            request.setAttribute("okfankui","true");
        }
        request.setAttribute("feedbackList",feedbackList);
        return "feedback_list";
    }

    @RequestMapping("/feedbackView")
    public String feedbackView (Integer id){
        Map<String,Object> phoneCard = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneCard == null){
            return "redirect:/index";
        }
        Feedback feedback = feedbackService.getFeedback(id);
        if(Integer.parseInt(feedback.getStatus().toString()) != 0){
            feedback.setStatus(0);
            feedbackService.updateFeedback(feedback);
        }
        if(feedback.getAid().equals(phoneCard.get("iccid").toString())){
            request.setAttribute("feedback",feedback);
        }
        return "feedback_view";
    }

    @RequestMapping("/sendCode")
    @ResponseBody
    public String sendCode(String phone,String code){
        Map<String,Object> phoneInfo = (Map<String, Object>) request.getSession().getAttribute("phoneCard");

            String num = CoreFunction.sendCode(phone);
            phoneInfo.put("phoneCode",num);
            request.getSession().setAttribute("phoneCard",phoneInfo);
            return "success";
    }


    @RequestMapping("/getCode")
    public void getCoce(HttpServletResponse response) throws Exception{

        Map<String,Object> phoneInfo = (Map<String, Object>) request.getSession().getAttribute("phoneCard");
        if(phoneInfo == null){
            return;
        }

        response.setContentType("image/jpeg");
        //禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        ImgCode vCode = new ImgCode(100,30,5,10);
        phoneInfo.put("code",vCode.getCode());
        request.getSession().setAttribute("phoneCard",phoneInfo);
        vCode.write(response.getOutputStream());

    }


}
