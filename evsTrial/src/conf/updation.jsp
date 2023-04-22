
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>

<!DOCTYPE html>
<html>
    <body>
        <%
            //String VoterId=request.getParameter("VoterId");//VoterId:input name used in jsp :input id used in javascript
            String VoterName=request.getParameter("VoterName");
            String VoterDOB=request.getParameter("VoterDOB");
            String VoterStream=request.getParameter("VoterStream");
            String VoterEmailId=request.getParameter("VoterEmailId");
            String VoterPassword=request.getParameter("VoterPassword");
        %>
        <sql:setDataSource var = "snapshot" driver = "org.postgresql.Driver"
         url = "jdbc:postgresql://127.0.0.1:54320/evsdb"
         user = "evsDBA"  password = "evsdba"/>
         <fmt:parseDate value="${param.VoterDOB}" var="parsedDOB" pattern="yyyy-MM-dd" />
        
       
            <sql:update dataSource = "${snapshot}" var = "result">
                UPDATE voter SET votername=?,dateofbirth=?,emailid=?,loginpassword=? where voterid=?;
                <sql:param value="${param.VoterName}" />
                <sql:dateParam value="${parsedDOB}" />
                <sql:param value="${param.VoterEmailId}" />
                <sql:param value="${param.VoterPassword}" />
                <sql:param value="${Integer.parseInt(sessionScope.VoterId)}" />
                </sql:update>

                Voter Profile for ${param.VoterName} successfully updated for ${param.VoterDOB}, ${param.VoterEmailId} and Password which we obviously can't show here.


    </body> 
    
</html>    
