<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Passenger Form and List</title>
    <style>
        body {
            font-family: 'Times New Roman', Times, serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('https://cdn.dribbble.com/users/2194564/screenshots/4520948/db_airplane_in_the_sky.gif');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 16px;
            width: 50%;
            max-width: 600px;
            margin: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 12px;
            font-size: 24px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 8px;
        }
        th, td {
            padding: 6px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 6px;
            text-align: left;
        }
        .label {
            font-weight: bold;
        }
        input[type="text"], input[type="date"], input[type="email"], input[type="tel"] {
            width: calc(100% - 12px);
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin: 2px 0;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="radio"] {
            margin-right: 6px;
            vertical-align: middle;
        }
        button {
            background: #2980b9;
            color: #fff;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background: #3498db;
        }
        .error-message {
            color: red;
            font-size: 12px;
        }
        .actions {
            white-space: nowrap;
        }
        .actions a {
            margin-right: 4px;
            text-decoration: none;
            color: #2980b9;
            font-size: 14px;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        .hidden {
            display: none;
        }
        .scrollable {
            overflow-x: auto;
            margin-top: 10px;
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
        
        
        
        
        
    </style>
    <script>
        function togglePassengerList() {
            var passengerList = document.getElementById('passengerList');
            passengerList.classList.toggle('hidden');
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
        <h1>Passenger Form</h1>
        <f:form action="savePassenger" method="POST" modelAttribute="passenger">
            <table>
                <tr>
                    <td>Passenger Id:</td>
                    <td colspan="2">
                        <f:input path="passengerId" value="${nextPassengerId}" readonly="true"/>
                        <f:errors path="passengerId" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td>First Name:</td>
                    <td colspan="2">
                        <f:input path="firstName" value="${p.getFirstName()}" />
                        <f:errors path="firstName" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td>Last Name:</td>
                    <td colspan="2">
                        <f:input path="lastName" value="${p.getLastName()}" />
                        <f:errors path="lastName" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td colspan="2">
                        <f:input path="email" value="${p.getEmail()}" />
                        <f:errors path="email" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td>Mobile No:</td>
                    <td colspan="2">
                        <f:input path="mobileNo" value="${p.getMobileNo()}" />
                        <f:errors path="mobileNo" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Gender:</td>
                    <td colspan="2">
                        <c:forEach items="${genders}" var="g">
                            <f:radiobutton path="gender" label="${g}" value="${g}" />
                        </c:forEach>
                        <f:errors path="gender" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td>Date of Birth:</td>
                    <td colspan="2">
                        <f:input type="date" path="DOB" value="${p.getDOB()}" />
                        <f:errors path="DOB" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td class="label">Identification Type:</td>
                    <td colspan="2">
                        <c:forEach items="${identificationTypes}" var="it">
                            <f:radiobutton path="idType" label="${it}" value="${it}" />
                        </c:forEach>
                        <f:errors path="idType" cssClass="error-message" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <button type="submit">Submit</button>
                    </td>
                </tr>
            </table>
        </f:form>
        
        <div align="center" style="margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/reservationForm" class="reserve-btn">Reserve your seat now</a>
        </div>
        
        <div align="center" style="margin-top: 10px;">
            <button onclick="togglePassengerList()">View Passengers</button>
        </div>
        
        <sec:authorize access="hasAuthority('Admin')">
        <div id="passengerList" class="hidden scrollable">
            <h1>List of Passengers</h1>
            <table>
                <tr>
                    <th><a href="findAllPassengers?sortBy=passengerId">Passenger Id</a></th>
                    <th><a href="findAllPassengers?sortBy=firstName">First Name</a></th>
                    <th><a href="findAllPassengers?sortBy=lastName">Last Name</a></th>
                    <th><a href="findAllPassengers?sortBy=email">Email</a></th>
                    <th><a href="findAllPassengers?sortBy=mobileNo">Mobile No</a></th>
                    <th>Gender</th>
                    <th>Date of Birth</th>
                    <th>Id Type</th>
                    <th>Actions</th>
                </tr>
                <c:forEach items="${passengers}" var="passenger">
                    <tr>
                        <td>${passenger.passengerId}</td>
                        <td>${passenger.firstName}</td>
                        <td>${passenger.lastName}</td>
                        <td>${passenger.email}</td>
                        <td>${passenger.mobileNo}</td>
                        <td>${passenger.gender}</td>
                        <td>${passenger.DOB}</td>
                        <td>${passenger.idType}</td>
                        <td class="actions">
                            <a href="deletePassenger?passengerId=${passenger.passengerId}">Delete</a>
                            <a href="updatePassenger?passengerId=${passenger.passengerId}">Update</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        </sec:authorize>
    </div>
</body>
</html>
