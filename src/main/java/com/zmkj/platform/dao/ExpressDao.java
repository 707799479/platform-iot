package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Express;

import java.util.List;

public interface ExpressDao {
    public void saveExpress(List<Express> expList);

    public List<Express> findExpress(String phone);

    public int findExpressCount();
}
