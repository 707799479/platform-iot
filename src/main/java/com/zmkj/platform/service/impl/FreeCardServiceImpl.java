package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.FreeCardDao;
import com.zmkj.platform.service.FreeCardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class FreeCardServiceImpl implements FreeCardService {

    @Resource
    FreeCardDao freeCardDao;

    @Override
    public int saveData(Map<String, Object> map) {
        return freeCardDao.insertData(map);
    }

    @Override
    public int updateData(Integer status, Integer id) {
        return freeCardDao.updateData(status,id);
    }

    @Override
    public List<Map<String, Object>> getDataByStatus(Integer status) {
        return freeCardDao.findDataByStatus(status);
    }

    @Override
    public int checkData(Integer id) {
        return freeCardDao.checkData(id);
    }
}

