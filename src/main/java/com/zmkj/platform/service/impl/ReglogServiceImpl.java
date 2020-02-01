package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.ReglogDao;
import com.zmkj.platform.service.ReglogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ReglogServiceImpl implements ReglogService {
    @Resource
    ReglogDao reglogDao;

    @Override
    public int saveLog(String aid, double price) {
        return reglogDao.saveLog(aid,price);
    }
}
