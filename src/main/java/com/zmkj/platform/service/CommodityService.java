package com.zmkj.platform.service;

import com.zmkj.platform.entity.Commodity;

import java.util.List;

public interface CommodityService {
    public List<Commodity> getCommodityList(Integer aid,Integer pid,Integer system_admin_id);
    public Commodity getCommodity(Integer aid,Integer cid,Integer pid);
    public List<Commodity> getAllCommodity(Integer aid,Integer parent_id,Integer system_id);
    public List<Commodity> getClassCommodity(Integer aid,Integer cid,Integer parent_id,Integer system_id);
    public int saveCommodity(Commodity commodity);
    public int deleteCommodity(Integer cid);
    public int editCommodity(Commodity commodity);
    public Commodity getCommodityById(Integer id);
}
