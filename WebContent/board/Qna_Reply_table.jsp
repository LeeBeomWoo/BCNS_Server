
<%@ page pageEncoding="UTF-8"%>

<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="java.sql.*"%>
<%
String qnaitem = request.getParameter("content");
String writer = request.getParameter("writer");
String pagenum = request.getParameter("pagenum");
int page_num = Integer.parseInt(pagenum);
JSONObject rootJson = new JSONObject();
JSONArray childJson = new JSONArray();

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
PreparedStatement stmt = null;

PreparedStatement retmt = null;
ResultSet rers = null;

StringBuffer sql = new StringBuffer();
	
	try{
	    conn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/qna_content", "BCNS","****");
	    if (conn == null)
	        throw new Exception("데이터베이스에 연결할 수 없습니다.");
	    stmt = conn.prepareStatement("insert into reple (CONTENT, ID, CONECTNUM) values (?, ?, ?)");
	    	stmt.setString(1, qnaitem);
	    	stmt.setString(2, writer);
	    	stmt.setInt(3, page_num);
	   
			stmt.executeUpdate();
			
			retmt = conn.prepareStatement("SELECT ID, CONTENT FROM reple WHERE CONECTNUM = " + page_num + "");
			
			rers = retmt.executeQuery(); 
			
			int inum = 0;
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
	}
	finally{
		   if(stmt !=null){
			   try{
				   stmt.close();
			   }catch(Exception e){

					rootJson.put("result2", e.toString());
			   }
			   if(retmt !=null){
				   try{
				   retmt.close();
				   } catch(Exception e){

						rootJson.put("result5", e.toString());
				   }
			   }
			   if(conn !=null){
				   try {
					   conn.close();
				   }catch (Exception e){
						rootJson.put("result3", e.toString());
				   }
			   }
		}
	}
	out.print(rootJson);
	%>