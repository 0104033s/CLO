package board;

import java.sql.*;
import java.util.ArrayList;

public class BoardDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			String url="jdbc:mysql://localhost:3307/CLO";
			String ID="root";
			String PW="1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url,ID,PW);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public int nextNum() {
		String SQL="SELECT bNum FROM board ORDER BY bNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1)+1;
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int write(String bTitle,String bText,String brand,String userID,String bImg) {
		String SQL="INSERT INTO board VALUES(?,?,?,?,?,?,0,0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextNum());
			pstmt.setString(2,bTitle);
			pstmt.setString(3,bText);
			pstmt.setString(4,brand);
			pstmt.setString(5,userID);
			pstmt.setString(6,bImg);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	
	
	

}
