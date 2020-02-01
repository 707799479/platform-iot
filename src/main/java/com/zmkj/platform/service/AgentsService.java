package com.zmkj.platform.service;

import com.zmkj.platform.entity.Agents;

import java.util.List;

public interface AgentsService {
    public Agents getAgents(String domain);
    public Integer createAgent(Agents agent,Integer systemId);
    public Agents login(String account,String password);
    public Integer updateAgent(Agents agent);
    public Agents getAgentsByAccount(String account);
    public Agents getAgentsAdmin();
    List<Agents> getMyAgents(Integer aid);
    public Integer deleteAgent(Integer id);
    public Integer getNewPwd(Integer id);
    public Integer getAccountNum(String account);
    Integer getDomainNum(String domain);
    Agents getAgentsById(Integer id);
    double getTodayMoney(Integer aid);
}
