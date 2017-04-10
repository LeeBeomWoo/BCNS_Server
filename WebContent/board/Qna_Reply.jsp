<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%

	String recieve = request.getParameter("pagenum");
	int page_num = Integer.parseInt(recieve);
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");	    
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/qna_content","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ID, CONTENT FROM reple WHERE CONECTNUM = " + page_num + "");
		
		rs = pstmt.executeQuery(); 
		
		int inum = 0;
		while(rs.next()){
			JSONObject temp = new JSONObject();
			
			temp.put("qrp_Id", rs.getString(1));
			temp.put("qrp_Content", rs.getString(2));
			
			childJson.add(inum, temp);
			
			inum++;
		}		
		rootJson.put("qrpItem", childJson);
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