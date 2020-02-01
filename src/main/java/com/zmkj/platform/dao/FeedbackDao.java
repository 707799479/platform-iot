package com.zmkj.platform.dao;

import com.zmkj.platform.entity.Feedback;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FeedbackDao {
    int addFeedback(@Param("iccid") String iccid, @Param("note") String note);
    int updateFeedback(Feedback feedback);
    Feedback findFeedback(Integer id);
    List<Feedback> findMyFeedback(String iccid);
    List<Feedback> findAllFeedback();
}
