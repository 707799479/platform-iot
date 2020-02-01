package com.zmkj.platform.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fcibook.quick.http.QuickHttp;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class WFyidong {
    public static final String APPID = "1147730651789684737";
    public static final String KEY = "pUObJOF052wFqfcE";
    public static final String DOMAIN ="http://zgxx.e-zhubo.com/api-dealer/action";

    /**
     * 获取MD5加密
     *
     * @param str 需要加密的字符串
     * @return String字符串 加密后的字符串
     */
    public static String encode(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte b[] = md.digest();

            int i;

            StringBuffer buf = new StringBuffer();
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            //32位加密
            return buf.toString().toUpperCase();
            // 16位的加密
            //return buf.toString().substring(8, 24);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 签名
     * @param params
     * @param appSecret
     * @return
     */
    public static String doSign(Map<String,String> params, String appSecret){
        String[] keys = params.keySet().toArray(new String[]{});
        Arrays.sort(keys);
        StringBuilder sb = new StringBuilder();
        for(String s:keys){
            if(params.get(s) != null){
                sb.append(s).append("=").append(params.get(s)).append("&");
            }
        }
        String str = sb.substring(0,sb.length() - 1) + appSecret;
        str = WFyidong.encode(str);
        return str;
    }


    public static boolean start(String iccid){
        String time = System.currentTimeMillis()+"";
        Map<String,String> map = new HashMap<>();
        map.put("appId",APPID);
        map.put("action","ACTIVE");
        map.put("iccid",iccid);
        map.put("timestamp",time);
        String sign = doSign(map,KEY);
        String result = new QuickHttp()
                .url(DOMAIN)
                .post()
                .addParame("appId",APPID)
                .addParame("action","ACTIVE")
                .addParame("sign",sign)
                .addParame("iccid",iccid)
                .addParame("timestamp",time)
                .text();
        JSONObject jsonObject = JSON.parseObject(result);
        boolean success = (boolean) jsonObject.get("success");
        return success;
    }

    public static boolean end(String iccid){
        String time = System.currentTimeMillis()+"";
        Map<String,String> map = new HashMap<>();
        map.put("appId",APPID);
        map.put("action","PowerOff");
        map.put("iccid",iccid);
        map.put("timestamp",time);
        String sign = doSign(map,KEY);
        String result = new QuickHttp()
                .url(DOMAIN)
                .post()
                .addParame("appId",APPID)
                .addParame("action","PowerOff")
                .addParame("sign",sign)
                .addParame("iccid",iccid)
                .addParame("timestamp",time)
                .text();
        JSONObject jsonObject = JSON.parseObject(result);
         boolean success = (boolean) jsonObject.get("success");
        return success;
    }


    public static double query(String iccid){
        String time = System.currentTimeMillis()+"";
        Map<String,String> map = new HashMap<>();
        map.put("appId",APPID);
        map.put("action","BaseInfo");
        map.put("iccid",iccid);
        map.put("timestamp",time);
        String sign = doSign(map,KEY);
        String result = new QuickHttp()
                .url(DOMAIN)
                .post()
                .addParame("appId",APPID)
                .addParame("action","BaseInfo")
                .addParame("sign",sign)
                .addParame("iccid",iccid)
                .addParame("timestamp",time)
                .text();
        JSONObject jsonObject = JSON.parseObject(result);
        JSONObject jsonObject1 = (JSONObject) jsonObject.get("data");
        BigDecimal data = (BigDecimal) jsonObject1.get("useGprs");
        return data.doubleValue();
    }

    public static boolean xiansu(String iccid){
        String time = System.currentTimeMillis()+"";
        Map<String,String> map = new HashMap<>();
        map.put("appId",APPID);
        map.put("action","Limit");
        map.put("iccid",iccid);
        map.put("timestamp",time);
        String sign = doSign(map,KEY);
        String result = new QuickHttp()
                .url(DOMAIN)
                .post()
                .addParame("appId",APPID)
                .addParame("action","Limit")
                .addParame("sign",sign)
                .addParame("iccid",iccid)
                .addParame("timestamp",time)
                .text();
        JSONObject jsonObject = JSON.parseObject(result);
        boolean success = (boolean) jsonObject.get("success");
        return success;
    }

    public static boolean unXiansu(String iccid){
        String time = System.currentTimeMillis()+"";
        Map<String,String> map = new HashMap<>();
        map.put("appId",APPID);
        map.put("action","UnLimit");
        map.put("iccid",iccid);
        map.put("timestamp",time);
        String sign = doSign(map,KEY);
        String result = new QuickHttp()
                .url(DOMAIN)
                .post()
                .addParame("appId",APPID)
                .addParame("action","UnLimit")
                .addParame("sign",sign)
                .addParame("iccid",iccid)
                .addParame("timestamp",time)
                .text();
        JSONObject jsonObject = JSON.parseObject(result);
        boolean success = (boolean) jsonObject.get("success");
        return success;
    }



}