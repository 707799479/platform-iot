package com.zmkj.platform.service;

import java.util.List;
import java.util.Map;

public interface PriceLogService {
    int save(Integer aid,String note,String number);
    int countPrice(Integer aid,String number);
    List<Map<String,Object>> getMyLogById(Integer aid);
}
