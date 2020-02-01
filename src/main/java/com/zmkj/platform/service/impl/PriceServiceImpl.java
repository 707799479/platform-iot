package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.PriceDao;
import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.entity.Commodity;
import com.zmkj.platform.entity.Price;
import com.zmkj.platform.service.PriceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class PriceServiceImpl implements PriceService {
    @Resource
    PriceDao priceDao;

    @Override
    public void savePrice(Agents agent, Commodity commodity) {
        Price price = new Price();
        price.setAgent(agent);
        price.setCommodity(commodity);
        price.setPrice(commodity.getPrice());
        price.setParentPrice(commodity.getParentPrice());
        priceDao.savePrice(price);
    }

    @Override
    public int updatePrice(Price price) {
        return priceDao.updatePrice(price);
    }

    @Override
    public int updateAgentPrice(Price price) {
        return priceDao.updateAgentPrice(price);
    }

    @Override
    public int savePrice(Price price) {
        return priceDao.savePrice(price);
    }

    @Override
    public Price getPriceById(Integer id) {
        return priceDao.findPriceById(id);
    }

    @Override
    public Price getPriceByAidAndCid(Integer aid, Integer cid) {
        return priceDao.findPriceByAidAndCid(aid,cid);
    }

    @Override
    public int deletePrice(Integer id) {
        return priceDao.deletePrice(id);
    }

    @Override
    public int deleteByCid(Integer cid) {
        return priceDao.deleteByCid(cid);
    }

}
