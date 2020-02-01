package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.PriceLogDao;
import com.zmkj.platform.service.PriceLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class PriceLogServiceImpl implements PriceLogService {

    @Resource
    PriceLogDao priceLogDao;

    @Override
    public int save(Integer aid,String note,String number) {
        return priceLogDao.save(aid,note,number);
    }

    @Override
    public int countPrice(Integer aid, String number) {
        return priceLogDao.findCount(aid,number);
    }

    @Override
    public List<Map<String, Object>> getMyLogById(Integer aid) {
        return priceLogDao.findMyLog(aid);
    }

}
