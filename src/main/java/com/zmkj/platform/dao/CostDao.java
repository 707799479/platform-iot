package com.zmkj.platform.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CostDao {
    public List<Map> findCosts();
    int updateCost(Map map);
    int insertCost(Map map);
    int deleteCost(Integer id);
}
