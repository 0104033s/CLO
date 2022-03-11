package user;

import java.sql.*;

public class UserDAO {
	
	private Connection conn;
	private ResultSet rs;
	
		//mysql db 연결
	public UserDAO(){
		try {
			String url = "jdbc:mysql://localhost:3307/CLO?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8";
			String ID = "root";
			String PW = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, ID, PW);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public int login(String userID,String userPW) {
		String SQL ="SELECT userPW FROM user WHERE userID = ?";
		try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,userID);
		rs=pstmt.executeQuery();
		if(rs.next()) {//아이디 있음
			if(rs.getString(1).equals(userPW))
				return 1; //로그인 성공
			else
				return 0; //비밀번호 틀림
		}else 
			return -1; //아이디 없음
		
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -2;	//DB오류
		}
	}
	
	public int nextUserNum() {
		String SQL = "SELECT userNum FROM user ORDER BY userNum desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1)+1; //유저 번호 있음 +1 리턴
			return 1;	//유저 없음 1 리턴
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;	//DB오류
		}
	}
	
	public int join(String userID,String userPW,String userName,String userNickname, String userTel,String userEmail,String userGender) {
		String SQL = "INSERT INTO user VALUES(?,?,?,?,?,?,?,?,0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextUserNum());
			pstmt.setString(2,userID);
			pstmt.setString(3,userPW);
			pstmt.setString(4,userName);
			pstmt.setString(5,userNickname);
			pstmt.setString(6,userTel);
			pstmt.setString(7,userEmail);
			pstmt.setString(8,userGender);
			return pstmt.executeUpdate();	//0이상 리턴
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;	//DB오류 -1리턴 pk userID 아이디중복
		}
		
	}
	//마이페이지
	public User mypage(String userID) {
		String SQL = "SELECT * FROM user WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				User bean = new User();
				bean.setUserNum(rs.getInt(1));
				bean.setUserID(rs.getString(2));
				bean.setUserPW(rs.getString(3));
				bean.setUserName(rs.getString(4));
				bean.setUserNickname(rs.getString(5));
				bean.setUserTel(rs.getString(6));
				bean.setUserEmail(rs.getString(7));
				bean.setUserGender(rs.getString(8));
				return bean;	//bean 채워서 리턴
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;	//db오류
	}
	
	//회원정보 수정
	public int update(String userID,String userNickname,String userEmail) {
		String SQL="UPDATE user SET userNickname = ? , userEmail = ? WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userNickname);
			pstmt.setString(2,userEmail);
			pstmt.setString(3,userID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int delete(String userID) {
		String SQL="DELETE FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int admin(String userID) {
		String SQL = "SELECT admin FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
			return -1;	//아이디 없음
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -2; //DB오류
		}
	}
	


}
