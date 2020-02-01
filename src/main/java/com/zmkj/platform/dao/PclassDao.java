package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Pclass;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PclassDao {
    /**
     * 查询共用的类别
     * @return
     */
    List<Pclass> findPclass(@Param("system_agent_id") Integer system_agent_id,@Param("agent_id") Integer agent_id);
    int savePclass(Pclass pclass);
    int updatePclass(Pclass pclass);
    int deletePclass(Integer id);
    int checkFreeCard(Integer pcid);
    Pclass findPclassById(Integer id);
}
