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
public class RegistrationDTO {
    private int registrationID;
    private int userID;
    private int subjectID;
    private String date;
    private String certificate;
    private int status;
    private String email;
    private String subjectName;

    public RegistrationDTO() {
    }

    public RegistrationDTO(int registrationID, int userID, int subjectID, String date, String certificate,int status, String email, String subjectName) {
        this.registrationID = registrationID;
        this.userID = userID;
        this.subjectID = subjectID;
        this.date = date;
        this.certificate = certificate;
        this.status = status;
        this.email = email;
        this.subjectName = subjectName;
    }

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

   
    public static Comparator compareDate = new Comparator(){
        public int compare(Object obj1, Object obj2){
            RegistrationDTO b1 = (RegistrationDTO) obj1;
            RegistrationDTO b2 = (RegistrationDTO) obj2;
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
