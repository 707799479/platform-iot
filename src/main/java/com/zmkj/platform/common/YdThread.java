package com.zmkj.platform.common;

import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.BeanHelper;
import com.zmkj.platform.util.CoreFunction;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 移动监控
 */
public class YdThread extends Thread {

    private List<Map<String,Object>> phoneList;
    YdThread(List<Map<String,Object>> phoneList){
        this.phoneList = phoneList;
        this.phoneCardService = BeanHelper.getBean(PhoneCardService.class);
        this.redisTemplate = BeanHelper.getBean(StringRedisTemplate.class);
    }

    private PhoneCardService phoneCardService;
    private StringRedisTemplate redisTemplate;

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
        double xujia = Double.parseDouble(configMap.get("number").toString());
        for(Map<String,Object> phoneInfo : phoneList){


            //操作号码
            String phone = phoneInfo.get("msisdn").toString();


            try{
                double data = CoreFunction.ydQuery(phone);
                if (data == -1){
                    data = CoreFunction.ydQuery(phone);
                }

                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
                Date nowDate = new Date();
                String strDate = formatter.format(nowDate);

                Calendar rightNow = Calendar.getInstance();
                int hour = rightNow.get(Calendar.HOUR_OF_DAY);
                if(hour != 23){
                    redisTemplate.opsForValue().set("yd30w"+phone+strDate,String.valueOf(data));
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
                            String oldData = redisTemplate.opsForValue().get("yd30w"+phone+lastStr);
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
                if(cgotime > 30){
                    //开通次月


                    String res = CoreFunction.ydInfo(phoneInfo.get("msisdn").toString());
                    if(res.equals("库存")){
                        CoreFunction.ydFunction(phoneInfo.get("msisdn").toString(),2);
                    }else if(res.equals("已激活")){
                        //cid 等于 ccid ccid等于null  cgotime等于空 cgotime等于now（）

                    }else{
                        CoreFunction.ydFunction(phoneInfo.get("msisdn").toString(),1);
                    }
                    phoneCardService.updateDown(Integer.parseInt(phoneInfo.get("id").toString()));
                    int type = phoneInfo.get("status") != null?1:2;
                    if(type == 2){
                        Map<String,Object> updateMap = new HashMap<String,Object>();
                        updateMap.put("id",phoneInfo.get("id"));
                        updateMap.put("status",1);
                        phoneCardService.update(updateMap);
                    }
                }
                if(phoneInfo.get("note") == null){
                    continue;
                }

                //总共流量
                double sum = Double.parseDouble(phoneInfo.get("note").toString());

                if(data > (sum * xujia)){
                    //断网操作
                    int result = CoreFunction.ydFunction(phone,0);
                    phoneCardService.outData(phoneInfo.get("iccid").toString());
                    System.out.println(phone+"移动30w卡断网 流量超出:"+result);
                    String tempStr = "yw30w"+phone;
                    Set<String> keys = redisTemplate.keys(tempStr + "*");
                    redisTemplate.delete(keys);
                }
                if( gotime > 30){
                    //已用30天
                    int result = CoreFunction.ydFunction(phone,0);
                    System.out.println(phone+"移动30w卡断网 到时间了:"+result);
                    phoneCardService.outData(phoneInfo.get("iccid").toString());
                    String tempStr = "yw30w"+phone;
                    Set<String> keys = redisTemplate.keys(tempStr + "*");
                    redisTemplate.delete(keys);
                }

            }catch (Exception e){
            }
        }
    }
}
