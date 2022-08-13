/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.MajorDTO;
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
public class MajorDAO {

    private static final String GET_ALL_MAJORS = "SELECT majorID, majorName, status FROM Major WHERE status = 1";
    private static final String DELETE_MAJOR = "UPDATE Major SET status = 0 WHERE majorID = ?";
    private static final String SEARCH_MAJORS_BY_NAME = "SELECT majorID, majorName, status FROM Major WHERE majorName LIKE ? AND status = 1";
    private static final String CREATE_MAJOR = "INSERT INTO Major (majorName, status)" + "VALUES(?,1)";
    private static final String SEARCH_MAJOR_BY_ID = "SELECT majorName, status\n"
            + " FROM Major\n"
            + " WHERE majorID = ?";
    private static final String EDIT_MAJOR = "UPDATE Major SET majorName = ? WHERE majorID = ?";

    public List<MajorDTO> getAllMajors() throws SQLException {
        List<MajorDTO> listAllMajors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(GET_ALL_MAJORS);
                rs = psm.executeQuery();
                while (rs.next()) {
                    int majorID = rs.getInt("majorID");
                    String majorName = rs.getString("majorName");
                    String status = rs.getString("status");
                    listAllMajors.add(new MajorDTO(majorID, majorName, status));
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
        return listAllMajors;
    }

    public boolean deleteMajor(int majorID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(DELETE_MAJOR);
                psm.setInt(1, majorID);
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

    public List<MajorDTO> searchMajorByName(String searchName) throws SQLException {
        List<MajorDTO> listAllMajors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(SEARCH_MAJORS_BY_NAME);
                psm.setString(1, "%" + searchName + "%");
                rs = psm.executeQuery();
                while (rs.next()) {
                    int majorID = rs.getInt("majorID");
                    String majorName = rs.getString("majorName");
                    String status = rs.getString("status");
                    listAllMajors.add(new MajorDTO(majorID, majorName, status));
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
        return listAllMajors;
    }

    public boolean createMajor(String majorName) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(CREATE_MAJOR);
                psm.setString(1, majorName);
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
    
    public MajorDTO getMajorByID(int majorID) throws ClassNotFoundException, SQLException {
        MajorDTO major = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            PreparedStatement pn = cn.prepareStatement(SEARCH_MAJOR_BY_ID);
            pn.setInt(1, majorID);
            ResultSet rs = pn.executeQuery();
            while (rs != null && rs.next()) {
                String majorName = rs.getString("majorName");
                String status = rs.getString("status");
                major = new MajorDTO(majorID, majorName, status);
            }
            cn.close();
        }
        return major;
    }
    
    public int editMajor(int majorID, String majorName) throws SQLException, ClassNotFoundException {
        int check = 0;
        Connection conn = null;
        PreparedStatement psm = null;
        conn = DBUtils.getConnection();
        if (conn != null) {
            psm = conn.prepareStatement(EDIT_MAJOR);
            psm.setString(1, majorName);
            psm.setInt(2, majorID);
            check = psm.executeUpdate();
        }
        conn.close();
        return check;
    }
}
