package brand;

import java.sql.*;
import java.util.ArrayList;

public class BrandDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BrandDAO(){
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
		String SQL="SELECT bNum FROM brand ORDER BY bNum DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
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
	
	public int write(String bName,String bInfo,String bUrl,String origin,String bImg) {
		String SQL ="INSERT INTO brand VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,nextNum());
			pstmt.setString(2,bName);
			pstmt.setString(3,bInfo);
			pstmt.setString(4,bUrl);
			pstmt.setString(5,origin);
			pstmt.setString(6,bImg);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
	public ArrayList<Brand> brandList(String bWord){
		String SQL = "SELECT bName,bImg FROM brand WHERE bName LIKE ? ORDER BY bName ";
		
		ArrayList<Brand> list = new ArrayList<Brand>();
		try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,bWord+"%");
		rs=pstmt.executeQuery();
		while(rs.next()) {
			Brand brand = new Brand();
			brand.setbName(rs.getString(1));
			brand.setbImg(rs.getString(2));
			list.add(brand);
		}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
		
	}
}
