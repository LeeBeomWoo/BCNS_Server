<%@page import="com.google.gson.annotations.JsonAdapter"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="com.google.gson.*" %>

<%
	String Id = request.getParameter("Id");
	String Name = request.getParameter("Name");
	String Age = request.getParameter("Age");
	String Sex = request.getParameter("Sex");
	String PassWord = request.getParameter("PassWord");
	String HomePage = request.getParameter("HomePage");
	String NickName = request.getParameter("NickName");
	String Email = request.getParameter("Email");
	String Email_open = request.getParameter("Email_open");
	String Call = request.getParameter("Call");
	String Call_open = request.getParameter("Call_open");
	String License = request.getParameter("License");
	String License_1 = request.getParameter("License_1");
	String Address = request.getParameter("Address");
	String FaceImage = request.getParameter("FaceImage");
	String BodyImage = request.getParameter("BodyImage");
	String Award = request.getParameter("Award");
	String Award_1 = request.getParameter("Award_1");
	String Permission = request.getParameter("Permission");
	String Award_AA = request.getParameter("Award_AA");
	String Award_1_AA = request.getParameter("Award_1_AA");
	String License_AA = request.getParameter("License_AA");
	String License_1_AA = request.getParameter("License_1_AA");
	String Award_Image = request.getParameter("Award_Image");
	String Award_1_Image = request.getParameter("Award_1_Image");
	String License_Image = request.getParameter("License_Image");
	String License_1_Image = request.getParameter("License_1_Image");
	String Section = request.getParameter("Section");
	JSONObject rootJson = new JSONObject();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
	    conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("insert into trainer(ID, NAME, NICKNAME, PASSWORD, AGE, ADDRESS, EMAIL, PHONE, SEX, HOMEPAGE, FACEPHOTO, BODYPHOTO, PERMISSION," +
										"CALL_OP, EMAIL_OP, Li_NAME, LI_ASSOCIATION, LI_IMAGE, LI_1_NAME, LI_1_ASSOCIATION, LI_1_IMAGE, AW_NAME, AW_ASSOCIATION, AW_IMAGE, AW_1_NAME, AW_1_ASSOCIATION, AW_1_IMAGE, Section) " +
										"values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

		pstmt.setString(1, Id);
		pstmt.setString(2, Name);
		pstmt.setString(3, NickName);
		pstmt.setString(4, PassWord);
		pstmt.setString(5, Age);
		pstmt.setString(6, Address);
		pstmt.setString(7, Email);
		pstmt.setString(8, Call);
		pstmt.setString(9, Sex);
		pstmt.setString(10, HomePage);
		pstmt.setString(11, FaceImage);
		pstmt.setString(12, BodyImage);
		pstmt.setString(13, Permission);
		pstmt.setString(14, Call_open);
		pstmt.setString(15, Email_open);
		pstmt.setString(16, License);
		pstmt.setString(17, License_AA);
		pstmt.setString(18, License_Image);
		pstmt.setString(19, License_1);
		pstmt.setString(20, License_1_AA);
		pstmt.setString(21, License_1_Image);
		pstmt.setString(22, Award);
		pstmt.setString(23, Award_AA);
		pstmt.setString(24, Award_Image);
		pstmt.setString(25, Award_1);
		pstmt.setString(26, Award_1_AA);
		pstmt.setString(27, Award_1_Image);
		pstmt.setString(28, Section);
		pstmt.executeUpdate();
		
		rootJson.put("result", "OK");
	}catch(SQLException e){
		System.out.println(e);
		rootJson.put("result", "ERROR1");
		rootJson.put("because", e.toString());
	}catch (ClassNotFoundException cnfe){
		rootJson.put("result", "ERROR2");
		rootJson.put("because", cnfe.toString());
		out.print(cnfe.getMessage());
	}finally{
		if(pstmt != null){
			try{ 
				pstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR3");
				rootJson.put("because", e.toString());
			}
		}
		if(conn != null){
			try{ 
				conn.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR4");
				rootJson.put("because", e.toString());
			}
		}
	}
	
	out.print(rootJson);
%>