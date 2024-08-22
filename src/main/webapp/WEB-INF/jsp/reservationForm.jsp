<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation Form</title>
<style>
    body {
        font-family: 'Times New Roman', Times, serif;
        background-image: url('https://cdn.dribbble.com/users/787156/screenshots/3425156/plane.gif');
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        margin: 0;
        padding: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
    .container {
        width: 100%;
        max-width: 400px;
        background: rgba(255, 255, 255, 0.9);
        padding: 10px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
        position: relative;
    }
    h1 {
        color: #333;
        font-size: 1.5rem;
        margin-bottom: 10px;
    }
    form {
        margin-top: 10px;
        width: 100%;
        box-sizing: border-box;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        padding: 6px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    td {
        background-color: #fff;
    }
    td.error {
        color: red;
    }
    .actions a {
        margin-right: 8px;
        text-decoration: none;
    }
    .actions a:hover {
        text-decoration: underline;
    }
    .view-button {
        margin-top: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 6px 12px;
        border-radius: 4px;
        cursor: pointer;
    }
    .reservations-table {
        display: none;
        margin-top: 20px;
    }
    .show {
        display: block !important;
    }
    .confirmation {
        position: absolute;
        bottom: 100px; /* Adjust as needed */
        left: 50px; /* Adjust as needed */
        padding: 10px;
        background-color: #dff0d8;
        border: 1px solid #c3e6cb;
        border-radius: 4px;
    }
    .confirmation-close {
        position: absolute;
        top: 5px;
        right: 5px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        color: #888;
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
    <h1>Reservation Form</h1>

    <f:form action="saveReservation" method="POST" modelAttribute="reservation">
        <table>
            <tr>
                <td>Reservation Id:</td>
                <td>
                    <f:input path="ticketNumber" value="${nextTicketNumber}" readonly="true"/>
                </td>
                <td class="error"><f:errors path="ticketNumber"></f:errors></td>
            </tr>
            <tr>
                <td>Passenger:</td>
                <td>
                    <f:input path="passenger" />
                </td>
                <td class="error"><f:errors path="passenger"></f:errors></td>
            </tr>
            <tr>
                <td>Flight:</td>
                <td>
                    <f:input path="flight" />
                </td>
                <td class="error"><f:errors path="flight"></f:errors></td>
            </tr>
            <tr>
                <td>Checked Bags:</td>
                <td>
                    <f:input path="checkedBags" />
                </td>
                <td class="error"><f:errors path="checkedBags"></f:errors></td>
            </tr>
            <tr>
                <td>Checked In:</td>
                <td>
                    <input type="checkbox" path="checkedIn"/>
                    <label>Checked In</label>
                </td>
                <td class="error"><f:errors path="checkedIn"></f:errors></td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <input type="submit" value="Submit"/>
                </td>
            </tr>
        </table>
    </f:form>

    <c:if test="${not empty confirmationMessage}">
        <div class="confirmation">
            <span class="confirmation-close" onclick="closeConfirmation()">✖</span>
            ${confirmationMessage}
        </div>
    </c:if>

    <button class="view-button" onclick="toggleReservations()">View Reservations</button>

    <div class="reservations-table" id="reservationsTable">
        <hr>
        <sec:authorize access="hasAuthority('Admin')">
        <h1>List of Reservations</h1>
        <table>
            <tr>
                <th><a href="findAllReservations?sortBy=ticketNumber">Ticket Number</a></th>
                <th><a href="findAllReservations?sortBy=passenger">Passenger</a></th>
                <th><a href="findAllReservations?sortBy=flight">Flight</a></th>
                <th><a href="findAllReservations?sortBy=checkedBags">Checked Bags</a></th>
                <th>Checked In</th>
                <th>Actions</th>
            </tr>
            <c:forEach items="${reservations}" var="reservation">
                <tr>
                    <td>${reservation.ticketNumber}</td>
                    <td>${reservation.passenger.passengerId}</td>
                    <td>${reservation.flight.flightId}</td>
                    <td>${reservation.checkedBags}</td>
                    <td>${reservation.checkedIn}</td>
                    <td class="actions">
                        <a href="deleteReservation?ticketNumber=${reservation.ticketNumber}">Delete</a>
                        <a href="updateReservation?ticketNumber=${reservation.ticketNumber}">Update</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </sec:authorize>
    </div>
</div>

<script>
    function toggleReservations() {
        var reservationsTable = document.getElementById("reservationsTable");
        reservationsTable.classList.toggle("show");
    }

    function closeConfirmation() {
        var confirmation = document.querySelector(".confirmation");
        confirmation.style.display = "none";
    }
</script>

</body>
</html>
