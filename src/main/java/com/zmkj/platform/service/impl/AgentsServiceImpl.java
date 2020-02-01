package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.AgentsDao;
import com.zmkj.platform.dao.PriceDao;
import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.service.AgentsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AgentsServiceImpl implements AgentsService {
    @Resource
    AgentsDao agentsDao;

    @Resource
    PriceDao priceDao;

    @Override
    public Agents getAgents(String domain) {
        return agentsDao.findAgents(domain);
    }

    @Override
    public Integer createAgent(Agents agent,Integer systemId) {
        agent.setAgentPrice(10.00);

        //开通代理，给这个代理创建对应的包邮价。
        int result = agentsDao.saveAgent(agent);

        return result;
    }

    @Override
    public Agents login(String account,String password) {
        Agents agent = agentsDao.findAgentsByAccount(account);
        if(agent != null){
            if(agent.getPassword().equals(password)){
                return agent;
            }
        }
        return null;
    }

    @Override
    public Integer updateAgent(Agents agent) {
        return agentsDao.updateAgent(agent);
    }

    @Override
    public Agents getAgentsByAccount(String account) {
        return agentsDao.findAgentsByAccount(account);
    }

    @Override
    public Agents getAgentsAdmin() {
        return agentsDao.findAgentsAdmin();
    }

    @Override
    public List<Agents> getMyAgents(Integer aid) {
        return agentsDao.findMyAgents(aid);
    }

    @Override
    public Integer deleteAgent(Integer id) {
        return agentsDao.deleteAgent(id);
    }

    @Override
    public Integer getNewPwd(Integer id) {
        return agentsDao.getNewPwd(id);
    }

    @Override
    public Integer getAccountNum(String account) {
        return agentsDao.findAccountNum(account);
    }

    @Override
    public Integer getDomainNum(String domain) {
        return agentsDao.findDomainNum(domain);
    }

    @Override
    public Agents getAgentsById(Integer id) {
        return agentsDao.findAgentsById(id);
    }

    @Override
    public double getTodayMoney(Integer aid) {
        return agentsDao.findTodayMoney(aid);
    }
}
