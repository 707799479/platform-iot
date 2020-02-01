package com.zmkj.platform.service;

import java.util.List;
import java.util.Map;

public interface TempOrderService {
    int saveTempOrder(Map<String,Object> map);
    List<Map<String,String>> queryAll();
    int update(Integer id);
}
