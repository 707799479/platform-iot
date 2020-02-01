package com.zmkj.platform.util;

public class BaseHlper {

    public static String[] sign(String method,String phone,String action){
        String access_number=phone;      //物联网卡号(149或10649号段)
        String user_id = "ku2HQzz5b3O3CykOIb07ZSqj01U21g9b";     //用户名
        String password = "Yz63bu76OyaGCl66";    //密码

        String key1 = "5Z4";
        String key2 = "1e1";
        String key3 = "4l3";
        String[] arr ;
        if(action != null){
            String[] a = {access_number,user_id,password,action,method};
            arr = a;
        }else{
            String[] a = {access_number,user_id,password,method};
            arr = a;
        }
        DesUtils des = new DesUtils(); //DES加密工具类实例化
        String passWord = des.strEnc(password,key1,key2,key3);
        String sign = des.strEnc(DesUtils.naturalOrdering(arr),key1,key2,key3);

        return new String[]{passWord,sign};

    }
}
