/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;


/**
 *
 * @author To Quyen Phan
 */
public class FeedbackTypeDTO {
    private int feedbackTypeID;
    private String feedbackName;

    public FeedbackTypeDTO() {
    }

    public FeedbackTypeDTO(int feedbackTypeID, String feedbackName) {
        this.feedbackTypeID = feedbackTypeID;
        this.feedbackName = feedbackName;
    }

    public int getFeedbackTypeID() {
        return feedbackTypeID;
    }

    public void setFeedbackTypeID(int feedbackTypeID) {
        this.feedbackTypeID = feedbackTypeID;
    }

    public String getFeedbackName() {
        return feedbackName;
    }

    public void setFeedbackName(String feedbackName) {
        this.feedbackName = feedbackName;
    }
}
