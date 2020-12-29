package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//DB����
	public BbsDAO() {
		try {
			String dbURL= "jdbc:mysql://localhost:3306/bbs";
			String dbID="root";
			String dbPassword="1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//����ð����
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	//�������� �ۼ��� ���� ��ȣ
	public int getNext() {
		String SQL = "select bbsID from BBS order by bbsID desc"; //���� �������� ���� ��ȣ�� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //�������� ������ȣ ����
			}
			return 1; //ù��° �Խù��� ���
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	//�� ���
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into BBS values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //�������� �������� �Խñ� ��ȣ
			pstmt.setString(2, bbsTitle); 
			pstmt.setString(3, userID); 
			pstmt.setString(4, getDate()); 
			pstmt.setString(5, bbsContent); 
			pstmt.setInt(6, 1);  
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	//Ư�� ���������� 10���� ����Ͽ� list�� ��� ��ȯ
	public ArrayList<Bbs> getList(int pageNum){
		String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10"; //���� �������� ���� ��ȣ�� ������
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
			
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	
	
	//����¡ó��. Ư���� �������� �����ϴ���
	public boolean nextPage(int pageNum) {
		String SQL = "select * from BBS where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10"; //���� �������� ���� ��ȣ�� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) { //����� �Ѱ��� �����ϸ� ������������ �Ѿ���� true����
				return true;		
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; //�����ͺ��̽� ����
	}
	
	//�� ��ȸ
	public Bbs getBbs(int bbsID) {
		String SQL = "select * from BBS where bbsID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				Bbs bbs = new Bbs();
				
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//�ۼ���
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "update BBS set bbsTitle=?, bbsContent=? where bbsID=?";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);

			return pstmt.executeUpdate();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1; //0�̻��� ���� ��ȯ�ϱ� ������ -1�� ����
		
	}
	
	//�ۻ���
	public int delete(int bbsID) {
		String SQL = "update BBS set bbsAvailable= 0 where bbsID= ?";
		//�����ƿ������ϴ� ���� �ƴ� Available�� 0���� ����� �Խ��ǿ��� �Ⱥ��̰� ��
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1; //0�̻��� ���� ��ȯ�ϱ� ������ -1�� ����
		
	}
}
