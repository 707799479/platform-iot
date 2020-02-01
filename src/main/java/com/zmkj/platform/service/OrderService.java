package com.zmkj.platform.service;

import com.zmkj.platform.entity.Order;

import java.util.List;

public interface OrderService {
    public Integer createOrder(Order order);
    List<Order> getMyOrder(Integer aid);
    List<Order> getAllOrder(Integer id);
    Integer updateOrder(Integer status,String number);
    List<Order> getMyOrderByStatus(Integer status, Integer aid,Integer cid);
    List<Order> getAllOrderByStatus(Integer status, Integer aid,Integer cid);
    Order getOrderByNo(String no);
    int getByPhoneCount(String iccid);
    Order getByIccid(String iccid);
}
