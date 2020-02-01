package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.CostDao;
import com.zmkj.platform.service.CostService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class CostServiceImpl implements CostService {
    @Resource
    CostDao costDao;


    @Override
    public List<Map> getCosts() {
        return costDao.findCosts();
    }

    @Override
    public int updateCost(Map map) {
        return costDao.updateCost(map);
    }

    @Override
    public int saveCost(Map map) {
        return costDao.insertCost(map);
    }

    @Override
    public int deleteCost(Integer id) {
        return costDao.deleteCost(id);
    }
}
