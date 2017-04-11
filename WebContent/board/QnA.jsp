<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ID, TITLE, CONTENT, IMAGE, Num FROM qnalist");
		
		rs = pstmt.executeQuery(); 
		
		int inum = 0;
		while(rs.next()){
			JSONObject temp = new JSONObject();
			
			temp.put("q_Id", rs.getString(1));
			temp.put("q_Title", rs.getString(2));
			temp.put("q_Content", rs.getString(3));
			temp.put("q_Image", rs.getString(4));
			temp.put("q_ConectCode", rs.getString(5));
			
			childJson.add(inum, temp);
			
			inum++;
		}
		
		rootJson.put("qItem", childJson);
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