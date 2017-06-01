<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	JSONObject rootJson = new JSONObject();
	JSONArray fchildJson = new JSONArray();
	JSONArray bchildJson = new JSONArray();

	Connection conn = null;
	PreparedStatement fpstmt = null;
	PreparedStatement bpstmt = null;
	ResultSet frs, brs;
	
	try{
	    Class.forName("org.mariadb.jdbc.Driver");
	    
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bcns_beta","BCNS","****");
	
		bpstmt = conn.prepareStatement("SELECT NICKNAME, FACEPHOTO, CATEGORY FROM trainer WHERE SECTION ='" + "0" +"'");
		fpstmt = conn.prepareStatement("SELECT NICKNAME, FACEPHOTO, CATEGORY FROM trainer WHERE SECTION ='" + "1" +"'");
		
		brs = bpstmt.executeQuery(); 
		frs = fpstmt.executeQuery(); 
		
		int inum = 0;
		while(brs.next()){
			JSONObject btemp = new JSONObject();
					
			btemp.put("Id", brs.getString(1));
			btemp.put("ImageUrl", brs.getString(2));
			btemp.put("Category", brs.getString(3));
					
			bchildJson.add(inum, btemp);
					
			inum++;
		}
		int finum = 0;
		while(frs.next()){
			JSONObject ftemp = new JSONObject();
					
			ftemp.put("Id", frs.getString(1));
			ftemp.put("ImageUrl", frs.getString(2));
			ftemp.put("Category", frs.getString(3));
					
			fchildJson.add(finum, ftemp);
					
			finum++;
		}
		rootJson.put("cdbItem", bchildJson);
		rootJson.put("cdfItem", fchildJson);
		rootJson.put("result", "OK");
	}catch(SQLException e){
		System.out.println(e);
		rootJson.put("result", "ERROR1");
	}catch (ClassNotFoundException cnfe){
		rootJson.put("result", "ERROR2");
		out.print(cnfe.getMessage());
	}finally{
		if(fpstmt != null){
			try{ 
				fpstmt.close();
			}catch(Exception e){
				rootJson.put("result", "ERROR3");
			}
		}
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