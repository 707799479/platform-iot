package com.zmkj.platform.common;

import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.entity.Pclass;
import com.zmkj.platform.service.AgentsService;
import com.zmkj.platform.service.ConfigService;
import com.zmkj.platform.service.CostService;
import com.zmkj.platform.service.PclassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 启动类
 */
@Component
public class Loader implements CommandLineRunner {

    @Autowired
    private ConfigService configService;

    @Autowired
    private CostService costService;

    @Autowired
    private AgentsService agentsService;

    @Override
    public void run(String... var1) throws Exception{
        System.out.println("This will be execute when the project was started!");
        loadConfig();
        loadCost();
        loadSystemAgent();
    }

    /**
     * 加载配置
     */
    public void loadConfig(){
        //开始时间
        long startTime = System.currentTimeMillis();

        Map<String,Object> configMap = configService.getConfig();
        MemCache.put("website_config",configMap);

        System.out.println("load website_config success :"+(System.currentTimeMillis()-startTime));
    }

    /**
     * 加载实时资费
     */
    public void loadCost(){
        long startTime = System.currentTimeMillis();

        List<Map> costList = costService.getCosts();
        MemCache.put("website_cost",costList);

        System.out.println("load website_cost success :"+(System.currentTimeMillis()-startTime));
    }

    /**
     * 系统共用用户
     */
    public void loadSystemAgent(){
        long startTime = System.currentTimeMillis();

        Agents system_admin = agentsService.getAgentsAdmin();
        MemCache.put("system_admin",system_admin);

        System.out.println("load system_admin success :"+(System.currentTimeMillis()-startTime));
    }

}
