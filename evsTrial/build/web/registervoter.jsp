<%-- 
    Document   : registervoter
    Created on : 18-Oct-2022, 8:50:54 am
    Author     : Yashika
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
 
<!DOCTYPE html>
<html>
    <%@include file="header.jspf" %>
    <body>
        <%@include file="menu.jspf" %>
        <%
            String VoterId=request.getParameter("VoterId");
            String VoterName=request.getParameter("VoterName");
            String VoterDOB=request.getParameter("VoterDOB");
            String VoterStream=request.getParameter("VoterStream");
            String VoterEmailId=request.getParameter("VoterEmail");
            String VoterPassword=request.getParameter("VoterPassword");
            String VoterEnrollFR=request.getParameter("EnrollmentChoice");
        %>
		
         <sql:setDataSource var = "snapshot" driver = "org.postgresql.Driver"
         url = "jdbc:postgresql://127.0.0.1:5432/evsdb"
         user = "evsDBA"  password = "evsdba"/>
         <fmt:parseDate value="${param.VoterDOB}" var="parsedDOB" pattern="dd/MM/yyyy" />
         
         <sql:update dataSource = "${snapshot}" var = "result">
         INSERT INTO voter(voterid,votername,dateofbirth,stream,emailid,loginpassword,registrationdate,enrollfr) VALUES (?,?,?,?,?,?,now(),?);
         <sql:param value="${Integer.parseInt(param.VoterId)}" />
         <sql:param value="${param.VoterName}" />
         <sql:dateParam value="${parsedDOB}" />
         <sql:param value="${param.VoterStream}" />
         <sql:param value="${param.VoterEmail}" />
         <sql:param value="${param.VoterPassword}" />
         <sql:param value="${Boolean.parseBoolean(param.EnrollmentChoice)}" />
               </sql:update>
 
        Congratulations <%=VoterName%>, you have successfully registered!<br />
         
    </body>
    <%@include file="footer.jspf" %>
</html>
