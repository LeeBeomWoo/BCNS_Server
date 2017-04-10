<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	
	String item = request.getParameter("pagenum");
	int page_num = Integer.parseInt(item);
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	PreparedStatement retmt = null;
	ResultSet rers;
	try{
		
		Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/qna_content?allowMultiQueries=true","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ID, TITLE, CONTENT FROM main WHERE Num =" + page_num +"");
		
		rs = pstmt.executeQuery(); 
		
		retmt = conn.prepareStatement("SELECT ID, CONTENT FROM reple WHERE CONECTNUM = " + page_num + "");
		
		rers = retmt.executeQuery(); 
		
		int inum = 0;
		if(rs.next()){
		rootJson.put("q_Id", rs.getString(1));
		rootJson.put("q_Title", rs.getString(2));
		rootJson.put("q_Content", rs.getString(3));
		}
		while(rers.next()){			
			JSONObject temp = new JSONObject();

			temp.put("qrp_Id", rers.getString(1));
			temp.put("qrp_Content", rers.getString(2));
					
			childJson.add(inum, temp);
						
			inum ++;				
		}
		
		rootJson.put("qrp_Item", childJson);				
		rootJson.put("result", "OK");
	}catch(SQLException e){
		System.out.println(e);
		rootJson.put("result", e.toString());
	}catch (ClassNotFoundException cnfe){
		rootJson.put("result", cnfe.toString());
		out.print(cnfe.getMessage());
	}finally{
		if(pstmt != null){
			try{ 
				pstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR3");
			}
			
		}
		if(retmt != null){
			try{ 
				retmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR5");
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