/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ActivityDTO;
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
public class ActivityDAO {
    private static final String GET_ACTIVITY = "SELECT historyActivityID, date, activity FROM HistoryActivity JOIN ActivityType ON"
            + " HistoryActivity.activityTypeID = ActivityType.activityTypeID WHERE userID = ? AND status = 1";
    private static final String DELETE_ACTIVITY = "UPDATE HistoryActivity SET status = 0 WHERE historyActivityID = ?";
    private static final String FIND_VOTE_ACTIVITY = "SELECT historyActivityID FROM HistoryActivity WHERE blogID = ? AND userID = ? "
            + "AND activityTypeID = 1";
    private static final String UPDATE_ACTIVITY = "INSERT INTO HistoryActivity(userID, date, activityTypeID, blogID, status) "
            + "VALUES(?,?,1,?,1)";
    private static final String DELETE_VOTE = "DELETE HistoryActivity WHERE userID = ? AND blogID = ? AND activityTypeID = 1";
    private static final String SEARCH_ACTIVITY = "SELECT historyActivityID,userID, date, activity FROM HistoryActivity h" +
"            JOIN ActivityType a ON h.activityTypeID = a.activityTypeID " +
"           WHERE a.activity like ? AND h.userID = ? AND h.status = 1";
    
    public List<ActivityDTO> getAllActivities(int userID) throws SQLException {
        List<ActivityDTO> listAllActivities = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(GET_ACTIVITY);
                psm.setInt(1, userID);
                rs = psm.executeQuery();
                while (rs.next()) {
                    int historyActivityID = rs.getInt("historyActivityID");
                    String date = rs.getString("date");
                    String activity = rs.getString("activity");
                    listAllActivities.add(new ActivityDTO(historyActivityID, userID, date, activity));
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
        return listAllActivities;
    }
    
    public boolean deleteActivity(int historyActivityID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(DELETE_ACTIVITY);
                psm.setInt(1, historyActivityID);
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
    
    public boolean findVoteActivity(int blogID, int userID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(FIND_VOTE_ACTIVITY);
                psm.setInt(1, blogID);
                psm.setInt(2, userID);
                rs = psm.executeQuery();
                if(rs.next()){
                    check = true;
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
        return check;
    }
    
    public boolean updateActivity(int blogID, int userID, String date) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(UPDATE_ACTIVITY);
                psm.setInt(1, userID);
                psm.setString(2, date);
                psm.setInt(3, blogID);
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
    
    public boolean deleteUpdate(int blogID, int userID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(DELETE_VOTE);
                psm.setInt(1, userID);
                psm.setInt(2, blogID);
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
    
    public List<ActivityDTO> SearchActivitiesByName(String searchName, int userID) throws SQLException {
        List<ActivityDTO> listAllActivities = new ArrayList<>();
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(SEARCH_ACTIVITY);
                psm.setString(1, "%" + searchName + "%" );
                psm.setInt(2,userID);
                rs = psm.executeQuery();
                while (rs.next()) {
                    int historyActivityID = rs.getInt("historyActivityID");
                    String date = rs.getString("date");
                    String activity = rs.getString("activity");
                    listAllActivities.add(new ActivityDTO(historyActivityID, userID, date, activity));
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
        return listAllActivities;
    }
}
