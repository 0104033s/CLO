package reply;

import java.sql.*;
import java.util.ArrayList;

public class ReplyDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public ReplyDAO() {
		try {
		String url="jdbc:mysql://localhost:3307/CLO";
		String ID = "root";
		String PW = "1234";
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(url,ID,PW);
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		}
	}
	
	public int nextNum() {
		String SQL="SELECT rNum FROM reply ORDER BY rNum DESC";
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
	public int rcount(int bNum) {
		String SQL ="UPDATE board SET rCnt=rCnt+1 WHERE bNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
			return -1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int write(int bNum,String reply,String userID) {
		String SQL ="INSERT INTO reply VALUES(?,?,?,now(),?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1,nextNum());
					pstmt.setInt(2,bNum);
					pstmt.setString(3,reply);
					pstmt.setString(4,userID);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					return -1;
				}
		
		}
	public ArrayList<Reply> reply(int bNum){
		String SQL = "SELECT * FROM reply WHERE bNum=? ORDER BY rNum DESC";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setbNum(rs.getInt(1));
				reply.setrNum(rs.getInt(2));
				reply.setReply(rs.getString(3));
				reply.setrDate(rs.getString(4));
				reply.setUserID(rs.getString(5));
				list.add(reply);
			}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return list;
	}
	
	public int delete(int rNum) {
		String SQL="DELETE FROM reply WHERE rNum = ?";
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
	
	public int update(int rNum,String reply) {
		String SQL = "UPDATE reply SET reply=? WHERE rNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,reply);
			pstmt.setInt(2, rNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public int count(int bNum) {
		String SQL="SELECT COUNT(reply) FROM reply WHERE bNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
			return 0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
}
