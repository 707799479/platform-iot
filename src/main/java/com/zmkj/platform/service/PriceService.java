package com.zmkj.platform.service;

import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.entity.Commodity;
import com.zmkj.platform.entity.Price;

public interface PriceService {
    public void savePrice(Agents agent, Commodity commodity);
    public int updatePrice(Price price);
    public int updateAgentPrice(Price price);
    public int savePrice(Price price);
    Price getPriceById(Integer id);
    Price getPriceByAidAndCid(Integer aid,Integer cid);
    int deletePrice(Integer id);
    int deleteByCid(Integer cid);
}
