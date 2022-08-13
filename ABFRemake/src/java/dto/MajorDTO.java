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
public class MajorDTO {
    private int majorID;
    private String majorName;
    private String status;

    public MajorDTO() {
    }

    public MajorDTO(int majorID, String majorName, String status) {
        this.majorID = majorID;
        this.majorName = majorName;
        this.status = status;
    }

    public int getMajorID() {
        return majorID;
    }

    public void setMajorID(int majorID) {
        this.majorID = majorID;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
