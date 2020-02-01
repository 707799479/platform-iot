package com.zmkj.platform.service;

import com.zmkj.platform.entity.Extract;

import java.util.List;

public interface ExtractService {
    int save(Extract extract);
    int update(Integer id,Integer status);
    List<Extract> get();
    List<Extract> getByAid(Integer aid);
    Extract getById(Integer id);
}
