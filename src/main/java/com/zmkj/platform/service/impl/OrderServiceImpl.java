package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.OrderDao;
import com.zmkj.platform.entity.Order;
import com.zmkj.platform.service.OrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    OrderDao orderDao;

    @Override
    public Integer createOrder(Order order) {
        return orderDao.insertOrder(order);
    }

    @Override
    public List<Order> getMyOrder(Integer aid) {
        return orderDao.findMyOrder(aid);
    }

    @Override
    public List<Order> getAllOrder(Integer id) {
        return orderDao.findAllOrder(id);
    }

    @Override
    public Integer updateOrder(Integer status,String number) {
        return orderDao.updateOrder(status,number);
    }

    @Override
    public List<Order> getMyOrderByStatus(Integer status, Integer aid,Integer cid) {
        return orderDao.findMyOrderByStatus(status,aid,cid);
    }

    @Override
    public List<Order> getAllOrderByStatus(Integer status, Integer aid,Integer cid) {
        return orderDao.findAllOrderByStatus(status,aid,cid);
    }

    @Override
    public Order getOrderByNo(String no) {
        return orderDao.findOrderByNo(no);
    }

    @Override
    public int getByPhoneCount(String iccid) {
        return orderDao.findByPhoneCount(iccid);
    }

    @Override
    public Order getByIccid(String iccid) {
        return orderDao.findByIccid(iccid);
    }
}
