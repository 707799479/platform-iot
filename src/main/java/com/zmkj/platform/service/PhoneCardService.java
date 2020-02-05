package com.zmkj.platform.service;

import java.util.List;
import java.util.Map;

public interface PhoneCardService {
	/**
	 * 获取激活卡数量
	 * @param aid 代理id
	 * @return
	 */
	int phoneCardByCount(Integer aid);
    List<Map<String,Object>> getAllPhoneCard(Integer pcid);
    Map<String,Object> getPhoneCardByIccid(String iccid);
    Map<String,Object> getPhoneCardByMsisdn(String msisdn);
    Integer update(Map<String,Object> map);
    int outData(String iccid);
    int updateNote(String note,String iccid);
    List<Map<String,Object>> getAllByPcid(Integer pcid);
    int updateDown(Integer id);
    int updateData(Integer cid,Integer pcid,String data);
    List<String> getTempPhones();
    int updateXianSu(Integer id,Integer xiansu);
    int payUpdate(Integer id,Integer ccid,boolean isCi,String oldData);
    int updateTempPhone(String iccid);
    Map<String,String> getStartEndDate(Integer day,String iccid);

    int updateGoTime(String msisdn);
    int 取消次月套餐(String iccid);

    String getCardListData(Integer aid,Integer limit,Integer first,String search);
    int[] updateCard(Integer aid,long start,long end,int paid);
    int updateCardOne(Integer aid,String cardNumber,int paid);

}
