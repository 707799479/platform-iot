package com.zmkj.platform.service;

import com.zmkj.platform.entity.Feedback;

import java.util.List;

public interface FeedbackService {
    int addFeedback(String iccid,String note);
    int updateFeedback(Feedback feedback);
    Feedback getFeedback(Integer id);
    List<Feedback> getMyFeedback(String iccid);
    List<Feedback> getAllFeedback();
}
