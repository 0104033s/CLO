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
		String SQL="INSERT INTO board VALUES(?,?,?,?,?,?,now(),0,0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextNum());
			pstmt.setString(2,bTitle);
			pstmt.setString(3,bText);
			pstmt.setString(4,brand);
			pstmt.setString(5,userID);
			pstmt.setString(6,bImg);
			pstmt.executeUpdate();
			return nextNum();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	public int pageNum(String brand) {
		String SQL = "SELECT count(bNum) FROM board WHERE bDelete=0 AND brand LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,brand+"%");
			rs=pstmt.executeQuery();
			if(rs.next())
				return (rs.getInt(1)-1)/10+1;
			return 0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public ArrayList<Board> boardList(String brand,int pageNum){
		String SQL = "";
		ArrayList<Board> list = new ArrayList<Board>();
		if(brand=="") {
			SQL = "SELECT * FROM board WHERE bDelete=0 ORDER BY bNum DESC LIMIT ?,10";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,(pageNum-1)*10);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Board board = new Board();
					board.setbNum(rs.getInt(1));
					board.setbTitle(rs.getString(2));
					board.setbText(rs.getString(3));
					board.setBrand(rs.getString(4));
					board.setUserID(rs.getString(5));
					board.setbImg(rs.getString(6));
					board.setbDate(rs.getString(7));
					board.setbDelete(rs.getInt(8));
					board.setbCnt(rs.getInt(9));
					list.add(board);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else {
			SQL = "SELECT * FROM board WHERE bDelete=0 AND brand=? ORDER BY bNum DESC LIMIT ?,10";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,brand);
				pstmt.setInt(2, pageNum(brand));
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Board board = new Board();
					board.setbNum(rs.getInt(1));
					board.setbTitle(rs.getString(2));
					board.setbText(rs.getString(3));
					board.setBrand(rs.getString(4));
					board.setUserID(rs.getString(5));
					board.setbImg(rs.getString(6));
					board.setbDate(rs.getString(7));
					board.setbDelete(rs.getInt(8));
					board.setbCnt(rs.getInt(9));
					list.add(board);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int count(int bNum) {
		String SQL="UPDATE board SET bCnt=bCnt+1 WHERE bNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public Board read(int bNum) {
		String SQL="SELECT bnum,btitle,btext,brand,userID,bimg,DATE_FORMAT(bDate,'%Y-%m-%d') FROM board WHERE bNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			Board board = new Board();
			while(rs.next()) {
			board.setbNum(rs.getInt(1));
			board.setbTitle(rs.getString(2));
			board.setbText(rs.getString(3));
			board.setBrand(rs.getString(4));
			board.setUserID(rs.getString(5));
			board.setbImg(rs.getString(6));
			board.setbDate(rs.getString(7));
			board.setbCnt(count(bNum));
			return board;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	
	
	

}
