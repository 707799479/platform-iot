package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Extract;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ExtractDao {
    int saveExtract(Extract Extract);
    List<Extract> findExtractByAid(Integer aid);
    List<Extract> findAllExtract();
    int updateExtract(@Param("id") Integer id,@Param("status") Integer status);
    Extract findExtractById(Integer id);
}
