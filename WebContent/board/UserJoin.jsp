<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	String connectionservice = request.getParameter("connectionservice");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String nickname = request.getParameter("nickname");
	int weight = request.getIntHeader("weight");
	int tall = request.getIntHeader("tall");
	String hope = request.getParameter("hope");
	JSONObject rootJson = new JSONObject();

	Connection conn = null;
	PreparedStatement bpstmt = null;
	ResultSet brs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		bpstmt = conn.prepareStatement("insert into user (CONNECTSERVICE, ID, PASSWORD, EMAIL, NICKNAME, WEIGHT, TALL, HOPE) values (?, ?, ?, ?, ?, ?, ?)");
		bpstmt.setString(1, connectionservice);
		bpstmt.setString(2, id);
		bpstmt.setString(3, password);
		bpstmt.setString(4, email);
		bpstmt.setString(5, nickname);
		bpstmt.setInt(6, weight);
		bpstmt.setInt(7, tall);
		bpstmt.setString(8, hope);
		brs = bpstmt.executeQuery(); 
		
		rootJson.put("id", "OK");
	}catch(SQLException e){
		System.out.println(e);
		rootJson.put("result", "ERROR1");
	}catch (ClassNotFoundException cnfe){
		rootJson.put("result", "ERROR2");
		out.print(cnfe.getMessage());
	}finally{
		
		if(bpstmt != null){
			try{ 
				bpstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR3");
			}
		}
		if(conn != null){
			try{ 
				conn.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR4");
			}
		}
	}
	
	out.print(rootJson);
%>