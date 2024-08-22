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
<h1>Flight Form</h1>

<f:form action="saveFlight" method="POST" modelAttribute="flight">
<table border="1">

<tr>
<td>Flight Id: </td>
<td>
<f:input path="flightId" value="${nextFlightId}" readonly="true"/>
</td>
<td><f:errors path="flightId"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Flight Number: </td>
<td>
<f:input path="flightNumber" value="${f.getFlightNumber()}" />
</td>
<td><f:errors path="flightNumber"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Operating Airlines: </td>
<td>
<f:input path="operatingAirlines" value="${f.getOperatingAirlines().getAirlinesId()}" />
</td>
<td><f:errors path="operatingAirlines"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Departure City: </td>
<td>
<f:input path="departureCity" value="${f.getDepartureCity()}" />
</td>
<td><f:errors path="departureCity"  cssStyle="color:red;"></f:errors></td>
</tr>


<tr>
<td>Arrival City: </td>
<td>
<f:input path="arrivalCity" value="${f.getArrivalCity()}" />
</td>
<td><f:errors path="arrivalCity"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Departure Date: </td>
<td>
<f:input type="date" path="departureDate" value="${f.getDepartureDate()}"/>
</td>
<td><f:errors path="departureDate"  cssStyle="color:red;"></f:errors></td>
</tr>


<tr>
<td>Departure Date: </td>
<td>
<f:input type="time" path="departureTime" value="${f.getDepartureTime()}"/>
</td>
<td><f:errors path="departureTime"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Ticket Price: </td>
<td>
<f:input path="ticketPrice" value="${f.getTicketPrice()}" />
</td>
<td><f:errors path="ticketPrice"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Capacity: </td>
<td>
<f:input path="capacity" value="${f.getCapacity()}" />
</td>
<td><f:errors path="capacity"  cssStyle="color:red;"></f:errors></td>
</tr>

<tr>
<td>Booked: </td>
<td>
<f:input path="booked" value="${f.getBooked()}" />
</td>
<td><f:errors path="booked"  cssStyle="color:red;"></f:errors></td>
</tr>




<tr>
<td colspan="3" align="center" ><input type="submit"  value="Submit"/></td>
</tr>

</table>
</f:form>

<p/>
<h1>List of Flights</h1>

<table border="1">
<tr>
<th><a href="findAllFlights?sortBy=flightId">Flight Id</a></th> 
<th><a href="findAllFlights?sortBy=flightNumber">Flight Number</a></th> 
<th><a href="findAllFlights?sortBy=operatingAirlines">Operating Airlines</a></th>
<th><a href="findAllFlights?sortBy=departureCity">Departure City</a></th> 
<th><a href="findAllFlights?sortBy=arrivalCity">Arrival City</a></th> 
<th><a href="findAllFlights?sortBy=departureDate">Departure Date</a></th>
<th><a href="findAllFlights?sortBy=departureTime">Departure Time</a></th>
<th><a href="findAllFlights?sortBy=ticketPrice">Ticket Price</a></th> 
<th><a href="findAllFlights?sortBy=capacity">capacity</a></th>
<th><a href="findAllFlights?sortBy=booked">Booked</a></th>
<th>Actions</th>
</tr>

<tr>
<c:forEach items="${flights}" var="flight">
<td>${flight.getFlightId()}</td>
<td>${flight.getFlightNumber()}</td>
<td>${flight.getOperatingAirlines().getAirlinesId()}</td>
<td>${flight.getDepartureCity()}</td>
<td>${flight.getArrivalCity()}</td>
<td>${flight.getDepartureDate()}</td>
<td>${flight.getDepartureTime()}</td>
<td>${flight.getTicketPrice()}</td>
<td>${flight.getCapacity()}</td>
<td>${flight.getBooked()}</td>
<td>
<a href="deleteFlight?flightId=${flight.getFlightId()}">Delete</a>
<a href="updateFlight?flightId=${flight.getFlightId()}">Update</a>
</td>
</tr>

</c:forEach>

</table>

</div>

</body>
</html>