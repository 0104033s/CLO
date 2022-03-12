package noticeR;
import java.util.*;
import java.sql.*;

public class NoticeRDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public NoticeRDAO() {
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
		String SQL="SELECT rnum FROM noticeR ORDER BY rnum DESC";
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
	
	public int write(int nNum,String reply,String userID) {
		String SQL = "INSERT INTO noticeR VALUES(?,?,?,now(),?)";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, nNum);
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
	
	public ArrayList<NoticeR> list(int nNum){
		String SQL = "SELECT nNum,rNum,rReply,DATE_FORMAT(rDAte,'%Y-%m-%d'),userID FROM noticeR WHERE nNum = ? ORDER BY rNum DESC ";
		ArrayList<NoticeR> list = new ArrayList<NoticeR>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nNum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				NoticeR noticeR = new NoticeR();
				noticeR.setnNum(rs.getInt(1));
				noticeR.setrNum(rs.getInt(2));
				noticeR.setrReply(rs.getString(3));
				noticeR.setrDate(rs.getString(4));
				noticeR.setUserID(rs.getString(5));
				list.add(noticeR);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	public int update(String rReply,int rNum) {
		String SQL = "UPDATE noticeR set rReply=? WHERE rNum=?";
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
		String SQL = "DELETE FROM noticeR WHERE rNum=?";
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
