package com.zmkj.platform.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 缓存
 */
public class MemCache {
    private static Map<String,Object> cacheMap = new HashMap<String,Object>();

    public static void put (String key,Object value){
        cacheMap.put(key,value);
    }
    public static Object get(String key){
        return cacheMap.get(key);
    }

}
