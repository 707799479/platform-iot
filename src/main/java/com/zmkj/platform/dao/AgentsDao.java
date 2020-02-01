package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Agents;

import java.util.List;

public interface AgentsDao {
    public Agents findAgents(String domain);
    public int saveAgent(Agents agent);
    public int updateAgent(Agents agent);
    public Agents findAgentsByAccount(String account);
    public Agents findAgentsAdmin();
    Agents findAgentsById(Integer id);
    public List<Agents> findMyAgents(Integer aid);
    public int deleteAgent(Integer id);
    public int getNewPwd(Integer id);
    public int findAccountNum(String account);
    int findDomainNum(String domain);
    double findTodayMoney(Integer aid);


}