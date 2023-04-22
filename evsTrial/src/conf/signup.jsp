<%@page import="java.io.InputStream"%> 
<%@page import="java.io.FileInputStream"%> 
<%@page import="java.io.File"%> 
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.ResultSet"%> 
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="java.sql.Connection"%> 
<%@page import = "org.apache.commons.fileupload.*" %>
<%@page import = "org.apache.commons.fileupload.disk.*" %>
<%@page import = "org.apache.commons.fileupload.servlet.*" %>
<%@page import = "org.apache.commons.io.output.*" %>
<%@page import = "javax.servlet.http.*" %>
<%@page import = "javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html> 
<html> 
   
    <body> 
		<!-- <sql:setDataSource var = "snapshot" driver = "org.postgresql.Driver"
		url = "jdbc:postgresql://[127.0.0.1]:54320/evsdb"
		user = "evsDBA"  password = "evsdba"/> -->
    <% 
		String VoterId;
		String VoterName; //=request.getParameter("VoterName");
		String VoterDOB; // =request.getParameter("VoterDOB");
		String VoterStream; //=request.getParameter("VoterStream");
		String VoterEmailId; //=request.getParameter("VoterEmail");
		String VoterPassword; //=request.getParameter("VoterPassword");
		String fileName;

	Connection conn=null; 
	PreparedStatement pstmt = null; 
	ResultSet rs=null; 

	String url="jdbc:postgresql://127.0.0.1:54320/evsdb"; 
	String user = "evsDBA",password = "evsdba";
	FileInputStream fis=null;
    
	File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");
   

   // Verify the content type
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("/home/yashika/Documents/Desktop/WebServer/apache-tomcat-10.1.1/webapps/evsTrial/fileuploads"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
	
	 
	try{ 

		List<FileItem> fileItems = upload.parseRequest(request);

		// Process the uploaded file items
		Iterator<FileItem> i = fileItems.iterator();

		
		while ( i.hasNext () ) {
		   FileItem fi = (FileItem)i.next();
		   if ( !fi.isFormField () ) {
			  // Get the uploaded file parameters
			  String fieldName = fi.getFieldName();
			  fileName = fi.getName();
			  boolean isInMemory = fi.isInMemory();
			  long sizeInBytes = fi.getSize();
			
			  }
			  else {
				if(fi.getFieldName()=="VoterId")
					VoterId=fi.getString();
				else if(fi.getFieldName()=="VoterName")
					VoterName=fi.getString();
				else if(fi.getFieldName()=="VoterDOB")
					VoterDOB=fi.getString();
				else if(fi.getFieldName()=="VoterStream")
					VoterStream=fi.getString();
				else if(fi.getFieldName()=="VoterEmail")
					VoterEmailId=fi.getString();
				else if(fi.getFieldName()=="VoterPassword")
					VoterPassword=fi.getString();
			  }

				

			  }
			  // Write the file
			  if( fileName.lastIndexOf("\\") >= 0 ) {
				 file = new File( filePath + 
				 fileName.substring( fileName.lastIndexOf("\\"))) ;
			  } else {
				 file = new File( filePath + 
				 fileName.substring(fileName.lastIndexOf("\\")+1)) ;
			  }
			  fi.write( file ) ;
			  out.println("Uploaded Filename: " + filePath + 
			  fileName + "<br>");
		   }
		}

		/* String VoterId=request.getParameter("VoterId");//VoterId:input name used in jsp :input id used in javascript
		
		//String VoterImage = request.getParameter("myimg");  */

		Class.forName("org.postgresql.Driver").newInstance(); 
		conn=DriverManager.getConnection(url,user,password); 
		System.out.println("Before File image - new file:"+VoterName+VoterId+VoterStream+VoterDOB+VoterImage);
		File image= new File(VoterImage); 
		
		pstmt = conn.prepareStatement("insert into voter (voterid,votername,dateofbirth,stream,emailid,loginpassword,registrationdate,enrollfr,photo) " + "values(?,?,?,?,?,?,now(),'true',?)"); 
		
        pstmt.setString(1, VoterId); 
		pstmt.setString(2, VoterName); 
		pstmt.setString(3, VoterDOB); 
        pstmt.setString(4, VoterStream); 
        pstmt.setString(5, VoterEmailId); 
        pstmt.setString(6, VoterPassword); 
        //pstmt.setString(8, VoterEnrollFR); 
		System.out.println("after setting pstmt and before fis");
		fis=new FileInputStream(image); 
		pstmt.setBinaryStream(7, (InputStream) fis, (int) (image.length())); 
		int count = pstmt.executeUpdate(); 
		if(count>0) 
		{ 
			out.println("insert successfully"); 
		} 
		else 
		{ 
			out.println("not successfully"); 
		} 
	} 
	catch(Exception ex) 
	{ 
		ex.printStackTrace(); 
	} 
	finally{ 
		try{ 
			if(rs!=null){ 
				rs.close(); 
				rs= null; 
			} 
			if(pstmt !=null) 
			{ 
				pstmt.close(); 
				pstmt=null; 
			} 
			if(conn!=null) 
			{ 
				conn.close(); 
				conn=null; 
			} 
				
		} 
		catch(Exception e) 
		{ 
			e.printStackTrace(); 
		} 
	} 
				x
	%> 

   
   

   
        Congratulations <%=VoterName%>, you have successfully registered!<br />
   </body> 


</html>
	



