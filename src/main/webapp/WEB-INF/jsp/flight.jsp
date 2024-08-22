<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Filtered Flights</title>
    <style>
        body {
            font-family: 'Times New Roman', Times, serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
            background-image: url('https://www.freevector.com/uploads/vector/preview/18707/Free-Cartoon-Airplane-Vector.jpg'); /* Replace with your actual image URL */
            background-repeat: no-repeat;
            background-position: center center; /* Center the background image */
            background-size: 99%; /* Adjust size of the airplane icon */
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full height of viewport */
        }
        .table-container {
            max-width: 1000px; /* Reduced width for smaller table */
            background-color: #ecf0f1; /* Light gray background */
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            font-size: 24px; /* Slightly smaller font size */
            font-weight: bold;
            text-transform: uppercase; /* Uppercase text */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden; /* Ensure rounded corners display properly */
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px; /* Reduced padding */
            text-align: center;
            border: 1px solid #ddd;
            font-size: 14px; /* Smaller font size */
            font-family: 'Times New Roman', Times, serif; /* Times New Roman font */
        }
        th {
            background-color: #3498db; /* Blue background for header */
            color: #fff;
            font-weight: bold;
        }
        th .flight-icon {
            font-size: 18px; /* Adjusted icon size */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 5px;
        }
        .actions a {
            padding: 5px 10px; /* Reduced padding for actions */
            text-decoration: none;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 3px;
            transition: background-color 0.3s ease;
            font-size: 12px; /* Smaller font size for actions */
            font-family: 'Times New Roman', Times, serif; /* Times New Roman font */
        }
        .actions a:hover {
            background-color: #e0e0e0;
        }
        .select-button {
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
            transition: background-color 0.3s ease;
            font-size: 12px;
        }
        .select-button:hover {
            background-color: #2980b9;
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
    <div class="table-container">
        <h1>List of Flights</h1>

        <table>
            <thead>
                <tr>
                    <th>Flight Id <span class="flight-icon">&#9992;</span></th> 
                    <th>Flight Number</th> 
                    <th>Operating Airlines</th>
                    <th>Departure City</th> 
                    <th>Arrival City</th> 
                    <th>Departure Date</th>
                    <th>Departure Time</th>
                    <th>Ticket Price</th> 
                    <th>Capacity</th>
                    <th>Booked</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${flights}" var="flight">
    				<tr>
        				<td>${flight.flightId}</td>
        				<td>${flight.flightNumber}</td>
        				<td>${flight.operatingAirlines.airlinesId}</td>
        				<td>${flight.departureCity}</td>
        				<td>${flight.arrivalCity}</td>
        				<td>${flight.departureDate}</td>
        				<td>${flight.departureTime}</td>
        				<td>${flight.ticketPrice}</td>
        				<td>${flight.capacity}</td>
        				<td>${flight.booked}</td>
        				<td>
            				<form action="${pageContext.request.contextPath}/passengerForm" method="GET">
                				<input type="hidden" name="flightId" value="${flight.flightId}">
                				<button type="submit">Book</button>
            				</form>
        				</td>
    				</tr>
				</c:forEach>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>
