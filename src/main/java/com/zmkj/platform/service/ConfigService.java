package com.zmkj.platform.service;

import java.util.Map;

public interface ConfigService {
    public Map getConfig();
    public int saveConfig(Map<String,Object> map);
}
