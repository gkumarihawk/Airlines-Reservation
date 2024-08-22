<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.navbar {
        background-color: #1e88e5;
        padding: 20px 20px; /* Adjust padding here */
        border-radius: 8px;
        font-size: 18px;
        position: fixed;
        width: calc(100% - 80px); /* Adjust width to increase space */
        top: 0;
        left: 20px; /* Adjust left to increase space */
        right: 40px; /* Adjust right to increase space */
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .navbar a {
        color: #fff;
        text-decoration: none;
        margin: 0 10px;
    }
    .navbar a:hover {
        text-decoration: underline;
    }
    .navbar .dropdown {
        position: relative;
        display: inline-block;
        left: -40px;
    }
    .navbar .dropdown-content {
        display: none;
        position: absolute;
        background-color: #e3f2fd;
        min-width: 160px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1;
        left: -20px; /* Adjust the position towards the left */
    }
    .navbar .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }
    .navbar .dropdown-content a:hover {
        background-color: #bbdefb;
    }
    .navbar .dropdown:hover .dropdown-content {
        display: block;
        left: 0; /* Ensure dropdown is aligned with parent */
    }

</style>
</head>
<body>

<div class="navbar">
    <a href="/home">Airlines-Reservation</a>
    <sec:authorize access="isAuthenticated">
            <br>Welcome,  <sec:authentication property="principal.username"/><br>
            <%-- Your authorities are: <sec:authentication property="principal.authorities"/> --%>
        </sec:authorize>
    <div class="dropdown">
    	
        <a href="#">Menu</a>
        <div class="dropdown-content">
        	<sec:authorize access="hasAuthority('Admin')">
            	<a href="${pageContext.request.contextPath}/roleForm">Role Form</a>
            	<a href="${pageContext.request.contextPath}/airlinesForm">Airlines Form</a>
            	<a href="${pageContext.request.contextPath}/flightForm">Flight Form</a>
            </sec:authorize>
            <a href="${pageContext.request.contextPath}/index">Book a flight</a>
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/userForm">User Form</a>
            <sec:authorize access="hasAuthority('Admin')">
            	<a href="${pageContext.request.contextPath}/passengerForm">Passenger Form</a>
            	<a href="${pageContext.request.contextPath}/reservationForm">Reservation Form</a>
            </sec:authorize>
            <sec:authorize access="isAuthenticated">
                <a href="/logout">Logout</a>
            </sec:authorize>
            <sec:authorize access="!isAuthenticated">
                <a href="/loginForm">Login</a>
            </sec:authorize>
        </div>
    </div>
</div>


<div align="center">
<h1>Airlines Form</h1>

<f:form action="saveAirlines" method="POST" modelAttribute="airlines">
<table border="1">

<tr>
<td>Airlines Id: </td>
<td>
<f:input path="airlinesId" value="${nextAirlinesId}" readonly="true"/>
</td>
<td><f:errors path="airlinesId"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Airlines Name: </td>
<td>
<f:input path="airlinesName" value="${a.getAirlinesName()}" />
</td>
<td><f:errors path="airlinesName"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Airlines Code: </td>
<td>
<f:input path="airlinesCode" value="${a.getAirlinesCode()}" />
</td>
<td><f:errors path="airlinesCode"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td colspan="3" align="center" ><input type="submit"  value="Submit"/></td>
</tr>

</table>
</f:form>

<p/>
<h1>List of Airlines</h1>

<table border="1">
<tr>
<th><a href="findAllAirlineses?sortBy=airlinesId">Airlines Id</a></th> 
<th><a href="findAllAirlineses?sortBy=airlinesName">Airlines Name</a></th> 
<th><a href="findAllAirlineses?sortBy=airlinesCode">Airlines Code</a></th>
<th>Actions</th>
</tr>

<tr>
<c:forEach items="${airlineses}" var="airlines">
<td>${airlines.getAirlinesId()}</td>
<td>${airlines.getAirlinesName()}</td>
<td>${airlines.getAirlinesCode()}</td>
<td>
<a href="deleteAirlines?airlinesId=${airlines.getAirlinesId()}">Delete</a>
<a href="updateAirlines?airlinesId=${airlines.getAirlinesId()}">Update</a>
</td>
</tr>

</c:forEach>

</table>

</div>

</body>
</html>