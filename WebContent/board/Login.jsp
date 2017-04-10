<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	String Id = request.getParameter("Id");
	String Pw = request.getParameter("PassWord");
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
	    conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ID, PASSWORD, PERMISSION FROM trainer WHERE ID ='" + Id +"' and  PASSWORD = '" + Pw + "'");
		
		rs = pstmt.executeQuery(); 
		int inum = 0;
		while(rs.next()){
				rootJson.put("Id", rs.getString(1));
				rootJson.put("PassWord", rs.getString(2));
				rootJson.put("Permission", rs.getInt(3));				
		}
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