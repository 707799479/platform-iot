package com.zmkj.platform.controller;

import com.zmkj.platform.common.MemCache;
import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.entity.Order;
import com.zmkj.platform.entity.Price;
import com.zmkj.platform.service.*;
import com.zmkj.platform.util.CoreFunction;
import com.zmkj.platform.util.WFyidong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * 支付通知 controller
 */
@Controller
@RequestMapping("/pay")
public class PayNoticeController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private PriceService priceService;

    @Autowired
    private AgentsService agentsService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private PhoneCardService phoneCardService;

    @Autowired
    private PriceLogService priceLogService;

    /**
     * 通联支付通知
     * 两件事情：
     *  1.调用接口 开通上网权限
     *  2.计算返利 到账户余额
     * @return
     */
    @RequestMapping("/setMealPaySuccess")
    @ResponseBody
    public String setMealPaySuccess(){
        TreeMap<String,String> paramMap = getParams(request);
        String resultStatus = paramMap.get("trxstatus");//状态
        String orderNo = paramMap.get("outtrxid");//订单号
        Order order = orderService.getOrderByNo(orderNo);
        Map<String,Object> phoneCard = phoneCardService.getPhoneCardByIccid(order.getXdPhone());
        if(resultStatus.equals("0000")){
            //交易成功
            Integer aid = (Integer) phoneCard.get("aid");
            if(aid == null){
                aid = order.getAgent().getId();
            }
            //调用修改订单方法
            orderService.updateOrder(1,order.getNumber());
            Agents agent = agentsService.getAgentsById(aid);
            int count = priceLogService.countPrice(agent!=null?agent.getId():0,orderNo);
            if(agent != null && count < 1){

                Price price = priceService.getPriceByAidAndCid(agent.getId(),order.getCommodity().getId());
                if(agent.getParentId() == 0){
                    double money = price.getPrice();
                    Agents newAgent = new Agents();
                    newAgent.setId(agent.getId());
                    newAgent.setMoney(agent.getMoney()+money);
                    agentsService.updateAgent(newAgent);
                    String log = "超级管理员返现,返现金额为:"+money+",返现之前余额:"+agent.getMoney()+
                            ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+order.getCommodity().getId()+
                            ",订单编号:"+orderNo;
                    priceLogService.save(agent.getId(),log,orderNo);
                }else{
                    double money = price.getPrice()-price.getParentPrice();
                    Agents newAgent = new Agents();
                    newAgent.setId(agent.getId());
                    newAgent.setMoney(agent.getMoney()+money);
                    agentsService.updateAgent(newAgent);
                    String log = "第1次返现,返现金额为:"+money+",返现之前余额:"+agent.getMoney()+
                            ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+order.getCommodity().getId()+
                            ",订单编号:"+orderNo;
                    priceLogService.save(agent.getId(),log,orderNo);
                    double downAgentPrice = price.getParentPrice();
                    countMoney(agent.getParentId(),order.getCommodity().getId(),downAgentPrice,orderNo,2);
                }
            }
            String userAddress = order.getXdAddress();
            if(userAddress != null &&  (! userAddress.isEmpty()) && userAddress.length() > 1){
                Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
                if(config.get("noaddress") != null){
                    String[] noaddress = config.get("noaddress").toString().split("#");
                    for(String s : noaddress){
                        if(userAddress.indexOf(s) != -1){
                            System.out.println("禁区用户充值 订单号:"+orderNo);
                            return "success";
                        }
                    }
                }
            }

            //二维码接口http://qr.liantu.com/api.php?text=
            //修改卡的套餐信息

            int xianSu = 0;
            if(phoneCard.get("xiansu") != null){
                xianSu = Integer.parseInt(phoneCard.get("xiansu").toString());
            }

            Map<String,Object> updateMap = new HashMap<String,Object>();
            updateMap.put("id",phoneCard.get("id"));
            //获取卡是什么卡
            Integer setMealId = (Integer) phoneCard.get("pcid");
            String old_data = "0.0";
            if(order.getPayType().equals("now") || order.getPayType().equals("other")){
                //当月逻辑
                System.out.println("单号："+orderNo);
                //给卡开网
                String type = "";
                switch (setMealId){
                    case 1:
                        String iccid = phoneCard.get("iccid").toString();
                        boolean s = WFyidong.start(iccid);
                        if(s){
                            System.out.println(iccid+":成功->wf移动");
                        }else{
                            System.out.println(iccid+":失败->wf移动");
                        }
                        break;
                    case 2:
                        System.out.println("充值了 进入移动5万张卡"+phoneCard.get("msisdn").toString());
                        type = CoreFunction.ydInfo2(phoneCard.get("msisdn").toString());
                        while (type.equals("error")){
                            type = CoreFunction.ydInfo2(phoneCard.get("msisdn").toString());
                            System.out.println("查询移动状态失败，重新查询");
                        }
                        if(type.equals("库存")){

                            int r = CoreFunction.ydFunction2(phoneCard.get("msisdn").toString(),2);
                            System.out.println("走的库存:"+r);
                        }else{
                            int r = CoreFunction.ydFunction2(phoneCard.get("msisdn").toString(),1);
                            System.out.println("走的不是库存:"+r);
                        }
                        break;
                    case 3:
                        System.out.println("充值了 进入电信系统,开卡操作"+phoneCard.get("msisdn").toString());
                        if(xianSu == 1){
                            phoneCardService.updateXianSu(Integer.parseInt(phoneCard.get("id").toString()),0);
                        }
                        String status = CoreFunction.dxStatus(phoneCard.get("msisdn").toString());
                        if(status.equals("5")){
                            //停机状态
                            //恢机 在开网
                            CoreFunction.dxStatusChange(phoneCard.get("msisdn").toString(),"20");
                        }
                        CoreFunction.dxOpen(phoneCard.get("msisdn").toString());
                        break;
                    case 4:
                        System.out.println("充值了 进入移动30万张卡操作"+phoneCard.get("msisdn").toString());
                        type = CoreFunction.ydInfo(phoneCard.get("msisdn").toString());
                        while (type.equals("error")){
                            type = CoreFunction.ydInfo(phoneCard.get("msisdn").toString());
                            System.out.println("查询移动状态失败，重新查询");
                        }
                        if(type.equals("库存")){
                            int r = CoreFunction.ydFunction(phoneCard.get("msisdn").toString(),2);
                            System.out.println("走的库存:"+r);
                        }else{
                            int r = CoreFunction.ydFunction(phoneCard.get("msisdn").toString(),1);
                            System.out.println("走的不是库存:"+r);
                        }
                        break;
                    default:
                        break;
                }
                if(order.getSfid() != null){
                    old_data = order.getSfid();
                }
                if(order.getPayType().equals("other")){
                    phoneCardService.updateGoTime(phoneCard.get("msisdn").toString());
                }else{
                    phoneCardService.payUpdate(Integer.parseInt(phoneCard.get("id").toString()),order.getCommodity().getId(),false,old_data);
                }

            }else{
                //次月逻辑

                phoneCardService.payUpdate(Integer.parseInt(phoneCard.get("id").toString()),order.getCommodity().getId(),true,old_data);
            }


            order.setStatus(1);
            orderService.updateOrder(1,orderNo);
        }else{
            System.out.println("交易失败错误编号："+resultStatus);
            orderService.updateOrder(2,orderNo);
            System.out.println("支付失败："+resultStatus);
            //调用修改订单方法
            return "error";
        }
        return "success";
    }


    private TreeMap<String, String> getParams(HttpServletRequest request){
        TreeMap<String, String> map = new TreeMap<String, String>();
        Map reqMap = request.getParameterMap();
        for(Object key:reqMap.keySet()){
            String value = ((String[])reqMap.get(key))[0];
            map.put(key.toString(),value);
        }
        return map;
    }



    private void countMoney(Integer aid,Integer cid,double downAgentPrice,String orderNo,int i){
        Agents agent = agentsService.getAgentsById(aid);
        if(agent != null){
            Price price = priceService.getPriceByAidAndCid(aid,cid);
            Agents newAgent = new Agents();
            newAgent.setId(agent.getId());
            if(agent.getParentId() == 0){
                newAgent.setMoney(agent.getMoney()+downAgentPrice);
                agentsService.updateAgent(newAgent);
                String log = "第"+i+"次返现,返现金额为:"+downAgentPrice+",返现之前余额:"+agent.getMoney()+
                        ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+cid+
                        ",订单编号:"+orderNo;
                priceLogService.save(agent.getId(),log,orderNo);
            }else{
                double money = downAgentPrice - price.getParentPrice();
                newAgent.setMoney(agent.getMoney()+money);
                agentsService.updateAgent(newAgent);
                String log = "第"+i+"次返现,返现金额为:"+downAgentPrice+",返现之前余额:"+agent.getMoney()+
                        ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+cid+
                        ",订单编号:"+orderNo;
                priceLogService.save(agent.getId(),log,orderNo);
                i = i + 1;
                countMoney(agent.getParentId(),cid,price.getParentPrice(),orderNo,i);
            }
        }
    }


    @RequestMapping("/test")
    @ResponseBody
    public String test(String o){
        String orderNo = o;
        Order order = orderService.getOrderByNo(o);
        //交易成功

        //调用修改订单方法
        orderService.updateOrder(1,order.getNumber());

        Agents agent = agentsService.getAgentsById(order.getAgent().getId());
        int count = priceLogService.countPrice(agent!=null?agent.getId():0,orderNo);
        if(agent != null && count < 1){

            Price price = priceService.getPriceByAidAndCid(agent.getId(),order.getCommodity().getId());
            if(agent.getParentId() == 0){
                double money = price.getPrice();
                Agents newAgent = new Agents();
                newAgent.setId(agent.getId());
                newAgent.setMoney(agent.getMoney()+money);
                agentsService.updateAgent(newAgent);
                String log = "超级管理员返现,返现金额为:"+money+",返现之前余额:"+agent.getMoney()+
                        ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+order.getCommodity().getId()+
                        ",订单编号:"+orderNo;
                priceLogService.save(agent.getId(),log,orderNo);
            }else{
                double money = price.getPrice()-price.getParentPrice();
                Agents newAgent = new Agents();
                newAgent.setId(agent.getId());
                newAgent.setMoney(agent.getMoney()+money);
                agentsService.updateAgent(newAgent);
                String log = "第1次返现,返现金额为:"+money+",返现之前余额:"+agent.getMoney()+
                        ",返现之后余额:"+newAgent.getMoney()+",商品ID是:"+order.getCommodity().getId()+
                        ",订单编号:"+orderNo;
                priceLogService.save(agent.getId(),log,orderNo);
                double downAgentPrice = price.getParentPrice();
                countMoney(agent.getParentId(),order.getCommodity().getId(),downAgentPrice,orderNo,2);
            }
        }
        String userAddress = order.getXdAddress();
        if(userAddress != null){
            Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
            String[] noaddress = config.get("noaddress").toString().split("#");
            for(String s : noaddress){
                if(userAddress.indexOf(s) != -1){
                    System.out.println("禁区用户充值 订单号:"+orderNo);
                    return "禁区";
                }
            }
        }

        //二维码接口http://qr.liantu.com/api.php?text=
        //修改卡的套餐信息
        Map<String,Object> phoneCard = phoneCardService.getPhoneCardByIccid(order.getXdPhone());

        int xianSu = 0;
        if(phoneCard.get("xiansu") != null){
            xianSu = Integer.parseInt(phoneCard.get("xiansu").toString());
        }

        Map<String,Object> updateMap = new HashMap<String,Object>();
        updateMap.put("id",phoneCard.get("id"));
        //获取卡是什么卡
        Integer setMealId = (Integer) phoneCard.get("pcid");

        String old_data = "0.0";
        if(order.getPayType().equals("now")){
            //当月逻辑
            System.out.println("单号："+orderNo);
            //给卡开网
            String type = "";
            switch (setMealId){
                case 2:
                    System.out.println("充值了 进入移动5万张卡"+phoneCard.get("msisdn").toString());
                    type = CoreFunction.ydInfo2(phoneCard.get("msisdn").toString());
                    while (type.equals("error")){
                        type = CoreFunction.ydInfo2(phoneCard.get("msisdn").toString());
                        System.out.println("查询移动状态失败，重新查询");
                    }
                    if(type.equals("库存")){

                        int r = CoreFunction.ydFunction2(phoneCard.get("msisdn").toString(),2);
                        System.out.println("走的库存:"+r);
                    }else{
                        int r = CoreFunction.ydFunction2(phoneCard.get("msisdn").toString(),1);
                        System.out.println("走的不是库存:"+r);
                    }
                    break;
                case 3:
                    System.out.println("充值了 进入电信系统,开卡操作"+phoneCard.get("msisdn").toString());
                    if(xianSu == 1){
                        phoneCardService.updateXianSu(Integer.parseInt(phoneCard.get("id").toString()),0);
                    }
                    String status = CoreFunction.dxStatus(phoneCard.get("msisdn").toString());
                    if(status.equals("5")){
                        //停机状态
                        //恢机 在开网
                        CoreFunction.dxStatusChange(phoneCard.get("msisdn").toString(),"20");
                    }
                    CoreFunction.dxOpen(phoneCard.get("msisdn").toString());
                    break;
                case 4:
                    System.out.println("充值了 进入移动30万张卡操作"+phoneCard.get("msisdn").toString());
                    type = CoreFunction.ydInfo(phoneCard.get("msisdn").toString());
                    while (type.equals("error")){
                        type = CoreFunction.ydInfo(phoneCard.get("msisdn").toString());
                        System.out.println("查询移动状态失败，重新查询");
                    }
                    if(type.equals("库存")){
                        int r = CoreFunction.ydFunction(phoneCard.get("msisdn").toString(),2);
                        System.out.println("走的库存:"+r);
                    }else{
                        int r = CoreFunction.ydFunction(phoneCard.get("msisdn").toString(),1);
                        System.out.println("走的不是库存:"+r);
                    }
                    break;
                default:
                    break;
            }
            if(order.getSfid() != null){
                old_data = order.getSfid();
            }
            phoneCardService.payUpdate(Integer.parseInt(phoneCard.get("id").toString()),order.getCommodity().getId(),false,old_data);
        }else{
            //次月逻辑

            phoneCardService.payUpdate(Integer.parseInt(phoneCard.get("id").toString()),order.getCommodity().getId(),true,old_data);
        }


        order.setStatus(1);
        orderService.updateOrder(1,orderNo);
        return "success";
    }





}