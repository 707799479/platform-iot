package com.zmkj.platform.entity;

import java.util.Date;

/**
 * 订单实体
 */
public class Order {
    private Integer id;
    private String number;
    private Date createTime;
    private Integer status;
    private Commodity commodity;
    private Price price;
    private String xdName;
    private String xdPhone;
    private String xdAddress;
    private String imgUrl;
    private String imgUrl2;
    private String imgUrl3;
    private Integer count;
    private Agents agent;
    private String payType;
    private Double totalPrice;
    private String sfid;

    public String getSfid() {
        return sfid;
    }

    public void setSfid(String sfid) {
        this.sfid = sfid;
    }

    public Price getPid() {
        return price;
    }

    public void setPid(Price price) {
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Commodity getCommodity() {
        return commodity;
    }

    public void setCommodity(Commodity commodity) {
        this.commodity = commodity;
    }

    public String getXdName() {
        return xdName;
    }

    public void setXdName(String xdName) {
        this.xdName = xdName;
    }

    public String getXdPhone() {
        return xdPhone;
    }

    public void setXdPhone(String xdPhone) {
        this.xdPhone = xdPhone;
    }

    public String getXdAddress() {
        return xdAddress;
    }

    public void setXdAddress(String xdAddress) {
        this.xdAddress = xdAddress;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getImgUrl2() {
        return imgUrl2;
    }

    public void setImgUrl2(String imgUrl2) {
        this.imgUrl2 = imgUrl2;
    }

    public String getImgUrl3() {
        return imgUrl3;
    }

    public void setImgUrl3(String imgUrl3) {
        this.imgUrl3 = imgUrl3;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Agents getAgent() {
        return agent;
    }

    public void setAgent(Agents agent) {
        this.agent = agent;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
