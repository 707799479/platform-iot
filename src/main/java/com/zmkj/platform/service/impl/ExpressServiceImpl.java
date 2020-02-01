package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.ExpressDao;
import com.zmkj.platform.entity.Express;
import com.zmkj.platform.service.ExpressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ExpressServiceImpl implements ExpressService {
    @Resource
    private ExpressDao expressDao;

    @Override
    public void saveExpress(List<Express> expList) {
        expressDao.saveExpress(expList);
    }

    @Override
    public List<Express> getList(String phone) {
        return expressDao.findExpress(phone);
    }

    @Override
    public int getExpressCount() {
        return expressDao.findExpressCount();
    }
}
