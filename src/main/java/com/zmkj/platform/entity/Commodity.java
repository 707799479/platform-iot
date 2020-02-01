package com.zmkj.platform.entity;

/**
 * 商品实体
 */
public class Commodity {
    private Integer id;
    private Pclass pclass;
    private String name;
    private Agents agent;
    private Integer sort;
    private String imgUrl;
    private String note;
    private Integer haveImg;
    private Double price;
    private Double agentPrice;
    private Double parentPrice;
    private Integer priceId;
    private String xuliang;
    private String xiansu;
    private Integer day;

    public Integer getDay() {
        return day;
    }

    public void setDay(Integer day) {
        this.day = day;
    }

    public String getXuliang() {
        return xuliang;
    }

    public void setXuliang(String xuliang) {
        this.xuliang = xuliang;
    }

    public String getXiansu() {
        return xiansu;
    }

    public void setXiansu(String xiansu) {
        this.xiansu = xiansu;
    }

    public Integer getPriceId() {
        return priceId;
    }

    public void setPriceId(Integer priceId) {
        this.priceId = priceId;
    }

    public Double getAgentPrice() {
        return agentPrice;
    }

    public void setAgentPrice(Double agentPrice) {
        this.agentPrice = agentPrice;
    }

    public Double getParentPrice() {
        return parentPrice;
    }

    public void setParentPrice(Double parentPrice) {
        this.parentPrice = parentPrice;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Pclass getPclass() {
        return pclass;
    }

    public void setPclass(Pclass pclass) {
        this.pclass = pclass;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Agents getAgent() {
        return agent;
    }

    public void setAgent(Agents agent) {
        this.agent = agent;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Integer getHaveImg() {
        return haveImg;
    }

    public void setHaveImg(Integer haveImg) {
        this.haveImg = haveImg;
    }
}
