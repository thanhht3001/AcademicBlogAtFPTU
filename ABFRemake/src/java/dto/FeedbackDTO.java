/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.Comparator;

/**
 *
 * @author To Quyen Phan
 */
public class FeedbackDTO {
    private int feedbackID;
    private int userID;
    private int feedbackTypeID;
    private String description;
    private String date;

    public FeedbackDTO() {
    }

    public FeedbackDTO(int feedbackID, int userID, int feedbackTypeID, String description, String date) {
        this.feedbackID = feedbackID;
        this.userID = userID;
        this.feedbackTypeID = feedbackTypeID;
        this.description = description;
        this.date = date;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getFeedbackTypeID() {
        return feedbackTypeID;
    }

    public void setFeedbackTypeID(int feedbackTypeID) {
        this.feedbackTypeID = feedbackTypeID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public static Comparator compareDate = new Comparator(){
        public int compare(Object obj1, Object obj2){
            FeedbackDTO f1 = (FeedbackDTO) obj1;
            FeedbackDTO f2 = (FeedbackDTO) obj2;
            int t = f1.getDate().compareTo(f2.getDate());
            return -t;
        }
    };
}
