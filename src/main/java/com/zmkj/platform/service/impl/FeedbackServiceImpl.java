package com.zmkj.platform.service.impl;

import com.zmkj.platform.dao.FeedbackDao;
import com.zmkj.platform.entity.Feedback;
import com.zmkj.platform.service.FeedbackService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FeedbackServiceImpl implements FeedbackService {
    @Resource
    FeedbackDao feedbackDao;


    @Override
    public int addFeedback(String iccid, String note) {
        return feedbackDao.addFeedback(iccid,note);
    }

    @Override
    public int updateFeedback(Feedback feedback) {
        return feedbackDao.updateFeedback(feedback);
    }

    @Override
    public Feedback getFeedback(Integer id) {
        return feedbackDao.findFeedback(id);
    }

    @Override
    public List<Feedback> getMyFeedback(String iccid) {
        return feedbackDao.findMyFeedback(iccid);
    }

    @Override
    public List<Feedback> getAllFeedback() {
        return feedbackDao.findAllFeedback();
    }
}
