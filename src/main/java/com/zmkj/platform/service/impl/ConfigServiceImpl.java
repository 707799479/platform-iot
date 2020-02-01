package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.ConfigDao;
import com.zmkj.platform.service.ConfigService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;
@Service
public class ConfigServiceImpl implements ConfigService {

    @Resource
    ConfigDao configDao;


    @Override
    public Map getConfig() {
        return configDao.findConfig();
    }

    @Override
    public int saveConfig(Map<String, Object> map) {

        return configDao.saveConfig(map);
    }

}
