package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderDao {
    int insertOrder(Order order);
    List<Order> findMyOrder(Integer aid);
    List<Order> findAllOrder(Integer id);
    int updateOrder(@Param("status")Integer status,@Param("number") String number);
    List<Order> findMyOrderByStatus(@Param("status")Integer status,@Param("aid") Integer aid,@Param("cid")Integer cid);
    List<Order> findAllOrderByStatus(@Param("status")Integer status,@Param("aid") Integer aid,@Param("cid")Integer cid);
    Order findOrderByNo(String no);

    int findByPhoneCount(String iccid);

    Order findByIccid(String iccid);
}
