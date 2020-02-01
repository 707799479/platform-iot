package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.CommodityDao;
import com.zmkj.platform.entity.Commodity;
import com.zmkj.platform.service.CommodityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class CommodityServiceImpl implements CommodityService {

    @Resource
    CommodityDao commodityDao;

    @Override
    public List<Commodity> getCommodityList(Integer aid, Integer pid,Integer system_admin_id) {
        return commodityDao.findCommodityList(aid,pid,system_admin_id);
    }

    @Override
    public Commodity getCommodity(Integer aid,Integer cid,Integer pid) {
        return commodityDao.findCommodity(aid,cid,pid);
    }

    @Override
    public List<Commodity> getAllCommodity(Integer aid, Integer parent_id, Integer system_id) {
        return commodityDao.findAllCommodity(aid,parent_id,system_id);
    }

    @Override
    public List<Commodity> getClassCommodity(Integer aid, Integer cid, Integer parent_id, Integer system_id) {
        return commodityDao.findCLassCommodity(aid,cid,parent_id,system_id);
    }

    @Override
    public int saveCommodity(Commodity commodity) {
        return commodityDao.saveCommodity(commodity);
    }

    @Override
    public int deleteCommodity(Integer cid) {
        return commodityDao.deleteCommodity(cid);
    }

    @Override
    public int editCommodity(Commodity commodity) {
        return commodityDao.editCommodity(commodity);
    }

    @Override
    public Commodity getCommodityById(Integer id) {

        return commodityDao.findCommodityByid(id);
    }

}
