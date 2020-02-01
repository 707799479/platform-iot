package com.zmkj.platform.entity;

import com.zmkj.platform.dao.ExtractDao;
import com.zmkj.platform.service.ExtractService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ExtractServiceImpl implements ExtractService {

    @Resource
    ExtractDao extractDao;

    @Override
    public int save(Extract extract) {
        return extractDao.saveExtract(extract);
    }

    @Override
    public int update(Integer id,Integer status) {
        return extractDao.updateExtract(id,status);
    }

    @Override
    public List<Extract> get() {
        return extractDao.findAllExtract();
    }

    @Override
    public List<Extract> getByAid(Integer aid) {
        return extractDao.findExtractByAid(aid);
    }

    @Override
    public Extract getById(Integer id) {
        return extractDao.findExtractById(id);
    }
}
