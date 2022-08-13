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
public class CommentDTO {
    private int commentID;
    private int blogID;
    private int userID;
    private String content;
    private String date;
    private String status;

    public CommentDTO() {
    }

    public CommentDTO(int commentid, int blogID, int userID, String content, String date, String status) {
        this.commentID = commentid;
        this.blogID = blogID;
        this.userID = userID;
        this.content = content;
        this.date = date;
        this.status = status;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
