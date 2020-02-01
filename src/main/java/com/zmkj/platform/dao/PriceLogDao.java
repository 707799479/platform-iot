package com.zmkj.platform.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PriceLogDao {
    int save(@Param("aid") Integer aid, @Param("note") String note,@Param("number") String number);
    int findCount(@Param("aid") Integer aid, @Param("number") String number);
    List<Map<String,Object>> findMyLog(Integer aid);
}
