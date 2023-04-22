<%-- 
    Document   : login.jsp
    Created on : 21-Oct-2022, 9:36:40 pm
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
        <%//request.getParameters reads the input given in form
            String VoterId=request.getParameter("VoterId");//VoterId:input name used in jsp :input id used in javascript
            String VoterName=request.getParameter("VoterPass");
            
            //local variable formed to use in one another
        %>
        <sql:setDataSource var = "snapshot" driver = "org.postgresql.Driver"
         url = "jdbc:postgresql://127.0.0.1:54320/evsdb"
         user = "evsDBA"  password = "evsdba"/>
        
         <sql:query dataSource = "${snapshot}" var = "result">
         select count(*) as Count from voter where voterid = ? and loginpassword = ?;
         <sql:param value="${Integer.parseInt(param.VoterId)}" />
         <sql:param value="${param.VoterPass}" />
               </sql:query>
         
         
         <c:choose>
             <c:when test="${result.rows[0].Count>0}">
                 <c:set var="VoterId" value="${param.VoterId}" scope="session"> </c:set>
                 <c:out value="Login successful! You may now cast vote!!<br />"></c:out>
             </c:when>
             <c:otherwise>
                 <c:out value="Login failed! Please try login again else you won't be able to cast vote!!<br />"></c:out>
             </c:otherwise>
         </c:choose>
    </body>
    <%@include file="footer.jspf" %>
</html>
