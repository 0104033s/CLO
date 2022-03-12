package questionR;
import java.util.*;

import questionR.QuestionR;

import java.sql.*;

public class QuestionRDAO {
	private Connection conn;
	private ResultSet rs;
	
	public QuestionRDAO() {
		try {
		String url="jdbc:mysql://localhost:3307/CLO";
		String ID="root";
		String PW="1234";
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url,ID,PW);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public int nextNum() {
		String SQL="SELECT rnum FROM QuestionR ORDER BY rnum DESC";
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
	
	public int write(int qNum,String reply,String userID) {
		String SQL = "INSERT INTO QuestionR VALUES(?,?,?,now(),?)";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, qNum);
			pstmt.setInt(2, nextNum());
			pstmt.setString(3,reply);
			pstmt.setString(4,userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public ArrayList<QuestionR> list(int qNum){
		String SQL = "SELECT qNum,rNum,rReply,DATE_FORMAT(rDAte,'%Y-%m-%d'),userID FROM QuestionR WHERE qNum = ? ORDER BY rNum DESC ";
		ArrayList<QuestionR> list = new ArrayList<QuestionR>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qNum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QuestionR QuestionR = new QuestionR();
				QuestionR.setqNum(rs.getInt(1));
				QuestionR.setrNum(rs.getInt(2));
				QuestionR.setrReply(rs.getString(3));
				QuestionR.setrDate(rs.getString(4));
				QuestionR.setUserID(rs.getString(5));
				list.add(QuestionR);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	public int update(String rReply,int rNum) {
		String SQL = "UPDATE questionR set rReply=? WHERE rNum=?";
		try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,rReply);
		pstmt.setInt(2, rNum);
		return pstmt.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int delete(int rNum) {
		String SQL = "DELETE FROM questionR WHERE rNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
}
