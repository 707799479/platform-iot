package com.zmkj.platform.entity;

import java.util.Date;

/**
 * 单号实体
 */
public class Express {
    private Integer id;
    private String expressNumber;
    private String xdName;
    private String xdPhone;
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getExpressNumber() {
        return expressNumber;
    }

    public void setExpressNumber(String expressNumber) {
        this.expressNumber = expressNumber;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
