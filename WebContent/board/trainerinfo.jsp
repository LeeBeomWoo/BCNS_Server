<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	String id = request.getParameter("tr_id");
	JSONObject rootJson = new JSONObject();
	JSONArray childJsonli = new JSONArray();
	JSONArray childJsonaw = new JSONArray();

	Connection conn = null;
	Connection connli = null;
	Connection connaw = null;
	
	PreparedStatement pstmt = null;
	PreparedStatement pstmtli = null;
	PreparedStatement pstmtaw = null;
	ResultSet rs;
	ResultSet rsli;
	ResultSet rsaw;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
		connli = DriverManager.getConnection("jdbc:mariadb://localhost:3308/License","BCNS","****");
		connaw = DriverManager.getConnection("jdbc:mariadb://localhost:3308/Award","BCNS","****");
	
		pstmt = conn.prepareStatement("SELECT ASSOCIATION, EMAIL, INTRODUCE, PHONE, PHOTOURL, NICKNAME FROM trainer WHERE ID ='" + id +"'");
		pstmtli = connli.prepareStatement("SELECT CHECK, ASSOCIATION, NAME FROM '" + id +"'_license ");
		pstmtli = connaw.prepareStatement("SELECT CHECK, ASSOCIATION, NAME FROM '" + id +"'_award ");
		rs = pstmt.executeQuery(); 
		rsli = pstmtli.executeQuery();
		rsaw = pstmtaw.executeQuery();

		rootJson.put("association", rs.getString(1));
		rootJson.put("email", rs.getString(2));
		rootJson.put("Introduce", rs.getString(3));
		rootJson.put("call", rs.getString(4));
		rootJson.put("ImageUrl", rs.getString(5));
		rootJson.put("nickname", rs.getString(6));
		
		int li = 0;
		while(rsli.next()){
			JSONObject license = new JSONObject();

			license.put("check", rsli.getString(1));
			license.put("association", rsli.getString(2));
			license.put("name", rsli.getString(3));
			childJsonli.add(li, license);
			
			li++;
		}
		

		int aw = 0;
		while(rsaw.next()){
			JSONObject award = new JSONObject();

			award.put("check", rsaw.getString(1));
			award.put("association", rsaw.getString(2));
			award.put("name", rsaw.getString(3));
			childJsonaw.add(aw, award);
			
			aw++;
		}
				
		rootJson.put("awList", childJsonaw);
		rootJson.put("liList", childJsonli);
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