package com.zmkj.platform.util;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zmkj.platform.common.TokenLock;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * 在这个年纪只有努力
 */
public class CoreFunction2 {



    public static void dxXianSu(String msisdn){
        String access_number=msisdn;      //物联网卡号(149或10649号段)
        String user_id = "ku2HQzz5b3O3CykOIb07ZSqj01U21g9b";     //用户名
        String password = "Yz63bu76OyaGCl66";    //密码

        String key1 = "5Z4";
        String key2 = "1e1";
        String key3 = "4l3";
        String[] arr = {access_number,user_id,password,"ADD","speedLimitAction","12"};

        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("method","speedLimitAction"));
        paramList.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
        paramList.add(new BasicNameValuePair("access_number",msisdn));
        paramList.add(new BasicNameValuePair("action","ADD"));
        paramList.add(new BasicNameValuePair("speedValue","12"));


        DesUtils des = new DesUtils(); //DES加密工具类实例化
        String passWord = des.strEnc(password,key1,key2,key3);
        String sign = des.strEnc(DesUtils.naturalOrdering(arr),key1,key2,key3);
        paramList.add(new BasicNameValuePair("password",passWord));
        paramList.add(new BasicNameValuePair("password",passWord));
        paramList.add(new BasicNameValuePair("sign",sign));
        try {
            JSONObject result = (JSONObject) HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/app/serviceAccept.do",paramList,true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 电信89000开卡
     * @param map
     */
    public static void dxOpen(String msisdn){
        String[] res = BaseHlper.sign("singleCutNet",msisdn,"DEL");
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("method","singleCutNet"));
        paramList.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
        paramList.add(new BasicNameValuePair("access_number",msisdn));
        paramList.add(new BasicNameValuePair("action","DEL"));
        paramList.add(new BasicNameValuePair("password",res[0]));
        paramList.add(new BasicNameValuePair("sign",res[1]));
        try{
            String result = (String) HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",paramList,true);
            if(result == null){
                System.out.println("卡号:"+msisdn+",激活失败;原因:返回值为NULL");
            }else{
                result = result.substring(result.indexOf("<RspDesc>")+"<RspDesc>".length(),result.indexOf("</RspDesc>"));
                if(result.indexOf("成功") != -1){
                    System.out.println("卡号:"+msisdn+",激活成功");
                }else{
                    System.out.println("卡号:"+msisdn+",激活失败;原因:"+result);
                }
            }
        }catch (Exception e){
            System.out.println("电信开卡失败："+e.getMessage());
            System.out.println("失败卡号："+msisdn);
        }
    }


    /**
     * 电信停机
     * 19停机保号
     * 20停机保号复机
     * @param phone
     */
    public static void dxStatusChange(String phone,String type){

        String access_number=phone;      //物联网卡号(149或10649号段)
        String user_id = "ku2HQzz5b3O3CykOIb07ZSqj01U21g9b";     //用户名
        String password = "Yz63bu76OyaGCl66";    //密码
        String orderTypeId = type;
        String acctCd ="";

        String key1 = "5Z4";
        String key2 = "1e1";
        String key3 = "4l3";
        String[] arr  = {access_number,user_id,password,"disabledNumber",acctCd,orderTypeId};
        DesUtils des = new DesUtils(); //DES加密工具类实例化
        String passWord = des.strEnc(password,key1,key2,key3);
        String sign = des.strEnc(DesUtils.naturalOrdering(arr),key1,key2,key3);

        List<NameValuePair> pl = new ArrayList<NameValuePair>();
        pl.add(new BasicNameValuePair("method","disabledNumber"));
        pl.add(new BasicNameValuePair("acctCd",""));
        pl.add(new BasicNameValuePair("orderTypeId",type));
        pl.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
        pl.add(new BasicNameValuePair("access_number",phone));
        pl.add(new BasicNameValuePair("password",passWord));
        pl.add(new BasicNameValuePair("sign",sign));
        String s = "";
        try {
            s = (String)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",pl,true);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 电信断网
     * @param phone
     */
    public static void dxStop(String phone){

        String[] r = BaseHlper.sign("singleCutNet",phone,"ADD");
        List<NameValuePair> pl = new ArrayList<NameValuePair>();
        pl.add(new BasicNameValuePair("method","singleCutNet"));
        pl.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
        pl.add(new BasicNameValuePair("action","ADD"));
        pl.add(new BasicNameValuePair("access_number",phone));
        pl.add(new BasicNameValuePair("password",r[0]));
        pl.add(new BasicNameValuePair("sign",r[1]));
        String s = "";
        try {
            s = (String)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",pl,true);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 电信流量查询
     * @param phone
     * @return
     */
    public static double dxQuery(String phone){

        String result = "";
        try {
            String res[] = BaseHlper.sign("queryTraffic",phone,null);
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("method","queryTraffic"));
            paramList.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
            paramList.add(new BasicNameValuePair("access_number",phone));
            paramList.add(new BasicNameValuePair("password",res[0]));
            paramList.add(new BasicNameValuePair("sign",res[1]));
            result = (String)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",paramList,true);
            if (result == null){
                System.out.println("报错了 重新执行一次");
                result = (String)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",paramList,true);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        double resultData = Double.parseDouble(result.substring(result.indexOf("<TOTAL_BYTES_CNT>")+"<TOTAL_BYTES_CNT>".length(),result.indexOf("</TOTAL_BYTES_CNT>")-2));

        return resultData;
    }


    /**
     * 接口返回说明
     * 1：可激活
     * 2：测试激活
     * 3：测试去激活
     * 4：在用
     * 5：停机
     * 6：运营商管理状态
     * 7：拆机
     * @param phone
     * @return
     */
    public static String dxStatus(String phone){

        String result = "";
        try {
            String res[] = BaseHlper.sign("queryCardMainStatus",phone,null);
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("method","queryCardMainStatus"));
            paramList.add(new BasicNameValuePair("user_id","ku2HQzz5b3O3CykOIb07ZSqj01U21g9b"));
            paramList.add(new BasicNameValuePair("access_number",phone));
            paramList.add(new BasicNameValuePair("password",res[0]));
            paramList.add(new BasicNameValuePair("sign",res[1]));
            JSONObject jsonObject = (JSONObject)HttpHelper.sendGet("http://api.ct10649.com:9001/m2m_ec/query.do",paramList,true);
            JSONArray jsonArray = (JSONArray)jsonObject.get("productInfo");
            JSONObject jsonObject1 = (JSONObject) jsonArray.get(0);
            String resultValue = jsonObject1.get("productMainStatusCd").toString();
            return resultValue;
        }catch (Exception e){
            e.printStackTrace();
        }

        return "error";
    }


    public static String ydToDayQuery(String msisdn){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "200216328200200000"+timeStr+"80000001";
        String t = TokenLock.getToken();
        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdns",msisdn));
            String timeStr2 = (new java.text.SimpleDateFormat("yyyyMMdd")).format(new Date());
            paramList.add(new BasicNameValuePair("queryDate","20190423"));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage-daily/batch",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage-daily/batch",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                System.out.println("token不存在 重新获取一次就好了");
                t = TokenLock.getToken2();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage-daily/batch",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage-daily/batch",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            if(result == 0){
                JSONArray JSONArray = (JSONArray) jsonObject.get("result");
                JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
                Integer data = Integer.parseInt(jsonObject1.get("cardStatus").toString());
                return getStatusStr(data);
            }else{
                return "error";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }


    public static String ydInfo2(String msisdn){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "200216328200200000"+timeStr+"80000001";
        String t = TokenLock.getToken2();
        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                System.out.println("token不存在 重新获取一次就好了");
                t = TokenLock.getToken2();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            if(result == 0){
                JSONArray JSONArray = (JSONArray) jsonObject.get("result");
                JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
                Integer data = Integer.parseInt(jsonObject1.get("cardStatus").toString());
                return getStatusStr(data);
            }else{
                return "error";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }
    public static String ydInfo(String msisdn){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "311212838200200000"+timeStr+"80000001";
        String t = TokenLock.getToken();
        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                System.out.println("token不存在 重新获取一次就好了");
                t = TokenLock.getToken();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-status",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }

            if(result == 0){
                JSONArray JSONArray = (JSONArray) jsonObject.get("result");
                JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
                Integer data = Integer.parseInt(jsonObject1.get("cardStatus").toString());
                return getStatusStr(data);
            }else{
                return "error";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }



    /**
     * 移动查询已用流量
     * @param msisdn
     * @param redisConnectionFactory
     * @return
     */
    public static double ydQuery(String msisdn){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "311212838200200000"+timeStr+"80000001";

        String t = TokenLock.getToken();
        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                System.out.println("token不存在 重新获取一次就好了");
                t = TokenLock.getToken();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            if(result == 0){
                JSONArray JSONArray = (JSONArray) jsonObject.get("result");
                JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
                double data = Double.parseDouble(jsonObject1.get("dataAmount").toString());
                return data / 1024;
            }else{
                return -1;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * 移动查询已用流量
     * @param msisdn
     * @param
     * @return
     */
    public static double ydQuery2(String msisdn){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "200216328200200000"+timeStr+"80000001";
        try {
            String t = TokenLock.getToken2();
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                System.out.println("token不存在 重新获取一次就好了");
                //System.out.println(Thread.currentThread().getName());
                t = TokenLock.getToken2();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/query/sim-data-usage",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            if(result == 0){
                JSONArray JSONArray = (JSONArray) jsonObject.get("result");
                JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
                double data = Double.parseDouble(jsonObject1.get("dataAmount").toString());
                return data / 1024;
            }else{
                return -1;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * 移动卡功能
     * @param msisdn
     * @param type 类型
     * 0:申请停机(已激活转已停机)
     * 1:申请复机(已停机转已激活)
     * 2:库存转已激活
     * 3:可测试转库存
     * 4:可测试转待激活
     * 5:可测试转已激活
     * 6:待激活转已激活
     * @param redisConnectionFactory
     *
     */
    public static int ydFunction(String msisdn,Integer type){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "311212838200200000"+timeStr+"80000001";

        String t = TokenLock.getToken();
        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            paramList.add(new BasicNameValuePair("operType",type.toString()));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                //System.out.println("token不存在");
                t = TokenLock.getToken();

                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                paramList.add(new BasicNameValuePair("operType",type.toString()));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            return result;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -100;
    }

    public static int ydFunction2(String msisdn,Integer type){
        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        String transid = "200216328200200000"+timeStr+"80000001";
        String t = TokenLock.getToken2();

        try {
            List<NameValuePair> paramList = new ArrayList<NameValuePair>();
            paramList.add(new BasicNameValuePair("transid",transid));
            paramList.add(new BasicNameValuePair("token", t));
            paramList.add(new BasicNameValuePair("msisdn",msisdn));
            paramList.add(new BasicNameValuePair("operType",type.toString()));
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
            if (jsonObject == null){
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
            }
            int result = Integer.parseInt(jsonObject.get("status").toString());
            if (result == 12021){
                //System.out.println("token不存在");
                t = TokenLock.getToken2();
                paramList = new ArrayList<NameValuePair>();
                paramList.add(new BasicNameValuePair("transid",transid));
                paramList.add(new BasicNameValuePair("token", t));
                paramList.add(new BasicNameValuePair("msisdn",msisdn));
                paramList.add(new BasicNameValuePair("operType",type.toString()));
                jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
                if (jsonObject == null){
                    jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/change/sim-status",paramList,false);
                }
                result = Integer.parseInt(jsonObject.get("status").toString());
            }
            return result;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -100;
    }

    /**
     * 移动获取token  30万张卡
     */
    public static String ydGetToken(){

        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("appid","311212838200200000"));
        paramList.add(new BasicNameValuePair("password","7xnFA8s0l"));
        paramList.add(new BasicNameValuePair("transid","311212838200200000"+timeStr+"80000001"));
        try {
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/get/token",paramList,false);
            JSONArray JSONArray = (JSONArray) jsonObject.get("result");
            JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
            String token = (String) jsonObject1.get("token");
            if(token != null){

                return token;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 5万张卡
     * @return
     */
    public static String ydGetToken2(){

        String timeStr = (new java.text.SimpleDateFormat("yyyyMMddhhmmss")).format(new Date());
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("appid","200216328200200000"));
        paramList.add(new BasicNameValuePair("password","bKAcHr7i7"));
        paramList.add(new BasicNameValuePair("transid","200216328200200000"+timeStr+"80000001"));
        try {
            JSONObject jsonObject = (JSONObject) HttpHelper.sendGet("https://api.iot.10086.cn/v5/ec/get/token",paramList,false);
            JSONArray JSONArray = (JSONArray) jsonObject.get("result");
            JSONObject jsonObject1 = (JSONObject) JSONArray.get(0);
            String token = (String) jsonObject1.get("token");
            if(token != null){

                return token;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 发送验证码
     * @param phone
     * @return
     */
    public static String sendCode(String phone){
        String num = getFourRandom();
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        paramList.add(new BasicNameValuePair("mobile",phone));
        paramList.add(new BasicNameValuePair("tpl_id","148464"));
        paramList.add(new BasicNameValuePair("tpl_value","%23code%23%3D"+num));
        paramList.add(new BasicNameValuePair("key","692b6f431a12c971d49f8c7f9f301493"));
        try {
            HttpHelper.sendGet("http://v.juhe.cn/sms/send", paramList, false);
        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }

    /**
     * 随机数
     * @return
     */
    public static String getFourRandom(){
        Random random = new Random();
        String fourRandom = random.nextInt(10000) + "";
        int randLength = fourRandom.length();
        if(randLength<4){
            for(int i=1; i<=4-randLength; i++) {
                fourRandom = "0" + fourRandom;
            }
        }
        return fourRandom;
    }


    /**
     * 获得状态str
     *
     */
    public static String getStatusStr(int status){
        String res = "";
        switch (status){
            case 1:
                res = "待激活";
                break;
            case 2:
                res = "已激活";
                break;
            case 4:
                res = "停机";
                break;
            case 6:
                res = "可测试";
                break;
            case 7:
                res = "库存";
                break;
            case 8:
                res = "预销户";
                break;
            case 9:
                res = "已销户";
                break;
            default:
                res = "错误";
                break;
        }
        return res;
    }



}
