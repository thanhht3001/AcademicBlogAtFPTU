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
public class ActivityDTO {
    private int historyActivityID;
    private int userID;
    private String date;
    private String activity;

    public ActivityDTO() {
    }

    public ActivityDTO(int historyActivityID, int userID, String date, String activity) {
        this.historyActivityID = historyActivityID;
        this.userID = userID;
        this.date = date;
        this.activity = activity;
    }

    public int getHistoryActivityID() {
        return historyActivityID;
    }

    public void setHistoryActivityID(int historyActivityID) {
        this.historyActivityID = historyActivityID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }
}
