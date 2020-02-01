package com.zmkj.platform.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FreeCardDao {
    int insertData(Map<String,Object> map);
    List<Map<String,Object>> findDataByStatus(Integer status);
    int updateData(@Param("status") Integer status, @Param("id") Integer id);
    int checkData(Integer id);
}