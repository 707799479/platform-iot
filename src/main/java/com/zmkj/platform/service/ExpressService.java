package com.zmkj.platform.service;

import com.zmkj.platform.entity.Express;

import java.util.List;

public interface ExpressService {
    public void saveExpress(List<Express> expList);
    public List<Express> getList(String phone);
    public int getExpressCount();
}
