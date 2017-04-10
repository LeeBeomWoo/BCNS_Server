<%@page import="com.google.gson.annotations.JsonAdapter"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="com.google.gson.*" %>

<%
	String Id = request.getParameter("Id");
	String Category = request.getParameter("Category");
	String OutCategory = request.getParameter("OutCategory");
	String ImageUrl = request.getParameter("ImageUrl");
	String Table = request.getParameter("Table");
	String Title = request.getParameter("Title");
	String Content = request.getParameter("Content");
	String ListImage = request.getParameter("ListImage");
	JSONObject rootJson = new JSONObject();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
	    conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("insert into '" + Table + "'(ID, CATEGORY, CNCD, IMAGE, TITLE, CONTENT, OUTCATEGORY" +
		"values (?, ?, ?, ?, ?, ?, ?)");

		pstmt.setString(1, Id);
		pstmt.setString(2, Category);
		pstmt.setString(3, ImageUrl);
		pstmt.setString(4, ListImage);
		pstmt.setString(5, Title);
		pstmt.setString(6, Content);
		pstmt.setString(7, OutCategory);
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