<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Form</title>
<style>
    body {
        font-family: "Times New Roman", Times, serif;
        background-image: url('https://ozstaff.com/images/login.gif');
        background-repeat: no-repeat;
            background-position: center center; /* Center the background image */
            background-size: 85%;
    }
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
    .container {
        margin-top: 80px; /* Adjust margin-top to leave space */
        display: flex;
        justify-content: center;
        align-items: center;
        height: calc(100vh - 80px); /* Adjust height to account for margin-top */
    }
    h1 {
        color: #1e88e5;
        text-align: center;
    }
    .form-table-container {
        width: 80%;
        max-width: 600px; /* Adjust maximum width as needed */
        background-color: rgba(255, 255, 255, 0.8);
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        padding: 20px;
    }
    .form-table {
        width: 100%;
        padding: 10px;
    }
    .form-table td {
        padding: 8px;
    }
    .form-table input[type="submit"] {
        background-color: #1e88e5;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .form-table input[type="submit"]:hover {
        background-color: #1565c0;
    }
    .error {
        color: red;
    }
    .user-list {
        display: none;
        margin-top: 20px;
    }
    .show-users-btn {
        background-color: #1e88e5;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .show-users-btn:hover {
        background-color: #1565c0;
    }
</style>



<script>
    function toggleUserList() {
        var userList = document.getElementById('userList');
        if (userList.style.display === 'none' || userList.style.display === '') {
            userList.style.display = 'block';
        } else {
            userList.style.display = 'none';
        }
    }
</script>
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

<div class="container">
    <div align="center">
        <%-- <sec:authorize access="isAuthenticated">
            <br>Welcome <br> <sec:authentication property="principal.username"/>
            <br>Your authorities are: <sec:authentication property="principal.authorities"/>
        </sec:authorize> --%>
        <sec:authorize access="!isAuthenticated">
            <br> <a href="login">Login</a>
        </sec:authorize>
        <h1>User Form</h1>

        <div class="form-table-container">
            <f:form action="saveUser" modelAttribute="user">
                <table class="form-table">
                    <tr>
                        <td>User Id:</td>
                        <td>
                            <f:input path="userId" value="${u.getUserId()}"/>
                            <f:errors path="userId" cssClass="error"></f:errors>
                        </td>
                    </tr>
                    <tr>
                        <td>Name:</td>
                        <td>
                            <f:input path="username" value="${u.getUsername()}"/>
                            <f:errors path="username" cssClass="error"></f:errors>
                        </td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td>
                            <f:input path="password" value="${u.getPassword()}"/>
                            <f:errors path="password" cssClass="error"></f:errors>
                        </td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>
                            <f:input path="email" value="${u.getEmail()}"/>
                            <f:errors path="email" cssClass="error"></f:errors>
                        </td>
                    </tr>
                    <tr>
                        <td>Roles:</td>
                        <td>
                            <c:forEach items="${roles}" var="role">
                                <c:if test="${retriedRoles.contains(role)}">
                                    <f:checkbox path="roles" label="${role.getRoleName()}" value="${role.getRoleId()}" checked="true"/>
                                </c:if>
                                <c:if test="${!retriedRoles.contains(role)}">
                                    <f:checkbox path="roles" label="${role.getRoleName()}" value="${role.getRoleId()}"/>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><input type="submit" value="Submit"/></td>
                    </tr>
                </table>
            </f:form>
        </div>

		<sec:authorize access="hasAuthority('Admin')">
        <button class="show-users-btn" onclick="toggleUserList()">List of Users</button>

		
        <div id="userList" class="user-list">
        	
            <h1>List of Users</h1>
            <table>
                <tr>
                    <th><a href="findAllUsers?sortBy=userId">User id</a></th> 
                    <th><a href="findAllUsers?sortBy=username">Name</a></th> 
                    <th><a href="findAllUsers?sortBy=password">Password</a></th> 
                    <th><a href="findAllUsers?sortBy=email">Email</a></th> 
                    <th>Roles</th> 
                    <th>Action</th>
                </tr>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.getUserId()}</td>
                        <td>${user.getUsername()}</td>
                        <td>${user.getPassword()}</td>
                        <td>${user.getEmail()}</td>
                        <td>
                            <c:forEach items="${user.getRoles()}" var="role">
                                ${role.getRoleName()}
                            </c:forEach>
                        </td>
                        <td>
                            <a href="deleteUser?userId=${user.getUserId()}">Delete</a>
                            <a href="updateUser?userId=${user.getUserId()}">Update</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            
        </div>
        </sec:authorize>
    </div>
</div>
</body>
</html>
