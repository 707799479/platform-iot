package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.PclassDao;
import com.zmkj.platform.entity.Pclass;
import com.zmkj.platform.service.PclassService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class PclassServiceImpl implements PclassService {
    @Resource
    PclassDao pclassDao;

    @Override
    public List<Pclass> getPclass(Integer system_agent_id,Integer agent_id) {
        return pclassDao.findPclass(system_agent_id,agent_id);
    }

    @Override
    public int savePclass(Pclass pclass) {
        return pclassDao.savePclass(pclass);
    }

    @Override
    public int updatePclass(Pclass pclass) {
        return pclassDao.updatePclass(pclass);
    }

    @Override
    public int deletePclass(Integer id) {
        return pclassDao.deletePclass(id);
    }

    @Override
    public int checkFreeCard(Integer pcid) {
        return pclassDao.checkFreeCard(pcid);
    }

    @Override
    public Pclass getPclassById(Integer id) {
        return pclassDao.findPclassById(id);
    }

}
