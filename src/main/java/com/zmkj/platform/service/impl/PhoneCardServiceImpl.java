package com.zmkj.platform.service.impl;

import com.alibaba.fastjson.JSON;
import com.zmkj.platform.common.MemCache;
import com.zmkj.platform.common.PathValue;
import com.zmkj.platform.dao.AgentsDao;
import com.zmkj.platform.dao.PhoneCardDao;
import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.CoreFunction;
import com.zmkj.platform.util.WFyidong;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PhoneCardServiceImpl implements PhoneCardService {

    @Resource
    PhoneCardDao phoneCardDao;
    @Resource
    AgentsDao agentsDao;



    @Override
    public List<Map<String, Object>> getAllPhoneCard(Integer pcid) {
        return phoneCardDao.findAllPhoneCard(pcid);
    }

    @Override
    public Map<String, Object> getPhoneCardByIccid(String iccid) {
        return phoneCardDao.findPhoneCardByIccid(iccid);
    }

    @Override
    public Map<String, Object> getPhoneCardByMsisdn(String msisdn) {
        return phoneCardDao.findPhoneCardByMsisdn(msisdn);
    }

    @Override
    public Integer update(Map<String, Object> map) {
        return phoneCardDao.update(map);
    }

    @Override
    public int outData(String iccid) {
        return phoneCardDao.outData(iccid);
    }

    @Override
    public int updateNote(String note, String iccid) {
        return phoneCardDao.updateNote(note,iccid);
    }

    @Override
    public List<Map<String, Object>> getAllByPcid(Integer pcid) {
        return phoneCardDao.findAllByPcid(pcid);
    }

    @Override
    public int updateDown(Integer id) {
        return phoneCardDao.updateDown(id);
    }

    @Override
    public int updateData(Integer cid, Integer pcid, String data) {
        return phoneCardDao.updateData(cid,pcid,data);
    }

    @Override
    public List<String> getTempPhones() {
        return phoneCardDao.findPhones();
    }

    @Override
    public int updateXianSu(Integer id, Integer xiansu) {
        return phoneCardDao.updateXianSu(id,xiansu);
    }

    @Override
    public int payUpdate(Integer id, Integer ccid, boolean isCi,String oldData) {
        return phoneCardDao.payUpdate(id,ccid,isCi,oldData);
    }

    @Override
    public int updateTempPhone(String iccid) {
        return phoneCardDao.updateTempPhone(iccid);
    }

    @Override
    public Map<String, String> getStartEndDate(Integer day,String iccid) {
        return phoneCardDao.findStartEndDate(day,iccid);
    }

    @Override
    public int updateGoTime(String msisdn) {
        return phoneCardDao.updateGoTime(msisdn);
    }

    @Override
    public int 取消次月套餐(String iccid) {
        return phoneCardDao.取消次月套餐(iccid);
    }

    /**
     * 卡片列表Data
     * @param pcid
     * @param limit
     * @param first
     * @param search
     * @return
     */
    @Override
    public String getCardListData(Integer aid,Integer limit,Integer first,String search) {
        Map<String,Object> config = (Map<String, Object>) MemCache.get("website_config");
        double xj = (double) config.get("number");
        if(search.length() <= 1){
            search = null;
        }
        List<Map<String,Object>> mapList;
        int total = 0;
        mapList = phoneCardDao.findPhoneCardByCidPage(aid,limit,first,search);
        total = phoneCardDao.findPhoneCardCountByCid(aid,search);
        for(Map<String,Object> phone:mapList){
            if(phone.get("phone") != null){
                phone.put("grant","已实名");
            }else{
                phone.put("grant","未实名");
            }
            double data = 0.0;
            String status = "";
            Map<String,Object> configMap = (Map<String,Object>)MemCache.get("website_config");
            switch (Integer.parseInt(phone.get("pcid").toString())){
                case 1:

                    data = WFyidong.query(phone.get("iccid").toString());
                    if(data > 1){

                        data = data / Double.parseDouble(configMap.get("number").toString());
                    }
                    break;
                case 3:
                    data = CoreFunction.dxQuery(phone.get("msisdn").toString());
                    String result = CoreFunction.dxStatus(phone.get("msisdn").toString());
                    switch (result){
                        case "1":
                            status = "可激活";
                            break;
                        case "4":
                            status = "在用";
                            break;
                        case "5":
                            status = "停机";
                            break;
                        case "6":
                            status = "运营商管理状态";
                            break;
                        default:
                            status = result;
                            break;
                    }
                    break;
                case 4:
                    data = CoreFunction.ydQuery(phone.get("msisdn").toString());
                    status = CoreFunction.ydInfo(phone.get("msisdn").toString());
                    break;
                default:
                    break;
            }
            String myStatus = "";
            if(phone.get("cid")==null && phone.get("upcid")==null && phone.get("ccid") == null){
                myStatus = "未充值";
            }else if(phone.get("cid") == null && phone.get("ccid") != null && phone.get("ccid") == null){
                myStatus = "流量已用尽或者到期";
            }else if(phone.get("cid")!=null){
                myStatus = "在用";
            }else if(phone.get("ccid") != null){
                myStatus = "次月生效";
            }
            data = data / xj;
            phone.put("data",data);
            phone.put("status",status);
            phone.put("myStatus",myStatus);
        }
        Map<String,Object> sumMap = new HashMap<>();
        sumMap.put("total",total);
        sumMap.put("rows",mapList);
        return JSON.toJSONString(sumMap);
    }

    /**
     * 传入iccid，用户aid，和开始数值结束数组 系统来处理分配卡
     * 返回数组下标0为成功个数 1位失败个数
     * @param aid
     * @param start
     * @param end
     * @return
     */
    @Override
    public int[] updateCard(Integer aid,long start,long end,int paid) {
        int success = 0;
        int error = 0;

        while (start != end+1) {

            int r = phoneCardDao.updateCard(PathValue.CARD_START_NUMBER+start,aid,paid);
            if(r == 1){
                success ++;
            }else{
                error ++;
            }
            start++;
        }
        int[] result = {success,error};
        return result;
    }

    @Override
    public int updateCardOne(Integer aid, String cardNumber,int paid) {

        return phoneCardDao.updateCard(cardNumber,aid,paid);
    }

}
