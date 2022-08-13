/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.RegistrationDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author To Quyen Phan
 */
public class RegistrationDAO {

    private static final String GET_ALL_REGISTRATION_WAIT = "SELECT registrationID ,Registration.userID, Registration.subjectID,certificate,date, Registration.status, [User].email, Subject.subjectName\n"
            + "FROM ((Registration\n"
            + "INNER JOIN [User] ON Registration.userID = [User].userID)\n"
            + "INNER JOIN Subject ON Registration.subjectID = Subject.subjectID)\n"
            + "WHERE Registration.status = 3";
    private static final String CREATE_REGISTRATION = "INSERT Registration(userID,subjectID,certificate,date,status) VALUES(?,?,?,?,3)";
    private static final String GET_REGITRATION_BY_USERID = "SELECT registrationID ,Registration.userID, Registration.subjectID,certificate,date, Registration.status, [User].email, Subject.subjectName\n"
            + "FROM ((Registration\n"
            + "INNER JOIN [User] ON Registration.userID = [User].userID)\n"
            + "INNER JOIN Subject ON Registration.subjectID = Subject.subjectID)\n"
            + "WHERE Registration.userID =? And Registration.status = 1";
    private static final String GET_REGITRATION_BY_REGISTRATIONID = "SELECT registrationID ,Registration.userID, Registration.subjectID,certificate,date, Registration.status, [User].email, Subject.subjectName\n"
            + "FROM ((Registration\n"
            + "INNER JOIN [User] ON Registration.userID = [User].userID)\n"
            + "INNER JOIN Subject ON Registration.subjectID = Subject.subjectID)\n"
            + "WHERE Registration.registrationID = ?";
    private static final String APPROVE_REGISTRATION = " UPDATE [Registration]\n"
            + "  SET status = 1\n"
            + " WHERE registrationID =?\n"
            + "  UPDATE [User]\n"
            + "  SET roleID = 3\n"
            + " WHERE userID =?";
    private static final String REJECT_REGISTRATION = "UPDATE Registration\n"
            + "  SET status = 2\n"
            + "  WHERE registrationID =?";

    public static List<RegistrationDTO> GetAllRegistrationWait() throws SQLException {
        List<RegistrationDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(GET_ALL_REGISTRATION_WAIT);
                rs = psm.executeQuery();
                while (rs.next()) {
                    int registrationID = rs.getInt("registrationID");
                    int userID = rs.getInt("userID");
                    int subjectID = rs.getInt("subjectID");
                    String date = rs.getString("date");
                    String ceritficate = rs.getString("certificate");
                    int status = rs.getInt("status");
                    String email = rs.getString("email");
                    String subjectName = rs.getString("subjectName");
                    list.add(new RegistrationDTO(registrationID, userID, subjectID, date, ceritficate, status, email, subjectName));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static boolean createRegistration(int userID, int subjectID, String certificate, String date) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(CREATE_REGISTRATION);
                psm.setInt(1, userID);
                psm.setInt(2, subjectID);
                psm.setString(3, certificate);
                psm.setString(4, date);
                check = psm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static List<RegistrationDTO> getRegistrationByUserid(int userId) throws SQLException {
        List<RegistrationDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(GET_REGITRATION_BY_USERID);
                psm.setInt(1, userId);
                rs = psm.executeQuery();
                while (rs.next()) {
                    int registrationID = rs.getInt("registrationID");
                    int subjectID = rs.getInt("subjectID");
                    String certificate = rs.getString("certificate");
                    String date = rs.getString("date");
                    int status = rs.getInt("status");
                    String email = rs.getString("email");
                    String subjectName = rs.getString("subjectName");
                    list.add(new RegistrationDTO(registrationID, userId, subjectID, date, certificate, status, email, subjectName));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static RegistrationDTO getRegistrationByRegistrationid(int registrationid) throws SQLException {
        RegistrationDTO regis = null;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(GET_REGITRATION_BY_REGISTRATIONID);
                psm.setInt(1, registrationid);
                rs = psm.executeQuery();
                if (rs.next()) {
                    int userID = rs.getInt("userID");
                    int subjectID = rs.getInt("subjectID");
                    String certificate = rs.getString("certificate");
                    String date = rs.getString("date");
                    int status = rs.getInt("status");
                    String email = rs.getString("email");
                    String subjectName = rs.getString("subjectName");
                    regis = new RegistrationDTO(registrationid, userID, subjectID, date, certificate, status, email, subjectName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return regis;
    }

    public static boolean approveRegistration(int registrationID, int userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(APPROVE_REGISTRATION);
                psm.setInt(1, registrationID);
                psm.setInt(2, userID);
                check = psm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static boolean rejectRegistration(int registrationID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(REJECT_REGISTRATION);
                psm.setInt(1, registrationID);
                check = psm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psm != null) {
                psm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
