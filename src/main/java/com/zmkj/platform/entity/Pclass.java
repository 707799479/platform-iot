package com.zmkj.platform.entity;

/**
 * 分类的实体
 */
public class Pclass {
    private Integer id;
    private String name;
    private Integer sort;
    private Agents agent;
    private String note;
    private Integer is30;

    public Integer getIs30() {
        return is30;
    }

    public void setIs30(Integer is30) {
        this.is30 = is30;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Agents getAgent() {
        return agent;
    }

    public void setAgent(Agents agent) {
        this.agent = agent;
    }
}
