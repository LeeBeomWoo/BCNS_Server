<%@page import="com.google.gson.annotations.JsonAdapter"%>
<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="com.google.gson.*" %>

<%
	String Id = request.getParameter("Id");
	String PassWord = request.getParameter("PassWord");
	JSONObject rootJson = new JSONObject();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
	    conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("system ./var/www/BCNS_Server-api/UserCreateNutritionist.sh '" + Id + "' '" + PassWord +"'");

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