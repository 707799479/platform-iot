package com.zmkj.platform.common;

import com.zmkj.platform.entity.Commodity;
import com.zmkj.platform.service.CommodityService;
import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.BeanHelper;
import com.zmkj.platform.util.WFyidong;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 移动监控
 */
public class WfYdThread extends Thread {

    private List<Map<String,Object>> phoneList;
    WfYdThread(List<Map<String,Object>> phoneList){
        this.phoneList = phoneList;
        this.phoneCardService = BeanHelper.getBean(PhoneCardService.class);
        this.redisTemplate = BeanHelper.getBean(StringRedisTemplate.class);
        this.commodityService = BeanHelper.getBean(CommodityService.class);
    }

    private PhoneCardService phoneCardService;
    private StringRedisTemplate redisTemplate;
    private CommodityService commodityService;

    @Override
    public void run(){
        //获取虚假流量
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        if(configMap == null || TokenLock.getToken() == null){
            try {
                Thread.sleep(10000);
                configMap = (Map<String,Object>)MemCache.get("website_config");
            }catch (Exception e){}
        }
        double xujia = 0;
        //double xujia = Double.parseDouble(configMap.get("number").toString());
        for(Map<String,Object> phoneInfo : phoneList){
            Commodity commodity = commodityService.getCommodityById(Integer.parseInt(phoneInfo.get("cid").toString()));
            xujia = Double.parseDouble(commodity.getXuliang());
            //操作号码
            String phone = phoneInfo.get("iccid").toString();
            try{
                double data = WFyidong.query(phone);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
                Date nowDate = new Date();
                String strDate = formatter.format(nowDate);

                Calendar rightNow = Calendar.getInstance();
                int hour = rightNow.get(Calendar.HOUR_OF_DAY);
                if(hour != 23){
                    redisTemplate.opsForValue().set("wfyd:"+phone+strDate,String.valueOf(data));
                }
                int gotime = -1;
                int cgotime = -1;
                if(phoneInfo.get("gotime") != null){
                    gotime = Integer.parseInt(phoneInfo.get("gotime").toString());
                    Calendar c = Calendar.getInstance();
                    c.setTime(nowDate);
                    c.add(Calendar.DATE,-gotime);// 今天+

                    String strDate2 = formatter.format(c.getTime());
                    int cha = Integer.parseInt(strDate) - Integer.parseInt(strDate2);
                    if (cha > 0){

                        for(int i = 1;i<=cha;i++){
                            Calendar tc = Calendar.getInstance();
                            tc.setTime(new Date());
                            tc.add(Calendar.MONTH,-i);// 今天+
                            String lastStr = formatter.format(tc.getTime());
                            String oldData = redisTemplate.opsForValue().get("wfyd:"+phone+lastStr);
                            if(oldData != null){

                                data = data + Double.parseDouble(oldData);

                            }
                        }
                    }else{
                        data = data - Double.parseDouble(phoneInfo.get("old_data").toString());
                    }


                }
                if(phoneInfo.get("cgotime") != null){
                    cgotime = Integer.parseInt(phoneInfo.get("cgotime").toString());
                }

                //System.out.println("用了:"+data+",线程："+Thread.currentThread().getName());

                if(phoneInfo.get("note") == null){
                    continue;
                }

                //总共流量
                double sum = Double.parseDouble(phoneInfo.get("note").toString());

                //限速
                double xs = Double.parseDouble(commodity.getXiansu());

                if(data > (sum * xujia)){
                    //断网操作
                    boolean result = WFyidong.end(phone);
                    boolean xiansu = WFyidong.unXiansu(phone);
                    phoneCardService.outData(phoneInfo.get("iccid").toString());
                    phoneCardService.updateXianSu(Integer.parseInt(phoneInfo.get("id").toString()),0);
                    System.out.println(phone+"移动WF卡断网 流量超出:"+result + "解除限速："+xiansu);
                    String tempStr = "wfyd:"+phone;
                    Set<String> keys = redisTemplate.keys(tempStr + "*");
                    redisTemplate.delete(keys);
                }else if(xs > 0 && data > xs){
                    WFyidong.xiansu(phone);
                    phoneCardService.updateXianSu(Integer.parseInt(phoneInfo.get("id").toString()),1);
                }
                if( gotime > commodity.getDay()){
                    //已用day天
                    boolean result = WFyidong.end(phone);
                    boolean xiansu = WFyidong.unXiansu(phone);
                    System.out.println(phone+"移动WF卡断网 到时间了:"+result + "限速"+xiansu);
                    phoneCardService.outData(phoneInfo.get("iccid").toString());
                    String tempStr = "wfyd:"+phone;
                    Set<String> keys = redisTemplate.keys(tempStr + "*");
                    redisTemplate.delete(keys);
                }

            }catch (Exception e){
            }
        }
    }
}
