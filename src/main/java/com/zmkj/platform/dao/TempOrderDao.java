package com.zmkj.platform.dao;

import java.util.List;
import java.util.Map;

public interface TempOrderDao {
    int saveTempOrder(Map<String,Object> map);
    List<Map<String,String>> findAll();
    int update(int id);
}