package com.zmkj.platform.service;

import java.util.List;
import java.util.Map;

public interface CostService {
    public List<Map> getCosts();
    int updateCost(Map map);
    int saveCost(Map map);
    int deleteCost(Integer id);
}
