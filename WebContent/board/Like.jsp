<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	String table = request.getParameter("table");
	String userid = request.getParameter("userid");
	int sourcid = request.getIntHeader("sourcid");
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement spstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("insert into poppular ('" + table + "', USERID) values (?, ?)");

		pstmt.setInt(1, sourcid);
		pstmt.setString(2, userid);
		
		pstmt.executeUpdate(); 
		
		spstmt = conn.prepareStatement("update '" + table + "'set POPPULAR = (select count (*) from poppular where poppular.'" + table + "' = '" + sourcid + "')");
		spstmt.executeUpdate();
		
		
		rootJson.put("result", "OK");
	}catch(SQLException e){
		System.out.println(e);
		rootJson.put("result", "ERROR1");
	}catch (ClassNotFoundException cnfe){
		rootJson.put("result", "ERROR2");
		out.print(cnfe.getMessage());
	}finally{
		if(pstmt != null){
			try{ 
				pstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR3");
			}
		}if(spstmt != null){
			try{ 
				spstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR4");
			}
		}
		if(conn != null){
			try{ 
				conn.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR5");
			}
		}
	}
	
	out.print(rootJson);
%>