package notice;

import java.sql.*;
import java.util.ArrayList;

public class NoticeDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public NoticeDAO() {
		try {
			String url="jdbc:mysql://localhost:3307/CLO";
			String ID="root";
			String PW="1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, ID, PW);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public int nextNum() {
		String SQL = "SELECT nNum FROM notice ORDER BY nNum desc";
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
	//notice 작성
	public int write(String nTitle,String userID,String nText) {
		String SQL = "INSERT INTO notice VALUES(?,?,?,?,now(),0,0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextNum());
			pstmt.setString(2,nTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,nText);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	//notice 리스트 페이지
	public int page() {
		String SQL = "SELECT COUNT(nNum) FROM notice WHERE nDELETE = 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next())
				return (rs.getInt(1)-1)/10+1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//notice 리스트
	public ArrayList<Notice> noticeList(int pageNum){
		String SQL= "SELECT nNum,nTitle,userID,nText,DATE_FORMAT(nDate,'%Y-%m-%d'),nCount,nDelete FROM notice WHERE nDelete = 0 ORDER BY nNum DESC LIMIT ?,10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,(pageNum-1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setnNum(rs.getInt(1));
				notice.setnTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setnText(rs.getString(4));
				notice.setnDate(rs.getString(5));
				notice.setnCount(rs.getInt(6));
				notice.setnDelete(rs.getInt(7));
				list.add(notice);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

}
