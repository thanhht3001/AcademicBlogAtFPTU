/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dto.UserDTO;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author To Quyen Phan
 */
public class UserDAO {
    private static final String FIND_USER = "SELECT userID, password, fullName, roleID, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status"
            + " FROM [User] WHERE email like ?";
    private static final String LOGIN = "SELECT userID, fullName, roleID, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status"
            + " FROM [User] WHERE email like ? AND password like ?";
    private static final String CREATE_USER = "INSERT INTO [User](password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status)"
            + " VALUES(?,?,2,?,?,0,null,null,null,null,null,1)";
    private static final String CHECK_ROLE = "SELECT roleName FROM Role WHERE roleID = ?";
    private static final String CHECK_TO_UPDATE = "SELECT numberOfBlogs FROM [User] WHERE userID = ?";
    private static final String UPDATE = "UPDATE [User] SET numberOfBlogs = ? WHERE userID = ?";
    private static final String GET_ALL_USER = "SELECT userID, password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status"
            + " FROM [User] ";
    private static final String FIND_USER_BY_ID = "SELECT  password, fullName, roleID,email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status\n"
            + "         FROM [User] WHERE UserID = ?";
    private static final String UPDATE_STATUS = "UPDATE [User]\n"
            + "  SET status = ? \n"
            + "  Where userID = ?";
    
    public UserDTO checkLogin(String email, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(LOGIN);
                psm.setString(1, email);
                psm.setString(2, password);
                rs = psm.executeQuery();
                if (rs.next()) {
                    int userID = rs.getInt("userID");
                    String fullName = rs.getString("fullName");
                    int roleID = rs.getInt("roleID");
                    String image = rs.getString("image");
                    int numberOfBlogs = rs.getInt("numberOfBlogs");
                    String gender = rs.getString("gender");
                    String dateOfBirth = rs.getString("dateOfBirth");
                    String address = rs.getString("address");
                    String contact = rs.getString("contact");
                    String aboutme = rs.getString("aboutme");                   
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status);
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
        return user;
    }
    
    public UserDTO checkLoginByEmail(String email) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(FIND_USER);
                psm.setString(1, email);
                rs = psm.executeQuery();
                if (rs.next()) {
                    int userID = rs.getInt("userID");
                    String password = rs.getString("password");
                    String fullName = rs.getString("fullName");
                    int roleID = rs.getInt("roleID");
                    String image = rs.getString("image");
                    int numberOfBlogs = rs.getInt("numberOfBlogs");
                    String gender = rs.getString("gender");
                    String dateOfBirth = rs.getString("dateOfBirth");
                    String address = rs.getString("address");
                    String contact = rs.getString("contact");
                    String aboutme = rs.getString("aboutme");      
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status);
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
        return user;
    }
    
    public String checkRole(int roleID) throws SQLException {
        String roleName = null;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(CHECK_ROLE);
                psm.setInt(1, roleID);
                rs = psm.executeQuery();
                if (rs.next()) {
                    roleName = rs.getString("roleName");
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
        return roleName;
    }
    
    public boolean createUser(String fullName, String email, String image) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement psm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                psm = conn.prepareStatement(CREATE_USER);
                psm.setString(1, "");
                psm.setString(2, fullName);
                psm.setString(3, email);
                psm.setString(4, image);
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
    
    public List<UserDTO> getAllUser() {
        List<UserDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(GET_ALL_USER);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    int userID = rs.getInt("userID");
                    String password = rs.getString("password");
                    String fullName = rs.getString("fullName");
                    int roleID = rs.getInt("roleID");
                    String email = rs.getString("email");
                    String image = rs.getString("image");
                    int numberOfBlogs = rs.getInt("numberOfBlogs");
                    String gender = rs.getString("gender");
                    String dateOfBirth = rs.getString("dateOfBirth");
                    String address = rs.getString("address");
                    String contact = rs.getString("contact");
                    String aboutme = rs.getString("aboutme");
                    boolean status = rs.getBoolean("status");
                    UserDTO c = new UserDTO(userID, password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status);
                    list.add(c);
                }
            }
            cn.close();
        } catch (Exception e) {
        }
        return list;
    }
    
    public UserDTO GetUserByID(int id) throws ClassNotFoundException, SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement psm = null;
        ResultSet rs = null;
        conn = DBUtils.getConnection();
        if (conn != null) {
            psm = conn.prepareStatement(FIND_USER_BY_ID);
            psm.setInt(1, id);
            rs = psm.executeQuery();
            if (rs.next()) {
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                int roleID = rs.getInt("roleID");
                String email = rs.getString("email");
                String image = rs.getString("image");
                int numberOfBlogs = rs.getInt("numberOfBlogs");
                String gender = rs.getString("gender");
                String dateOfBirth = rs.getString("dateOfBirth");
                String address = rs.getString("address");
                String contact = rs.getString("contact");
                String aboutme = rs.getString("aboutme");
                boolean status = rs.getBoolean("status");
                user = new UserDTO(id, password, fullName, roleID, email, image, numberOfBlogs, gender, dateOfBirth, address, contact, aboutme, status);
            }
            conn.close();

        }
        return user;
    }

    public static int updateStatusUser(int userID, String oldStatus) throws ClassNotFoundException, SQLException {
        int result = 0;
        Connection cn = null;
        cn = DBUtils.getConnection();
        if (cn != null) {
            PreparedStatement pst = cn.prepareStatement(UPDATE_STATUS);
            if (oldStatus.equalsIgnoreCase("true")) {
                pst.setString(1, "0");
            } else {
                pst.setString(1, "1");
            }
            pst.setInt(2, userID);
            result = pst.executeUpdate();
        }
        cn.close();
        return result;
    }
}
