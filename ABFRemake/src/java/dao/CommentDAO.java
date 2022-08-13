/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.CommentDTO;
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
public class CommentDAO {
   private static final String INSERT = "Insert into Comment(blogID,userID,content,date,status) values(?,?,?,?,1)";
   private static final String GET_ALL_COMMENT = "SELECT commentID, userID, content, date, status FROM Comment WHERE blogID = ? AND status = 1";
  
    public static List<CommentDTO> getCommentbyBlogID(int blogID) throws ClassNotFoundException, SQLException{
        List<CommentDTO> list = new ArrayList<>();
        Connection cn= DBUtils.getConnection();
        if(cn != null){
            PreparedStatement pn = cn.prepareStatement(GET_ALL_COMMENT);
            pn.setInt(1, blogID);
            ResultSet rs = pn.executeQuery();
            while (rs != null && rs.next()) {
                int commentID = rs.getInt("commentID");
                int userID = rs.getInt("userID");
                String content = rs.getString("content");
                String date = rs.getString("date");
                String status = rs.getString("status");
                list.add(new CommentDTO(commentID, blogID, userID, content, date, status));
            }
            cn.close();
        }
        return list;
    }
    
    public static int insertComment(int blogID, int userID, String content,String date) throws ClassNotFoundException, SQLException {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                PreparedStatement pst = cn.prepareStatement(INSERT);
                pst.setInt(1, blogID);
                pst.setInt(2, userID);
                pst.setString(3, content);
                pst.setString(4, date);
                result = pst.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            if (cn != null) {
                cn.close();
            }
        }
        return result;
    } 
}
