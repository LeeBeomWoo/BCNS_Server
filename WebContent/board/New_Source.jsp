<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
String table = request.getParameter("table");
	JSONObject rootJson = new JSONObject();
	JSONArray childJson = new JSONArray();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta","BCNS","****");
	
		pstmt = conn.prepareStatement("(SELECT ID, TITLE, IMAGE, FACEIMAGE FROM upper_muscle WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM upper_bone WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM lower_muscle WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM lower_bone WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM food_powerup WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM food_muscleup WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM food_fat WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM food_metabolic WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM food_diet WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM follow_stretching WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM follow_muscleup WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM follow_core WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))" +
		"UNION (SELECT ID, TITLE, IMAGE, FACEIMAGE FROM follow_breth WHERE DATE > DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())+6 DAY) AND DATE <= DATE_SUB(DATE(NOW()), INTERVAL DAYOFWEEK(NOW())-1 DAY))"); 

		
		rs = pstmt.executeQuery(); 
		
		int inum = 0;
		while(rs.next()){
			JSONObject temp = new JSONObject();
			
			temp.put("ld_Id", rs.getString(1));
			temp.put("ld_Title", rs.getString(2));
			temp.put("ld_ImageUrl", rs.getString(3));
			temp.put("ld_FaceUrl", rs.getString(4));
			
			childJson.add(inum, temp);
			
			inum++;
		}
		
		rootJson.put("ldItem", childJson);
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