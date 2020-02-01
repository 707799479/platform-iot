package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.TempOrderDao;
import com.zmkj.platform.service.TempOrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
@Service
public class TempOrderServiceImpl implements TempOrderService {
    @Resource
    TempOrderDao tempOrderDao;

    @Override
    public int saveTempOrder(Map<String, Object> map) {
        return tempOrderDao.saveTempOrder(map);
    }

    @Override
    public List<Map<String, String>> queryAll() {
        return tempOrderDao.findAll();
    }

    @Override
    public int update(Integer id) {
        return tempOrderDao.update(id);
    }
}
