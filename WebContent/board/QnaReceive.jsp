<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
String qnaitem = request.getParameter("content");
String writer = request.getParameter("writer");
String title = request.getParameter("title");
String password = request.getParameter("password");
JSONObject rootJson = new JSONObject();

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
Connection wrconn = null;
PreparedStatement pstmt = null;
PreparedStatement wrtmt = null;
ResultSet rs = null;
int page_num;
String pagecount;
	
	try{
	    	wrconn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/qna_content", "BCNS","****");	    

			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bcns_beta","BCNS","****");
			
			wrtmt = wrconn.prepareStatement("insert into main (CONTENT, ID, TITLE, PASSWORD) values (?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
			wrtmt.setString(1, qnaitem);
			wrtmt.setString(2, writer);
			wrtmt.setString(3, title);
			wrtmt.setString(4, password);
    	
			wrtmt.executeUpdate();
			
			rs = wrtmt.getGeneratedKeys();
			
			pstmt = conn.prepareStatement("insert into qnalist (CONTENT, ID, TITLE) values (?, ?, ?)");
			pstmt.setString(1, qnaitem);
			pstmt.setString(2, writer);
			pstmt.setString(3, title);
			
			pstmt.executeUpdate();
			
			
			while(rs.next())
			{
				page_num = rs.getInt(1);
				pagecount = Integer.toString(page_num);
				rootJson.put("pagenum", pagecount);
			}			
			rootJson.put("result", "OK");
		}	catch (SQLException e){
		e.printStackTrace();
		out.print(e.toString());
	}
	finally{
		   if(wrtmt !=null){
			   try{
				   wrtmt.close();
			   }catch(Exception e){
					rootJson.put("result1", e.toString());				   
			   }
			   if (pstmt !=null){
				   try{
					   pstmt.close();
				   }catch(Exception e){
						rootJson.put("result2", e.toString());}
			   	}
		   }if(conn !=null){
				   try {
					   conn.close();
				   }catch (Exception e){
						rootJson.put("result3", e.toString());
						}				   
			   }if(wrconn !=null){
				   try{
				   wrconn.close();
			   }catch (Exception e){
					rootJson.put("result4", e.toString());
					}}		
	} 
	out.print(rootJson);
%>
