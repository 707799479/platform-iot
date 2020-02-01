package com.zmkj.platform.controller;

import com.zmkj.platform.service.AgentsService;
import com.zmkj.platform.service.CommodityService;
import com.zmkj.platform.service.PriceService;
import com.zmkj.platform.util.DesUtils;
import com.zmkj.platform.util.HttpHelper;
import com.zmkj.platform.util.WFyidong;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class demo {
    @Autowired
    private PriceService priceService;
    @Autowired
    private AgentsService agentsService;
    @Autowired
    private CommodityService commodityService;



    @Test
    public void c() throws Exception {
        System.out.println(new Date()+"进入了主页");
    }


    @Test
    public void a(){
        WFyidong.start("89860409161970373742");
    }






    @Test
    public void updatePrice() throws  Exception{


        //电信系统api
        String method = "queryPakagePlus";
        String access_number="1410344501981,1410344477730";      //物联网卡号(149或10649号段)
        String user_id = "ku2HQzz5b3O3CykOIb07ZSqj01U21g9b";     //用户名
        String password = "Yz63bu76OyaGCl66";    //密码
        String monthdate = "20190401";    //单独添加断网时action为ADD，单独恢复上网时为DEL
        String[] arr = {user_id,password,method}; //加密数组，数组所需参数根据对应的接口文档

        String key1 = "5Z4";
        String key2 = "1e1";
        String key3 = "4l3";
        DesUtils des = new DesUtils(); //DES加密工具类实例化
        String passWord = des.strEnc(password,key1,key2,key3);
        String sign = des.strEnc(DesUtils.naturalOrdering(arr),key1,key2,key3);


        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("method","queryPakagePlus"));
        params.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
        params.add(new BasicNameValuePair("action","ADD"));
        params.add(new BasicNameValuePair("monthDate",""));
        params.add(new BasicNameValuePair("access_number",access_number));
        params.add(new BasicNameValuePair("passWord",passWord));
        params.add(new BasicNameValuePair("sign",sign));

        String result = (String) HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",params,true);
        System.out.println(result);
    }

    @Test
    public void demo(){
        int remaider=1%100;  //(先计算出余数)
        int number=1/100;  //然后是商
    }





}
