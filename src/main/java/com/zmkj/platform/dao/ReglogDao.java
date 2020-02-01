package com.zmkj.platform.dao;

import org.apache.ibatis.annotations.Param;

public interface ReglogDao {
    int saveLog(@Param("aid")String aid,@Param("price") double price);
}
