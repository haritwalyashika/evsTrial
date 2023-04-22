<%-- 
    Document   : castvote
    Created on : 22-Oct-2022, 7:48:58 am
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
        
         <sql:query dataSource = "${snapshot}" var = "voterdata">
         select voterid,votername,dateofbirth,stream,emailid,loginpassword from voter where voterid = ${sessionScope.VoterId};
         
               </sql:query>
         
         
         
         <c:out value="Welcome  ${voterdata.rows[0].votername},you can update your dob,emailid,password ">
             
         </c:out>
         <!-- <form action='servletcastvote' method='post'>
             <input type='hidden' value="${sessionScope.VoterId}" name="VoterId" />
             <table border='1'>
             <c:forEach var="candidaterows" items="${candidaturedata.rows}">
                 <tr><td><input type="radio" id="CandidatureId" name="CandidatureId" value="${candidaterows.candidatureid}"><c:out value="Candidate: ${candidaterows.votername}. Manifesto:${candidaterows.manifesto}.Achievements:${candidaterows.achievements}"></c:out></input></td></tr>
             </c:forEach>
                 <tr><Td><input type='submit' value='submit'><!-- comment --></td></tr>
             </table>
         </form> -->


         <form action="updation.jsp"  method="post"    >
            <div class="input-group">

                <div class="input-field">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" id="VoterName" name="VoterName" value="${voterdata.rows[0].votername}" />
                </div>
            
            
                <div class="betinput">
                    <p>Your Date of Birth </p>
                </div>
                <div class="input-field">
                    <i class="fa-solid fa-calendar-days"></i>
                    <input type="date" id="VoterDOB" name="VoterDOB" value="${voterdata.rows[0].dateofbirth}" />
                </div>

                <div class="input-field">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="VoterEmailId" name="VoterEmailId"  value="${voterdata.rows[0].emailid}"  />
            </div>

            <div class="input-field">
                <i class="fa-solid fa-lock"></i>
                <input type="password" id="VoterPassword" name="VoterPassword" value="${voterdata.rows[0].loginpassword}"  >
            </div> 
            <div class="input-field">
                <i class="fa-solid fa-lock"></i>
                <button type="submit" id="Submit" name="Submit">Submit</button>
                <button type="reset" id="Reset" name="Reset">Reset</button>
                
            </div> 
            </form>
    </body>
    
</html>
