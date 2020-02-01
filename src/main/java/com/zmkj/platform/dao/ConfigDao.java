package com.zmkj.platform.dao;

import java.util.Map;

public interface ConfigDao {
    public Map findConfig();
    public int saveConfig(Map<String,Object> map);
}
