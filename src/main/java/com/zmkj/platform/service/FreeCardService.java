package com.zmkj.platform.service;

import java.util.List;
import java.util.Map;

public interface FreeCardService {
    int saveData(Map<String,Object> map);
    int updateData(Integer status,Integer id);
    List<Map<String,Object>> getDataByStatus(Integer status);
    int checkData(Integer id);
}
