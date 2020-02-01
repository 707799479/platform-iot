package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Commodity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommodityDao {
    List<Commodity> findCommodityList(@Param("aid") Integer aid, @Param("pid") Integer pid,@Param("system_admin_id") Integer system_admin_id);
    Commodity findCommodity(@Param("aid") Integer aid,@Param("cid") Integer cid,@Param("parent_id") Integer parent_id);
    List<Commodity> findAllCommodity(@Param("aid") Integer aid,@Param("parent_id")Integer parent_id,@Param("system_id")Integer system_id);
    List<Commodity> findCLassCommodity(@Param("aid") Integer aid,@Param("cid") Integer cid,@Param("parent_id")Integer parent_id,@Param("system_id")Integer system_id);
    int saveCommodity(Commodity commodity);
    int deleteCommodity(Integer cid);
    int editCommodity(Commodity commodity);
    Commodity findCommodityByid(Integer id);


}
