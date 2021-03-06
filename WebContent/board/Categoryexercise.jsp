<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
String category = request.getParameter("category");
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ID, TITLE, CONTENT, IMAGE, CNCD, OUTCATEGORY FROM exercise_list WHERE CATEGORY ='" + category +"'");
		
		rs = pstmt.executeQuery(); 
		
		int inum = 0;
		while(rs.next()){
			JSONObject temp = new JSONObject();
			
			temp.put("ec_Id", rs.getString(1));
			temp.put("ec_Title", rs.getString(2));
			temp.put("ec_Content", rs.getString(3));
			temp.put("ec_ImageUrl", rs.getString(4));
			temp.put("ec_ConectCode", rs.getString(5));
			temp.put("ec_Category", rs.getString(6));
			
			childJson.add(inum, temp);
			
			inum++;
		}
		
		rootJson.put("cecItem", childJson);
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