package com.zmkj.platform.common;

import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.BeanHelper;
import com.zmkj.platform.util.CoreFunction;

import java.util.List;
import java.util.Map;

/**
 * 移动监控
 */
public class YdThread2 extends Thread {

    private List<Map<String,Object>> phoneList;
    YdThread2(List<Map<String,Object>> phoneList){
        this.phoneList = phoneList;
        this.phoneCardService = BeanHelper.getBean(PhoneCardService.class);
    }

    private PhoneCardService phoneCardService;

    @Override
    public void run(){
        //获取虚假流量
        Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
        if(configMap == null || TokenLock.getToken2() == null){
            try {
                Thread.sleep(10000);
                configMap = (Map<String,Object>)MemCache.get("website_config");
            }catch (Exception e){}
        }
        double xujia = Double.parseDouble(configMap.get("number").toString());
        for(Map<String,Object> phoneInfo : phoneList){


            //操作号码
            String phone = phoneInfo.get("msisdn").toString();


            try{
                double data = CoreFunction.ydQuery2(phone);
                while (data == -1){
                    data = CoreFunction.ydQuery2(phone);
                }

                //System.out.println("用了:"+data+",线程："+Thread.currentThread().getName());

                if(phoneInfo.get("note") == null){
                    continue;
                }

                //总共流量
                double sum = Double.parseDouble(phoneInfo.get("note").toString());
                if(data > (sum * xujia)){
                    //断网操作
                    int result = CoreFunction.ydFunction2(phone,0);
                    phoneCardService.outData(phoneInfo.get("iccid").toString());
                    if(result != 0){
                        //断网失败
                        System.out.println("移动断网失败，卡号:"+phone+ ";错误代码:"+result);
                    }
                }
            }catch (Exception e){
            }
        }
    }
}
