package question;

import java.sql.*;
import java.util.ArrayList;

public class QuestionDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public QuestionDAO() {
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
		String SQL = "SELECT qNum FROM question ORDER BY qNum DESC";
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
	
	public int write(String qTitle,String qText, String userID ) {
		String SQL = "INSERT INTO question VALUES(?,?,?,now(),0,0,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextNum());
			pstmt.setString(2, qTitle);
			pstmt.setString(3, qText);
			pstmt.setString(4, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	//페이지 수
	public int page(String userID) {
		String SQL = "SELECT COUNT(qNum) FROM question WHERE qDELETE = 0 AND userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if(rs.next())
				return (rs.getInt(1)-1)/10+1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	//문의 리스트
	public ArrayList<Question> questionList(String userID,int pagenum){
		String SQL = "SELECT qNum,qTitle,DATE_FORMAT(qDate,'%Y-%m-%d'),qCount,userID FROM question WHERE qDelete=0 AND userID=? ORDER BY qNum DESC LIMIT ?,10";
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setInt(2,(pagenum-1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Question question = new Question();
				question.setqNum(rs.getInt(1));
				question.setqTitle(rs.getString(2));
				question.setqDate(rs.getString(3));
				question.setqCount(rs.getInt(4));
				question.setUserID(rs.getString(5));
				list.add(question);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	//관리자 페이지 수
	public int adminPage() {
		String SQL = "SELECT COUNT(qNum) FROM question WHERE qDELETE = 0";
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
	//관리자 문의 리스트
	public ArrayList<Question> adminList(int pagenum){
		String SQL = "SELECT qNum,qTitle,DATE_FORMAT(qDate,'%Y-%m-%d'),qCount,userID FROM question WHERE qDelete=0 ORDER BY qNum DESC LIMIT ?,10";
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,(pagenum-1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Question question = new Question();
				question.setqNum(rs.getInt(1));
				question.setqTitle(rs.getString(2));
				question.setqDate(rs.getString(3));
				question.setqCount(rs.getInt(4));
				question.setUserID(rs.getString(5));
				list.add(question);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	//조회 카운트
	public int count(int qNum) {
		String SQL = "UPDATE question SET qCount=qCount+1 WHERE qNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return-1;
		}
	}
	//문의 게시글
	public Question question(int qNum) {
		String SQL = "SELECT qNum,qTitle,DATE_FORMAT(qDate,'%Y-%m-%d'),qCount,qText,userID FROM question WHERE qNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qNum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Question question = new Question();
				question.setqNum(rs.getInt(1));
				question.setqTitle(rs.getString(2));
				question.setqDate(rs.getString(3));
				question.setqCount(count(qNum));
				question.setqText(rs.getString(5));
				question.setUserID(rs.getString(6));
				return question;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	//문의글 삭제
	public int delete(int qNum) {
		String SQL="UPDATE question SET qDelete=1 WHERE qNum = ?";
		try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, qNum);
		return pstmt.executeUpdate();
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		return -1;
		}
	}
	//문의글 수정
	public int update(String qTitle,String qText,int qNum) {
		String SQL="UPDATE question SET qTitle=? , qText=? WHERE qNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,qTitle);
			pstmt.setString(2,qText);
			pstmt.setInt(3, qNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	public ArrayList<Question> userList(String userID){
		String SQL = "SELECT qNum,DATE_FORMAT(qDate,'%Y-%m-%d'),qTitle FROM question WHERE userID=? AND qDelete=0 ORDER BY qNum DESC";
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
			Question question = new Question();
			question.setqNum(rs.getInt(1));
			question.setqDate(rs.getString(2));
			question.setqTitle(rs.getString(3));
			list.add(question);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}

}
