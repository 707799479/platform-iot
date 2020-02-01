package com.zmkj.platform.service;

import com.zmkj.platform.entity.Pclass;

import java.util.List;

public interface PclassService {
    public List<Pclass> getPclass(Integer system_agent_id,Integer agent_id);
    public int savePclass(Pclass pclass);
    public int updatePclass(Pclass pclass);
    public int deletePclass(Integer id);

    int  checkFreeCard(Integer pcid);
    Pclass getPclassById(Integer id);
}
