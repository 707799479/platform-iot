package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Price;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PriceDao {
    public int savePrice(Price price);
    public int updatePrice(Price price);
    public int updateAgentPrice(Price price);
    List<Price> findPriceByAid(Integer id);
    Price findPriceByAidAndCid(@Param("id") Integer id,@Param("cid") Integer cid);
    public Price findPriceById(Integer id);
    int deletePrice(Integer id);
    int deleteByCid(Integer cid);
}
