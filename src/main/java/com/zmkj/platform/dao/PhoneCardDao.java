package com.zmkj.platform.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PhoneCardDao {
	
	int phoneCardByCount(Integer aid);
    List<Map<String,Object>> findAllPhoneCard(Integer pcid);
    Map<String,Object> findPhoneCardByMsisdn(String msisdn);
    Map<String,Object> findPhoneCardByIccid(String iccid);
    int update(Map<String,Object> map);
    int outData(String iccid);
    int updateNote(@Param("note") String note,@Param("iccid") String iccid);
    List<Map<String,Object>> findAllByPcid(Integer pcid);
    int updateDown(Integer id);

    List<String> findPhones();

    int updateData(@Param("cid") Integer cid, @Param("pcid") Integer pcid, @Param("data") String data);

    int updateXianSu(@Param("id") Integer id, @Param("xiansu") Integer xiansu);

    int payUpdate(@Param("id") Integer id, @Param("ccid") Integer ccid, @Param("isCi") boolean isCi, @Param("oldData") String oldData);

    int updateTempPhone(String iccid);

    Map<String,String> findStartEndDate(@Param("day") Integer day, @Param("iccid") String iccid);

    int updateGoTime(String msisdn);

    int 取消次月套餐(String iccid);

    List<Map<String,Object>> findPhoneCardByCidPage(@Param("aid")Integer aid, @Param("limit") Integer limit, @Param("first") Integer first,@Param("search") String search);
    int findPhoneCardCountByCid(@Param("aid") Integer aid, @Param("search") String search);

    int updateCard(@Param("iccid") String iccid, @Param("aid") Integer aid,@Param("paid")Integer paid);

    int findMyCard(Integer aid);
}
