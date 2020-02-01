package com.zmkj.platform.entity;

import sun.management.Agent;

/**
 * 价格实体
 */
public class Price {
    private Integer id;
    private Commodity commodity;
    private Double price;
    private Agents agent;
    private Double parentPrice;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Commodity getCommodity() {
        return commodity;
    }

    public void setCommodity(Commodity commodity) {
        this.commodity = commodity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Agents getAgent() {
        return agent;
    }

    public void setAgent(Agents agent) {
        this.agent = agent;
    }

    public Double getParentPrice() {
        return parentPrice;
    }

    public void setParentPrice(Double parentPrice) {
        this.parentPrice = parentPrice;
    }
}
