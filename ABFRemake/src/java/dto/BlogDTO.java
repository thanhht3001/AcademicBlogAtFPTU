/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

/**
 *
 * @author To Quyen Phan
 */
public class BlogDTO{
    private int blogID;
    private int userID;
    private int userApproveID;
    private int subjectID;
    private String title;
    private String content;
    private String date;
    private String image;
    private String video;
    private int numberOfVotes;
    private int numberOfComments;
    private String status;
    private String fullName;
    private int award;

    public BlogDTO() {
        this.userID = 0;
        this.userApproveID = 0;
        this.subjectID = 0;
        this.title = "";
        this.content = "";
        this.date = "";
        this.image = "";
        this.video = "";
        this.numberOfVotes = 0;
        this.numberOfComments = 0;
        this.status = "";
        this.fullName = "";
        this.award = 0;
    }

    public BlogDTO(int blogID, int userID, int userApproveID, int subjectID, String title, String content, String date, String image, String video, int numberOfVotes, int numberOfComments, String status, String fullName,  int award) {
        this.blogID = blogID;
        this.userID = userID;
        this.userApproveID = userApproveID;
        this.subjectID = subjectID;
        this.title = title;
        this.content = content;
        this.date = date;
        this.image = image;
        this.video = video;
        this.numberOfVotes = numberOfVotes;
        this.numberOfComments = numberOfComments;
        this.status = status;
        this.fullName = fullName;
        this.award = award;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getUserApproveID() {
        return userApproveID;
    }

    public void setUserApproveID(int userApproveID) {
        this.userApproveID = userApproveID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public int getNumberOfVotes() {
        return numberOfVotes;
    }

    public void setNumberOfVotes(int numberOfVotes) {
        this.numberOfVotes = numberOfVotes;
    }

    public int getNumberOfComments() {
        return numberOfComments;
    }

    public void setNumberOfComments(int numberOfComments) {
        this.numberOfComments = numberOfComments;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getAward() {
        return award;
    }

    public void setAward(int award) {
        this.award = award;
    }

    public static Comparator compareDate = new Comparator(){
        public int compare(Object obj1, Object obj2){
            BlogDTO b1 = (BlogDTO) obj1;
            BlogDTO b2 = (BlogDTO) obj2;
             int t = 0;
            String[] dateTime1 = b1.getDate().trim().split(" ");
            String[] dateTime2 = b2.getDate().trim().split(" ");
            SimpleDateFormat sdate1 = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdate2 = new SimpleDateFormat("dd/MM/yyyy");
            try {
               
                Date date1 = sdate1.parse(dateTime1[0]);
                Date date2 = sdate2.parse(dateTime2[0]);
                if(date1.after(date2)){
                    t = 1;
                }else if(date1.before(date2)){
                    t = -1;
                }else{
                    t = dateTime1[1].compareTo(dateTime2[1]);
                }
                
            } catch (Exception e) {
               e.printStackTrace();
            }
           return -t; 
        }
    };
}
