<%@ page pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
String Id = request.getParameter("Id");
String Age = request.getParameter("Age");
String Sex = request.getParameter("Sex");
String Name = request.getParameter("Name");
String PassWord = request.getParameter("PassWord");
String HomePage = request.getParameter("HomePage");
String NickName = request.getParameter("NickName");
String Email = request.getParameter("Email");
String Email_Op = request.getParameter("Email_Op");
String Call = request.getParameter("Call");
String Call_Op = request.getParameter("Call_Op");
String License = request.getParameter("License");
String License_1 = request.getParameter("License_1");
String Address = request.getParameter("Address");
String FaceImage = request.getParameter("FaceImage");
String BodyImage = request.getParameter("BodyImage");
String Award = request.getParameter("Award");
String Award_1 = request.getParameter("Award_1");
String Permission = request.getParameter("Permission");
String Award_AA = request.getParameter("Award_AA");
String Award_1_AA = request.getParameter("Award_1_AA");
String License_AA = request.getParameter("License_AA");
String License_1_AA = request.getParameter("License_1_AA");
String Award_Image = request.getParameter("Award_Image");
String Award_1_Image = request.getParameter("Award_1_Image");
String License_Image = request.getParameter("License_Image");
String License_1_Image = request.getParameter("License_1_Image");
JSONObject rootJson = new JSONObject();

Class.forName("org.mariadb.jdbc.Driver");
Connection wrconn = null;
PreparedStatement wrtmt = null;
ResultSet rs = null;
int page_num;
String pagecount;
	
	try{
	    	wrconn = DriverManager.getConnection("jdbc:mariadb://localhost:3308/bcns_beta", "BCNS","****");	    			
			
			wrtmt = wrconn.prepareStatement("insert into trainer (ID, NAME, NICKNAME, PASSWORD, AGE, SEX, ADDRESS, EMAIL, PHONE, HOMEPAGE, FACEPHOTO, BODYPHOTO, PERMISSION, CALL_OP, EMAIL_OP, Li_NAME, LI_ASSOCIATION, LI_IMAGE, LI_1_NAME, LI_1_ASSOCIATION, LI_1_IMAGE, AW_NAME, AW_ASSOCIATION, AW_IMAGE, AW_1_NAME, AW_1_ASSOCIATION, AW_1_IMAGE) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			wrtmt.setString(1, Id);
			wrtmt.setString(2, Name);
			wrtmt.setString(3, NickName);
			wrtmt.setString(4, PassWord);
			wrtmt.setInt(5, Integer.parseInt(Age));
			wrtmt.setInt(6, Integer.parseInt(Sex));
			wrtmt.setString(7, Address);
			wrtmt.setString(8, Email);
			wrtmt.setString(9, Call);
			wrtmt.setString(10, HomePage);
			wrtmt.setString(11, FaceImage);
			wrtmt.setString(12, BodyImage);
			wrtmt.setInt(13, Integer.parseInt(Permission));
			wrtmt.setInt(14, Integer.parseInt(Call_Op));
			wrtmt.setInt(15, Integer.parseInt(Email_Op));
			wrtmt.setString(16, License);
			wrtmt.setString(17, License_AA);
			wrtmt.setString(18, License_Image);
			wrtmt.setString(19, License_1);
			wrtmt.setString(20, License_1_AA);
			wrtmt.setString(21, License_1_Image);
			wrtmt.setString(22, Award);
			wrtmt.setString(23, Award_AA);
			wrtmt.setString(24, Award_Image);
			wrtmt.setString(25, Award_1);
			wrtmt.setString(26, Award_1_AA);
			wrtmt.setString(27, Award_1_Image);
    	
			wrtmt.executeUpdate();
			
			
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
			   if (wrtmt !=null){
				   try{
					   wrtmt.close();
				   }catch(Exception e){
						rootJson.put("result2", e.toString());}
			   	}
		   }if(wrconn !=null){
				   try {
					   wrconn.close();
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


