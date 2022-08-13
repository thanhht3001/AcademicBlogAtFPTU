/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author Bat
 */
public class SubjectDTO {
    private int subjectID;
    private int majorID;
    private String subjectName;
    private String status;

    public SubjectDTO() {
    }

    public SubjectDTO(int subjectID, int majorID, String subjectName, String status) {
        this.subjectID = subjectID;
        this.majorID = majorID;
        this.subjectName = subjectName;
        this.status = status;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public int getMajorID() {
        return majorID;
    }

    public void setMajorID(int majorID) {
        this.majorID = majorID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
