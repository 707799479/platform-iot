package com.zmkj.platform.common;

import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.BeanHelper;
import com.zmkj.platform.util.CoreFunction;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;


public class MyThread extends Thread {

    private List<Map<String,Object>> phoneList;
    MyThread(List<Map<String,Object>> mapList){
        this.phoneList = mapList;
        this.phoneCardService = BeanHelper.getBean(PhoneCardService.class);
    }

    private PhoneCardService phoneCardService;

    @Override
    public void run(){
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        if(configMap == null ){
            try {
                Thread.sleep(2000);
                configMap = (Map<String,Object>)MemCache.get("website_config");
            }catch (Exception e){}
        }
        double xujia = Double.parseDouble(configMap.get("number").toString());
        for(Map<String,Object> phoneInfo : phoneList){
           try{
               SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
               String phone = phoneInfo.get("msisdn").toString();

               double resultData = CoreFunction.dxQuery(phone);
               //System.out.println("用了:"+resultData+",线程："+Thread.currentThread().getName());
               if(phoneInfo.get("note") == null){
                   continue;
               }
               double xianSu = Double.parseDouble(phoneInfo.get("xs").toString());
               int xsStatus = Integer.parseInt(phoneInfo.get("xiansu").toString());
               double sum = Double.parseDouble(phoneInfo.get("note").toString());
               if(resultData > (sum * xujia)){

                   CoreFunction.dxStop(phone);
                   CoreFunction.dxStatusChange(phone,"19");
                   phoneCardService.outData(phoneInfo.get("iccid").toString());
               }else if(xsStatus == 1 && resultData > xianSu){
                   System.out.println("电信限速："+phone);
                   CoreFunction.dxXianSu(phone);
                   phoneCardService.updateXianSu(Integer.parseInt(phoneInfo.get("id").toString()),1);
               }


           }catch (Exception e){
                e.printStackTrace();
           }
        }
    }

}