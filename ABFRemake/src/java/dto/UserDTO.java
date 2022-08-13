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
public class UserDTO {
    private int userID;
    private String password;
    private String fullName;
    private int roleID;
    private String email;
    private String image;
    private int numberOfBlogs;
    private String gender;
    private String dateOfBirth;
    private String address;
    private String contact;
    private String aboutme;
    private boolean status;

    public UserDTO() {
        this.userID = 0;
        this.password = "";
        this.fullName = "";
        this.roleID = 0;
        this.email = "";
        this.image = "";
        this.numberOfBlogs = 0;
        this.gender = "";
        this.dateOfBirth = "";
        this.address = "";
        this.contact = "";
        this.aboutme = "";
        this.status = false;
    }

    public UserDTO(int userID, String password, String fullName, int roleID, String email, String image, int numberOfBlogs, String gender, String dateOfBirth, String address, String contact, String aboutme, boolean status) {
        this.userID = userID;
        this.password = password;
        this.fullName = fullName;
        this.roleID = roleID;
        this.email = email;
        this.image = image;
        this.numberOfBlogs = numberOfBlogs;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.contact = contact;
        this.aboutme = aboutme;
        this.status = status;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getNumberOfBlogs() {
        return numberOfBlogs;
    }

    public void setNumberOfBlogs(int numberOfBlogs) {
        this.numberOfBlogs = numberOfBlogs;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAboutme() {
        return aboutme;
    }

    public void setAboutme(String aboutme) {
        this.aboutme = aboutme;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
