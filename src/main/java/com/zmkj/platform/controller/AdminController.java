package com.zmkj.platform.controller;

import com.alibaba.fastjson.JSON;
import com.zmkj.platform.common.MemCache;
import com.zmkj.platform.common.PathValue;
import com.zmkj.platform.entity.*;
import com.zmkj.platform.service.*;
import com.zmkj.platform.util.CoreFunction;
import com.zmkj.platform.util.ImgUpload;
import com.zmkj.platform.util.PoiTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private FreeCardService freeCardService;

    @Autowired
    private TempOrderService tempOrderService;

    @Autowired
    private CostService costService;

    @Autowired
    private ExpressService expressService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private AgentsService agentsService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private PclassService pclassService;

    @Autowired
    private CommodityService commodityService;

    @Autowired
    private PriceService priceService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ExtractService extractService;

    @Autowired
    private  PhoneCardService phoneCardService;

    @Autowired
    private PriceLogService priceLogService;

    /**
     * 后台登录
     * @return
     */
    @RequestMapping({"","/"})
    public String admin(){
        if(checkHaveLogin()){
            return "redirect:/admin/main";
        }
        return "login";
    }

    /**
     * 后台主页
     * @return
     */
    @RequestMapping("/main")
    public String main(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        List<Agents> agentsList =  agentsService.getMyAgents(user_agent.getId());
        Agents nowAgent = agentsService.getAgentsById(user_agent.getId());
        List<Order> orderList = orderService.getMyOrder(user_agent.getId());
        int agentCount = agentsList.size();
        double money = nowAgent.getMoney();
        int orderCount = orderList.size();
        double todayMoney = agentsService.getTodayMoney(user_agent.getId());
        int phoneCardByCount = phoneCardService.phoneCardByCount(user_agent.getId());
        request.setAttribute("phoneCardByCount",phoneCardByCount);
        request.setAttribute("agentCount",agentCount);
        request.setAttribute("money",money);
        request.setAttribute("orderCount",orderCount);
        request.setAttribute("todayMoney",todayMoney);
        return "admin_main";
    }

    /**
     * 套餐列表
     * @return
     */
    @RequestMapping("/commodityList")
    public String commodityList(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }

        return "admin_commodity_list";
    }


    /**
     * 获取添加套餐的sort
     * @return
     */
    @RequestMapping("/getAddCommoditySort")
    @ResponseBody
    public int getAddCommoditySort(Integer pcid){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return 0;
        }
        Agents system_admin = (Agents)MemCache.get("system_admin");
        Agents user_agent = (Agents)request.getSession().getAttribute("user_agent");
        Integer parent_id ;
        if(user_agent.getParentId() == 0){
            parent_id = user_agent.getId();
        }else{
            parent_id = user_agent.getParentId();
        }
        List<Commodity> comList = commodityService.getClassCommodity(user_agent.getId(),pcid,parent_id,system_admin.getId());
        if(comList == null || comList.size() == 0){
            return 1;
        }else{
            return comList.get(comList.size()-1).getSort()+1;
        }
    }

    /**
     * 分配套餐
     * @param id
     * @return
     */
    @RequestMapping("/setMeal")
    public String setMeal(Integer id){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(id == null){
            return "redirect:/admin/main";
        }
        Agents agent = agentsService.getAgentsById(id);
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(Integer.parseInt(agent.getParentId().toString()) != Integer.parseInt(user_agent.getId().toString())){
            return "redirect:/admin/main";
        }
        List<Pclass> pcList = pclassService.getPclass(null,user_agent.getId());
        List<Commodity> commodityList = commodityService.getClassCommodity(user_agent.getId(),pcList.get(0).getId(),null,null);
        request.setAttribute("temp_pclass",pcList);
        request.setAttribute("temp_commodity",commodityList);

        request.setAttribute("tempAgent",agent);
        return "admin_agent_setmeal";
    }



    /**
     * 添加套餐
     * @return
     */
    @RequestMapping("/addCommodity")
    public String addCommodity(Commodity commodity,MultipartFile img[]){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Map<String,String> configMap = (Map<String, String>) MemCache.get("website_config");
        request.setAttribute("config",configMap);
        Agents user_agent = (Agents)request.getSession().getAttribute("user_agent");
        if(img != null){
            //添加

            commodity.setAgent(user_agent);
            commodity.setHaveImg(0);

            commodityService.saveCommodity(commodity);
            priceService.savePrice(user_agent,commodity);

            return "redirect:/admin/commodityList";
        }
        Agents system_admin = (Agents)MemCache.get("system_admin");

        List<Pclass> pcList = pclassService.getPclass(system_admin.getId(),user_agent.getId());
        request.setAttribute("temp_pclass",pcList);
        //获取当前分类下商品的最大sort

        Integer parent_id ;
        if(user_agent.getParentId() == 0){
            parent_id = user_agent.getId();
        }else{
            parent_id = user_agent.getParentId();
        }
        if(pcList.size() < 1){
            return "redirect:/addClass";
        }
        List<Commodity> comList = commodityService.getClassCommodity(user_agent.getId(),pcList.get(0).getId(),parent_id,system_admin.getId());
        if(comList == null || comList.size() == 0){
            request.setAttribute("sort",1);
        }else{
            request.setAttribute("sort",comList.get(comList.size()-1).getSort()+1);
        }

        return "admin_commodity_add";
    }


    /**
     * 订单列表
     * @return
     */
    @RequestMapping("/orderList")
    public String orderList(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        Agents system_agent = (Agents)MemCache.get("system_admin");
        Integer parent_id;
        if(agent.getParentId() == 0){
            parent_id = agent.getId();
        }else{
            parent_id = agent.getParentId();
        }
        List<Commodity> commList = commodityService.getAllCommodity(agent.getId(),parent_id,system_agent.getId());
        List<Commodity> tempList = new ArrayList<Commodity>();
        for(Commodity commodity : commList){
            if(commodity.getAgent().getId() == agent.getId()){
                tempList.add(commodity);
            }
        }
        request.setAttribute("commodityList",tempList);
        return "admin_order_list";
    }

    /**
     * 获取订单列表
     * @return
     */
    @RequestMapping("/getOrderListData")
    @ResponseBody
    public String getOrderListData(String a){
        if(!checkHaveLogin()){
            return "非法请求";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(user_agent.getParentId() == 0){
            List<Order> orderList = orderService.getAllOrder(user_agent.getId());
            return JSON.toJSONString(orderList);
        }else{
            if(a != null){
                List<Order> orderList = orderService.getMyOrder(user_agent.getId());
                return JSON.toJSONString(orderList);
            }else{
                List<Order> orderList = orderService.getMyOrder(user_agent.getId());
                List<Order> tempList = new ArrayList<Order>();
                //只处理自己的
                /*for(Order order : orderList){
                    if(order.getCommodity().getAgent().getId() == user_agent.getId()){
                        tempList.add(order);
                    }
                }*/
                return JSON.toJSONString(tempList);
            }
        }

    }

    /**
     * 修改订单状态
     * @param no
     * @return
     */
    @RequestMapping("/updateOrderStatus")
    @ResponseBody()
    public int updateOrderStatus(String no){
        if(!checkHaveLogin()){
            return 0;
        }
        return orderService.updateOrder(2,no);
    }

    /**
     * 导出未处理订单
     * @return
     */
    @RequestMapping("/outData")
    public String outDate(Integer status,Integer cid){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(status == null){
            return "redirect:/admin/orderList";
        }

        //查出订单列表
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        List<Order> orderList ;
        if(user_agent.getParentId() == 0){
            orderList = orderService.getAllOrderByStatus(status,user_agent.getId(),cid);
        }else{
            orderList = orderService.getMyOrderByStatus(status,user_agent.getId(),cid);
        }
        if(orderList.size() < 1){
            return "redirect:/admin/orderList";
        }
        String no = System.currentTimeMillis()+"";

        //设置顶部ABCD
        List<String> sheetName = new ArrayList<>();
        sheetName.add("A");
        sheetName.add("B");
        sheetName.add("C");
        sheetName.add("D");
        sheetName.add("E");
        sheetName.add("F");
        sheetName.add("G");
        sheetName.add("H");
        sheetName.add("I");
        sheetName.add("J");
        sheetName.add("K");

        //对应ABCD标题
        String[] title = {"单号","商品名称","姓名","手机号","身份证号","地址","数量","实付金额","照片地址1","照片地址2","照片地址3"};

        //创建
        PoiTool.createExcelXls(PathValue.OUTINFO+"/"+no+".xls", sheetName, title);

        //创建实体
        List<Map<String,String>> orderMap = new ArrayList<Map<String,String>>();

        int i = 0;
        for(Order order : orderList){
            Map<String,String> map=new HashMap<String,String>();
            map.put("单号", order.getNumber());
            map.put("商品名称",order.getCommodity().getName());
            map.put("姓名", order.getXdName());
            map.put("手机号",order.getXdPhone());
            map.put("身份证号",order.getSfid());
            map.put("地址",order.getXdAddress());
            map.put("数量",order.getCount()!=null?order.getCount().toString():"未获取到");
            map.put("实付金额",order.getTotalPrice()!=null?order.getTotalPrice().toString():"未获取到");
            map.put("照片地址1",order.getImgUrl()!=null?"http://www.tz8860.com"+order.getImgUrl():"无");
            map.put("照片地址2",order.getImgUrl2()!=null?"http://www.tz8860.com"+order.getImgUrl2():"无");
            map.put("照片地址3",order.getImgUrl3()!=null?"http://www.tz8860.com"+order.getImgUrl3():"无");
            orderMap.add(map);
            orderService.updateOrder(2,order.getNumber());
        }

        //写入
        try {
            PoiTool.writeToExcelXls(PathValue.OUTINFO+"/"+no+".xls", sheetName.get(0), orderMap);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return "redirect:/upload/outinfo/"+no+".xls";



    }


    @RequestMapping("/outfreecard")
    public String outFreeCard(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }


        String no = System.currentTimeMillis()+"";
        List<Map<String,Object>> freeListMap = freeCardService.getDataByStatus(0);
        if(freeListMap == null || freeListMap.size() == 0){
            return "redirect:/admin/main";
        }
        //设置顶部ABCD
        List<String> sheetName = new ArrayList<>();
        sheetName.add("A");
        sheetName.add("B");
        sheetName.add("C");

        //对应ABCD标题
        String[] title = {"收件人","手机号","收件地址"};

        //创建
        PoiTool.createExcelXls(PathValue.OUTINFO+"/"+no+".xls", sheetName, title);

        //创建实体
        List<Map<String,String>> outMap = new ArrayList<Map<String,String>>();

        int i = 0;

        for(Map<String,Object> map : freeListMap){
            Map<String,String> tempMap =new HashMap<String,String>();
            tempMap.put("收件人", map.get("name").toString());
            tempMap.put("手机号",map.get("phone").toString());
            tempMap.put("收件地址", map.get("address").toString());
            outMap.add(tempMap);
            freeCardService.updateData(1,Integer.parseInt(map.get("id").toString()));
        }

        //写入
        try {
            PoiTool.writeToExcelXls(PathValue.OUTINFO+"/"+no+".xls", sheetName.get(0), outMap);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/upload/outinfo/"+no+".xls";
    }


    /**
     * 编辑代理套餐
     * @return
     */
    @RequestMapping("/editCommodityAgent")
    public String editCommodityAgent(Price price,Integer aid,Integer cid){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents agent = agentsService.getAgentsById(aid);
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");

        if((int)agent.getParentId() != (int)user_agent.getId()){
            return "redirect:/admin/main";
        }
        if(price != null && price.getPrice() != null && price.getParentPrice() != null){
            //编辑
            if(price.getPrice() > price.getParentPrice()){
                Price temp_price = priceService.getPriceByAidAndCid(aid,cid);
                Price my_price = priceService.getPriceByAidAndCid(user_agent.getId(),cid);
                if(my_price.getParentPrice() == null || my_price.getParentPrice() < price.getParentPrice()){
                    price.setId(temp_price.getId());
                    priceService.updatePrice(price);
                    double upPrice = 0;
                    if(price.getParentPrice() - temp_price.getParentPrice() > 0){
                        upPrice = price.getParentPrice() - temp_price.getParentPrice();
                    }
                    List<Agents> agentsList = agentsService.getMyAgents(aid);
                    updatePrices(agentsList,cid,upPrice);
                }
            }
            return "redirect:/admin/setMeal?id="+aid;
        }else{
            Commodity commodity = commodityService.getCommodity(aid,cid,null);
            Commodity mycommodity = commodityService.getCommodity(user_agent.getId(),cid,null);
            request.setAttribute("aid",aid);
            request.setAttribute("cid",cid);
            request.setAttribute("temp_commodity",commodity);
            request.setAttribute("temp_mycommodity",mycommodity);
        }
        return "admin_commodity_edit_agent";
    }

    /**
     * 商品编辑
     * @return
     */
    @RequestMapping("/editCommodity")
    public String editCommodity(Commodity commodity,MultipartFile img[],String edit){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }

        Map<String,String> configMap = (Map<String, String>) MemCache.get("website_config");
        request.setAttribute("config",configMap);
        Agents system_admin = (Agents)MemCache.get("system_admin");
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");

        Commodity temp_commodity = commodityService.getCommodity(user_agent.getId(),commodity.getId(),null);
        request.setAttribute("temp_commodity",temp_commodity);
        if(edit != null && edit.equals("zhu")){
            commodityService.editCommodity(commodity);
            Price price = priceService.getPriceByAidAndCid(user_agent.getId(),commodity.getId());
            price.setPrice(commodity.getPrice());
            priceService.updatePrice(price);
            return "redirect:/admin/commodityList";
        }else if(edit != null && edit.equals("fen")){
            Price price = priceService.getPriceByAidAndCid(user_agent.getId(),commodity.getId());
            if(price.getParentPrice() > commodity.getPrice()){
                return "redirect:/admin/commodityList";
            }
            price.setPrice(commodity.getPrice());
            priceService.updatePrice(price);
            return "redirect:/admin/commodityList";
        }


        //没找到跳转到列表
        if(temp_commodity == null){
            return "redirect:/admin/commodityList";
        }
        List<Pclass> pcList = pclassService.getPclass(system_admin.getId(),user_agent.getId());
        request.setAttribute("temp_pclass",pcList);
        return "admin_commodity_edit";
    }

    /**
     * 删除商品
     * @param cid
     * @return
     */
    @RequestMapping("/deleteCommodity")
    @ResponseBody
    public int deleteCommodity(Integer cid,Integer aid){
        if(!checkHaveLogin()){

            return 0;
        }

        int i = commodityService.deleteCommodity(cid);
        i += priceService.deleteByCid(cid);
        return i;
    }

    /**
     * 删除商品
     * @param cid
     * @return
     */
    @RequestMapping("/deleteCommodity2")
    @ResponseBody
    public int deleteCommodity2(Integer cid,Integer aid){
        if(!checkHaveLogin()){

            return 0;
        }

        Price price = priceService.getPriceByAidAndCid(aid,cid);

        return priceService .deletePrice(price.getId());
    }

    /**
     * 递归算出给子集下面代理涨价
     * @param upPrice
     */
    private void updatePrices(List<Agents> agentsList, Integer cid, double upPrice){
        if(agentsList != null){
            for(Agents a : agentsList){
                Price price = priceService.getPriceByAidAndCid(a.getId(),cid);
                if(price != null){
                    price.setPrice(price.getPrice()+upPrice);
                    price.setParentPrice(price.getParentPrice()+upPrice);
                    priceService.updatePrice(price);
                    List<Agents> tagentList = agentsService.getMyAgents(a.getId());
                    updatePrices(tagentList,cid,upPrice);
                }
            }
        }
    }

    /**
     * 代理列表
     * @return
     */
    @RequestMapping("/agentList")
    public String agentList(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        request.setAttribute("configMap",configMap);
        return "admin_agent_list";
    }



    /**
     * 获取我的代理列表
     * @return
     */
    @RequestMapping("/getMyAgentList")
    @ResponseBody
    public String getAgentList(){
        if(!checkHaveLogin()){
            return "非法请求";
        }
        //查找我的下级代理
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        List<Agents> myAgentList = agentsService.getMyAgents(user_agent.getId());
        return JSON.toJSONString(myAgentList);
    }

    /**
     * 添加代理
     * @return
     */
    @RequestMapping("/addAgent")
    public String addAgent(Agents regAgent,String t){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        Agents system_agents = (Agents)MemCache.get("system_admin");
        if(regAgent.getAccount() != null && regAgent.getPassword() != null){
            //添加代理
            regAgent.setParentId(user_agent.getId());
            agentsService.createAgent(regAgent,user_agent.getId());
            return "redirect:/admin/addAgent?t=1";
        }
        if(t != null){
            request.setAttribute("alert","true");
        }

        return "admin_agent_add";
    }

    @RequestMapping("/deleteAgent")
    @ResponseBody
    public int deleteAgent(Integer id){
        if(!checkHaveLogin()){
            return 0;
        }
        return agentsService.deleteAgent(id);
    }

    /**
     * 提现申请
     * @return
     */
    @RequestMapping("/extract")
    public String extract(String s,Double money){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(user_agent.getParentId() == 0){
            return "redirect:/admin/main";
        }
        if(s != null){
            //提现申请

            user_agent = agentsService.getAgentsById(user_agent.getId());
            if(money > user_agent.getMoney()){
                return "admin_extract";
            }
            user_agent.setMoney(user_agent.getMoney()-money);
            Extract extract = new Extract();
            extract.setMoney(money);
            extract.setAgent(user_agent);
            extract.setStatus(0);
            extractService.save(extract);

            Agents updateAgent = new Agents();
            updateAgent.setId(user_agent.getId());
            updateAgent.setMoney(user_agent.getMoney());
            agentsService.updateAgent(updateAgent);
            user_agent = agentsService.getAgentsById(user_agent.getId());
            request.getSession().setAttribute("user_agent",user_agent);
            return "redirect:/admin/extractLog";
        }

        return "admin_extract";
    }

    /**
     * 更改提现状态
     * type 1代表完成提现
     * type 2代表退回提现
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateExtract")
    public int updateExtract(Integer eid,Integer type){
       if(!checkHaveLogin()){
            return 0;
        }
        return allExtractChange(eid,type);
    }


    public int allExtractChange(Integer eid,Integer type){
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(user_agent.getParentId() == 0 && eid != null && type != null){
            if(type == 1){
                return extractService.update(eid,1);
            }else if(type == 2){
                Extract extract = extractService.getById(eid);
                Integer aid = extract.getAgent().getId();
                if(extract.getStatus() != 0){
                    return -3;
                }
                Agents agents = agentsService.getAgentsById(aid);
                Agents tempAgent = new Agents();
                tempAgent.setId(aid);
                tempAgent.setMoney(agents.getMoney()+extract.getMoney());
                int result = 0;
                result = agentsService.updateAgent(tempAgent);
                if(result > 0){
                    return extractService.update(eid,2);//如果返回0则为资金退回 提现没有改好
                }else{
                    return -1;//-1代表资金退回失败，但提现状态也没有改变
                }
            }
        }
        return 0;
    }


    @RequestMapping("/allExtractChange")
    public String allExtractChangeRequest(Integer type){
        List<Extract> extractList = extractService.get();
        for(Extract extract : extractList){
            allExtractChange(extract.getId(),type);
        }
        return "redirect:/admin/extractLog";
    }

    @RequestMapping("/outAllExtract")
    public String outAllExtract(){
        //设置顶部ABCD
        List<String> sheetName = new ArrayList<>();
        sheetName.add("A");
        sheetName.add("B");
        sheetName.add("C");

        //对应ABCD标题
        String[] title = {"代理站名","提现金额","真实姓名","支付宝账号","申请时间"};

        long tiem = System.currentTimeMillis();

        //创建
        PoiTool.createExcelXls(PathValue.OUTINFO+"/oute"+tiem+".xls", sheetName, title);

        //创建实体
        List<Map<String,String>> orderMap = new ArrayList<Map<String,String>>();

        List<Extract> extractList = extractService.get();

        for(Extract extract : extractList){
            if(extract.getStatus() == 0){
                Map<String,String> map = new HashMap<String,String>();
                map.put("代理站名", extract.getAgent().getWebsiteName());
                map.put("提现金额",extract.getMoney().toString());
                map.put("真实姓名", extract.getAgent().gettName());
                map.put("支付宝账号", extract.getAgent().gettAccount());
                map.put("申请时间", extract.getCreateTime().toString());
                orderMap.add(map);
                allExtractChange(extract.getId(),1);
            }
        }

        //写入
        try {
            PoiTool.writeToExcelXls(PathValue.OUTINFO+"/oute"+tiem+".xls", sheetName.get(0), orderMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/upload/outinfo/oute" +tiem+".xls";
    }

    /**
     * 获取提现记录数据
     * @return
     */
    @ResponseBody
    @RequestMapping("/getExtractData")
    public String getExtractData(Integer aid){
        if(!checkHaveLogin()){
            return "非法请求";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(user_agent.getParentId() == 0){
            List<Extract> extractList = extractService.get();
            return JSON.toJSONString(extractList);
        }else if(aid != null){
            List<Extract> extractList = extractService.getByAid(aid);
            return JSON.toJSONString(extractList);
        }
        return "";
    }


    @RequestMapping("/outPriceLog")
    public String outPriceLog(Integer id){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }


        //设置顶部ABCD
        List<String> sheetName = new ArrayList<>();
        sheetName.add("A");
        sheetName.add("B");
        sheetName.add("C");
        sheetName.add("D");
        //对应ABCD标题
        String[] title = {"返利编号","订单编号","返利时间","细节详情"};

        long tiem = System.currentTimeMillis();

        //创建
        PoiTool.createExcelXls(PathValue.OUTINFO+"/"+tiem+".xls", sheetName, title);

        //创建实体
        List<Map<String,String>> orderMap = new ArrayList<Map<String,String>>();



        List<Map<String,Object>> logList = priceLogService.getMyLogById(id);
        for(Map<String,Object> o : logList){
            Map<String,String> map = new HashMap<String,String>();
            String note = o.get("note").toString();
            int start = note.indexOf("返现金额");
            int old = note.indexOf(",商品ID");
            o.put("note",note.substring(start,old));


            map.put("返利编号", o.get("id").toString());
            map.put("订单编号",o.get("number").toString());
            map.put("返利时间", o.get("time").toString());
            map.put("细节详情", o.get("note").toString());
            orderMap.add(map);
        }
        //写入
        try {
            PoiTool.writeToExcelXls(PathValue.OUTINFO+"/"+tiem+".xls", sheetName.get(0), orderMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/upload/outinfo/" +tiem+".xls";

    }


    /**
     * 提现记录
     * @return
     */
    @RequestMapping("/extractLog")
    public String extractLog(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }

        return "admin_extract_log";
    }

    /**
     * 网站配置
     * @return
     */
    @RequestMapping("/websiteConfig")
    public String websiteConfig(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        request.setAttribute("main_config",configMap);
        return "admin_website_config";
    }

    /**
     * 修改密码
     * @return
     */
    @RequestMapping("/updatePassword")
    public String updatePassword(String newPwd,String oldPwd){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(newPwd != null && oldPwd != null){
            //修改密码
            Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
            Agents agents = agentsService.getAgentsByAccount(user_agent.getAccount());
            if(agents.getPassword().equals(oldPwd)){
                //验证通过可以修改
                Agents agent = new Agents();
                agent.setId(agents.getId());
                agent.setPassword(newPwd);
                agents.setPassword(newPwd);
                agentsService.updateAgent(agent);
                request.getSession().setAttribute("user_agent",user_agent);
                request.setAttribute("updateSuccess","ok");
            }else{
                request.setAttribute("updatePasswordNote","修改密码失败,旧密码不正确");
                return "admin_update_password";
            }

        }
        return "admin_update_password";
    }

    /**
     * 数据中心
     * @return
     */
    @RequestMapping("/dataCenter")
    public String dataCenter(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        return "";
    }

    /**
     * 快递查询
     * @return
     */
    @RequestMapping("/express")
    public String express(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        request.setAttribute("expressCount",expressService.getExpressCount());
        return "admin_express";
    }

    /**
     * 留言反馈
     * @return
     */
    @RequestMapping("/feedback")
    public String feedback(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }else if(agent.getParentId() != 0){
            return "redirect:/admin/main";
        }



        return "admin_feedback";
    }

    @RequestMapping("/feedbackEdit")
    private String feedbackEdit(Integer id,String note){
        //获取虚假流量

        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(note != null){
            //编辑
            Feedback feedback = new Feedback();
            feedback.setId(id);
            feedback.setNote2(note);
            feedback.setStatus(1);
            feedbackService.updateFeedback(feedback);
            return "redirect:/admin/feedback";
        }
        Feedback feedback = feedbackService.getFeedback(id);
        request.setAttribute("feedback",feedback);
        Map<String,Object> phone = phoneCardService.getPhoneCardByIccid(feedback.getAid());
        String notice;
        if(phone.get("cid") == null){
            notice = "套餐流量已用尽或已过期";
        }else if(phone.get("ccid") != null){
            notice = "此卡套餐为次月生效";
        }else{
            notice = "一切正常,卡现在是在用状态";
        }
        request.setAttribute("notice",notice);
        int pcid = (int) phone.get("pcid");
        String status = "未获取";
        double data = 0;
        Map<String,Object> map = (Map<String, Object>) MemCache.get("website_config");
        double xujia = (double) map.get("number");
        if(phone.get("cid")==null && phone.get("upcid")==null && phone.get("ccid") == null){
            return "redirect:/admin/feedback";
        }
        Commodity commodity = commodityService.getCommodity(1,Integer.parseInt(phone.get("cid")!=null?phone.get("cid").toString():phone.get("upcid").toString()),0);
        //获取流量和状态
        switch (pcid){
            case 3:

                String r = CoreFunction.dxStatus(phone.get("msisdn").toString());
                if(Integer.parseInt(r) == 1){
                    status = "可激活";
                }else if(Integer.parseInt(r) == 4){
                    status = "在用";
                }else if(Integer.parseInt(r) == 5){
                    status = "停用";
                }

                double d = CoreFunction.dxQuery(phone.get("msisdn").toString());
                data = d;
                break;
            case 4:
                double dt = CoreFunction.ydQuery(phone.get("msisdn").toString());
                Object odata = phone.get("old_data");
                if(odata != null){
                    data = data - Double.parseDouble(odata.toString());
                }
                Calendar tc = Calendar.getInstance();
                tc.setTime(new Date());
                tc.add(Calendar.MONTH,-1);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
                String lastStr = formatter.format(tc.getTime());
                String upData = stringRedisTemplate.opsForValue().get("yd30w"+phone.get("msisdn").toString()+lastStr);
                if(upData != null){
                    dt = dt + Double.parseDouble(upData);
                }

                data = dt;
                status = CoreFunction.ydInfo(phone.get("msisdn").toString());
                break;
            default:
                break;
        }

        //获取地址
        Order order = orderService.getByIccid(phone.get("iccid").toString());
        request.setAttribute("status",status);
        request.setAttribute("data",data / xujia);
        request.setAttribute("address",order==null?"中国":order.getXdAddress());
        request.setAttribute("commodity",commodity);
        return "admin_feedback_edit";
    }

    @RequestMapping("/getPriceLog")
    @ResponseBody
    public String getPriceLog(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return "error";
        }
        List<Map<String,Object>> logList = priceLogService.getMyLogById(agent.getId());

        for(Map<String,Object> o : logList){
            String note = o.get("note").toString();
            int start = note.indexOf("返现金额");
            int old = note.indexOf(",商品ID");
            o.put("note",note.substring(start,old));
        }
        return JSON.toJSONString(logList);
    }

    @RequestMapping("/status")
    @ResponseBody
    public int status(String i,Integer t){
        Map<String,Object> phone = phoneCardService.getPhoneCardByIccid(i);
        if(phone.get("cid") == null){
            return -100;
        }
        int pid = Integer.parseInt(phone.get("pcid").toString());
        int result = 0;
        switch (pid){
            case 3:
                try {
                    if(t == 0){
                        CoreFunction.dxStop(phone.get("msisdn").toString());
                        CoreFunction.dxStatusChange(phone.get("msisdn").toString(),"19");
                    }else{
                        CoreFunction.dxStatusChange(phone.get("msisdn").toString(),"20");
                        CoreFunction.dxOpen(phone.get("msisdn").toString());
                    }
                }catch (Exception e){
                    System.out.println("后台回复的时候操作电信开机关机出错");
                }
                break;
            case 4:
                if(t == 0){
                    result = CoreFunction.ydFunction(phone.get("msisdn").toString(),0);
                }else{
                    String a = CoreFunction.ydInfo(phone.get("msisdn").toString());
                    if(a.equals("库存")){
                        result = CoreFunction.ydFunction(phone.get("msisdn").toString(),2);
                    }else{
                        result = CoreFunction.ydFunction(phone.get("msisdn").toString(),1);
                    }

                }
                break;
            default:
                break;
        }
        return result;
    }

    @RequestMapping("/viewPriceLog")
    public String viewPriceLog(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        return "admin_price_log";
    }

    @RequestMapping("/getFeedback")
    @ResponseBody
    private String getFeedback(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return "error";
        }else if(agent.getParentId() != 0){
            return "error";
        }
        List<Feedback> feedback = feedbackService.getAllFeedback();
        for(Feedback feedback1:feedback){
            if(feedback1.getNote().length() > 35){
                feedback1.setNote(feedback1.getNote().substring(0,35)+"...");
            }
            if(feedback1.getNote2()==null){
                feedback1.setNote2("未回复");
            }else{
                feedback1.setNote2("已回复");
            }
        }
        return JSON.toJSONString(feedback);

    }

    /**
     * 卡分类
     * @return
     */
    @RequestMapping("/commodityClass")
    public String commodityClass(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        return "admin_class";
    }

    /**
     * 添加分类
     * @return
     */
    @RequestMapping("/addClass")
    public String addClass(Pclass pclass){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents system_agents = (Agents)MemCache.get("system_admin");
        Agents user_agent = (Agents)request.getSession().getAttribute("user_agent");
        if(pclass != null && pclass.getName() != null && pclass.getSort() != null){
            //添加
            pclass.setAgent(user_agent);
            pclassService.savePclass(pclass);
            List<Pclass> pcList = pclassService.getPclass(system_agents.getId(),user_agent.getId());
            MemCache.put("website_class",pcList);
            return "redirect:/admin/commodityClass";
        }
        else if(pclass != null && pclass.getSort() != null){
            //添加页面
            request.setAttribute("sort",pclass.getSort());
        }else{
            //添加页面 没有传入sort 需要去数据库查询
            List<Pclass> pcList = pclassService.getPclass(system_agents.getId(),user_agent.getId());
            if(pcList == null || pcList.size() == 0){
                request.setAttribute("sort",1);
            }else{
                request.setAttribute("sort",((Pclass)pcList.get(pcList.size()-1)).getSort()+1);
            }

        }
        return "admin_add_class";
    }

    /**
     * 编辑分类
     * @param pclass
     * @param what
     * @return
     */
    @RequestMapping("/editClass")
    public String editClass(Pclass pclass,String what){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(what != null && what.equals("edit")){
            pclassService.updatePclass(pclass);
            Agents system_admin = (Agents)MemCache.get("system_admin");
            Agents user_agent = (Agents)request.getSession().getAttribute("user_agent");
            List<Pclass> pcList = pclassService.getPclass(system_admin.getId(),user_agent.getId());
            MemCache.put("website_class",pcList);
            return "redirect:/admin/commodityClass";
        }
        request.setAttribute("temp_pclass",pclass);
        return "admin_edit_class";
    }

    /**
     * 删除分类
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/deleteClass",method= RequestMethod.POST)
    public int deleteClass(Integer id){
        if(!checkHaveLogin()){
            return 0;
        }

        int result = pclassService.deletePclass(id);
        Agents system_admin = (Agents)MemCache.get("system_admin");
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        List<Pclass> pcList = pclassService.getPclass(system_admin.getId(),user_agent.getId());
        MemCache.put("website_class",pcList);
        return result;
    }

    /**
     * 添加快递
     * @param names
     * @param phones
     * @param express
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/addExpress",method= RequestMethod.POST)
    public int addExpress(String names,String phones,String express){
        if(!checkHaveLogin()){
            return 0;
        }
        if(names != null && phones != null && express != null){
            //添加
            String[] name = names.split("#");
            String[] phone = phones.split("#");
            String[] expres = express.split("#");

            List<Express> expList = new ArrayList<Express>();
            for(int i = 0;i<name.length;i++){
                Express exp = new Express();
                exp.setExpressNumber(expres[i]);
                exp.setXdName(name[i]);
                exp.setXdPhone(phone[i]);
                expList.add(exp);
            }

            //添加到数据库
            expressService.saveExpress(expList);

            return 1;
        }else{
            return 0;
        }
    }

    /**
     * 获取套餐列表 用户table请求
     * @param cid
     * @return
     */
    @ResponseBody
    @RequestMapping("/getCommodityData")
    public String getCommodityData(Integer cid,Integer aid){
        if(!checkHaveLogin()){
            return "login";
        }
        if(aid != null){
            return JSON.toJSONString(commodityService.getAllCommodity(aid,null,null));
        }
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        Agents system_agent = (Agents)MemCache.get("system_admin");
        Integer parent_id;
        if(agent.getParentId() == 0){
            parent_id = agent.getId();
        }else{
            parent_id = agent.getParentId();
        }
        List<Commodity> commList;
        if(cid == null){
            commList = commodityService.getAllCommodity(agent.getId(),parent_id,system_agent.getId());
        }else{
            commList = commodityService.getClassCommodity(agent.getId(),cid,parent_id,system_agent.getId());
        }
        /**
         * 如果自己就是最上级，那么上级给的价格就是null
         */
        /*if(agent.getParentId() == 0){
            for(int i = 0;i < commList.size();i++){
                commList.get(i).setParentPrice(null);
            }
        }*/
        return JSON.toJSONString(commList);
    }


    /**
     * 分配套餐提交
     * @param price
     * @return
     */
    @ResponseBody
    @RequestMapping("/setMealSubmit")
    public int setMealSubmit(Price price){
        if(!checkHaveLogin()){
            return 0;
        }
        Agents agent = agentsService.getAgentsById(price.getAgent().getId());
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(Integer.parseInt(agent.getParentId().toString()) != Integer.parseInt(user_agent.getId().toString())){
            return -4;//不是自己的代理
        }
        Price myprice = priceService.getPriceByAidAndCid(user_agent.getId(),price.getCommodity().getId());
        if(myprice.getParentPrice() != null && myprice.getParentPrice() > price.getParentPrice()){
            return -5;//价格低于自己的底价
        }
        Price tprice = priceService.getPriceByAidAndCid(price.getAgent().getId(),price.getCommodity().getId());
        if(tprice != null){
            return -1;//已分配过了
        }
        if(price.getParentPrice() > price.getPrice() ){
            return -2;//出售价小于底价
        }
        return priceService.savePrice(price);
    }


    /**
     * 代理登录
     * @return
     */
    @RequestMapping(value="/login",method= RequestMethod.POST)
    public String login(String id,String pwd){
        if(checkHaveLogin()){
            return "redirect:/admin/main";
        }
        Agents agent = agentsService.login(id,pwd);
        if(agent != null){
            request.getSession().setAttribute("user_agent",agent);
            //获取系统共用用户
            request.getSession().setAttribute("system_admin",MemCache.get("system_admin"));
            Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
            request.getSession().setAttribute("web_config",configMap);
            return "redirect:/admin/main";
        }
        request.setAttribute("login_title","登录失败，账号或密码错误。");
        return "login";
    }

    /**
     * 退出登录
     * @return
     */
    @RequestMapping("/out")
    public String out(){
        request.getSession().removeAttribute("user_agent");
        return "redirect:/admin";
    }

    @ResponseBody
    @RequestMapping("/newPwd")
    public Integer newPwd(Integer id){
        if(!checkHaveLogin()){
            return 0;
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        Agents agents = agentsService.getAgentsById(id);
        if(Integer.parseInt(agents.getParentId().toString()) != Integer.parseInt(user_agent.getId().toString())){
            return 0;
        }

        return agentsService.getNewPwd(id);
    }

    /**
     * 保存网站配置 主站操作
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/saveWebsiteMain",method= RequestMethod.POST)
    public int saveWebsiteMain(Double number,String domain,String notice,String noaddress){
        if(! checkHaveLogin()){
            return 0;
        }
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("domain",domain);
        paramMap.put("number",number);
        paramMap.put("noaddress",noaddress);
        paramMap.put("notice",notice);
        int result = configService.saveConfig(paramMap);
        Map<String,Object> configMap = configService.getConfig();
        MemCache.put("website_config",configMap);
        return result;
    }

    /**
     * 保存网站配置
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/saveWebsite",method= RequestMethod.POST)
    public int saveWebsite(Agents agent,MultipartFile[] file){
        if(! checkHaveLogin()){
            return 0;
        }


        Agents age = (Agents)request.getSession().getAttribute("user_agent");
        agent.setId(age.getId());
        agent.setAccount(age.getAccount());
        agent.setLevel(age.getLevel());
        agent.setMoney(age.getMoney());
        agent.setPassword(age.getPassword());
        if(file != null){
            try {
                String[] path = ImgUpload.startUpload(file,PathValue.IMGUPLOAD);
                agent.setImg("/upload/img/"+path[0]);
            }catch (Exception e){
                System.out.println("图片上传错误 代理");
            }
        }
        int result = agentsService.updateAgent(agent);
        request.getSession().setAttribute("user_agent",agentsService.getAgentsByAccount(age.getAccount()));

        return result;
    }

    /**
     * 获取分类JSON数据
     * @return
     */
    @RequestMapping("/getClassData")
    @ResponseBody
    public String getClassData(){
        if(! checkHaveLogin()){
            return "非法请求";
        }
        Agents system_admin = (Agents)MemCache.get("system_admin");
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        List<Pclass> pcList = pclassService.getPclass(system_admin.getId(),user_agent.getId());
        return JSON.toJSONString(pcList);
    }


    /**
     * 实时资费列表
     * @return
     */
    @RequestMapping("/costList")
    public String costList(){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        Agents user_agent = (Agents) request.getSession().getAttribute("user_agent");
        if(user_agent.getParentId() != 0){
            return "admin_main";
        }

        return "admin_cost_list";
    }

    /**
     * 获取实时资费数据
     * @return
     */
    @RequestMapping("/getCostData")
    @ResponseBody
    public String getCostData(){
        if(!checkHaveLogin()){
            return "非法请求";
        }
        List<Map> costList = costService.getCosts();
        return JSON.toJSONString(costList);
    }

    /**
     * 删除实时资费
     * @param id
     * @return
     */
    @RequestMapping("/deleteCost")
    @ResponseBody
    public int deleteCost(Integer id){
        if(!checkHaveLogin()){
            return 0;
        }
        if(id == null){
            return 0;
        }
        return costService.deleteCost(id);
    }


    /**
     * 保存实时资费
     * @return
     */
    @RequestMapping("/saveCost")
    public String saveCost(Integer id,String note,Integer sort,String j){
        if(!checkHaveLogin()){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        if(j != null){
            request.setAttribute("id",id);
            request.setAttribute("note",note);
            request.setAttribute("sort",sort);
            return "admin_cost_save";
        }
        Map<String,Object> map = new  HashMap<String,Object>();
        if(id != null){
            //修改
            map.put("id",id);
            map.put("note",note);
            map.put("sort",sort);
            costService.updateCost(map);
            return "redirect:/admin/costList";
        }else if(note != null && sort != null){
            //添加
            map.put("note",note);
            map.put("sort",sort);
            costService.saveCost(map);
            return "redirect:/admin/costList";
        }
        return "admin_cost_save";
    }

    /**
     * 检查是否登录
     * @return
     */
    public boolean checkHaveLogin(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent==null){
            return false;
        }
        return true;
    }

    @RequestMapping("/导出")
    public String temp(){
        //设置顶部ABCD
        List<String> sheetName = new ArrayList<>();
        sheetName.add("A");
        sheetName.add("B");
        sheetName.add("C");

        //对应ABCD标题
        String[] title = {"m","i","下单时间"};

        long tiem = System.currentTimeMillis();

        //创建
        PoiTool.createExcelXls(PathValue.OUTINFO+"/"+tiem+".xls", sheetName, title);

        //创建实体
        List<Map<String,String>> orderMap = new ArrayList<Map<String,String>>();


        List<Map<String,String>> mapList = tempOrderService.queryAll();
        for(Map<String,String> map: mapList){
            map.put("m", map.get("m"));
            map.put("i",map.get("i"));
            map.put("下单时间", map.get("time"));
            orderMap.add(map);
            Object id = map.get("id");
            tempOrderService.update(Integer.parseInt(id.toString()  ));
        }

        //写入
        try {
            PoiTool.writeToExcelXls(PathValue.OUTINFO+"/"+tiem+".xls", sheetName.get(0), orderMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/upload/outinfo/" +tiem+".xls";
    }
}