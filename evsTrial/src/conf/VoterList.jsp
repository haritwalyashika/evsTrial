<%-- 
    Document   : VoterList
    Created on : Apr 20, 2023, 11:57:26 PM
    Author     : yashika
--%>
<%@ page import="java.io.*"%>
 <%@ page import="java.sql.*"%>
 <%@ page import="java.util.*"%>
  <%@ page import="java.text.*"%>
 <%@ page import="jakarta.servlet.*"%>
 <%@ page import="jakarta.servlet.http.*"%>
 <%@ page import="jakarta.servlet.http.HttpSession"%>
 <%@ page language="java"%>
 <%@ page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="header.jspf"%>
    <body>
        <%@include file="menu.jspf" %>
   
    

<sql:setDataSource var="webappDataSource"
    driver="org.postgresql.Driver" url="jdbc:postgresql://127.0.0.1:54320/evsdb"
    user="evsDBA" password="evsdba" />

<sql:query dataSource="${webappDataSource}"
    sql="select voterid,votername,stream from voter" var="result" />

<table width="100%" border="1">
    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td>${row.votername}</td>
            <td>${row.stream}</td>
            <td>
               <img src="${pageContext.servletContext.contextPath }/photoServlet?Voterid=${row.voterid}" width="100" height="120"/>
            </td>
        </tr>
    </c:forEach>
</table>
<%@include file="footer.jspf" %>
</body>
</html>
    
