package com.synergisticit.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.synergisticit.domain.Airlines;
import com.synergisticit.domain.Flight;

@Component
public class FlightValidation implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return Flight.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Flight f = (Flight)target;
		
		if(f.getFlightNumber().length()<=0) {
			errors.rejectValue("flightNumber", "flightNumber.length", "Flight Number should not be less than 1 characters.");
		}
	
		if(f.getOperatingAirlines()== null) {
			errors.rejectValue("operatingAirlines", "operatingAirlines.value", "Operating Airlines should not be null");
		}
		
		if(f.getDepartureCity() == null) {
			errors.rejectValue("departureCity", "departureCity.value", "Departure City should not be null");
		}
		
		if(f.getArrivalCity() == null) {
			errors.rejectValue("arrivalCity", "arrivalCity.value", "Arrival City should not be null");
		}
		
		if(f.getDepartureDate()==null) {
			errors.rejectValue("departureDate", "departureDate.value", "Departure Date should not be null");
		}
		
		if(f.getDepartureTime()==null) {
			errors.rejectValue("departureTime", "departureTime.value", "Departure Time should not be null");
		}
		
		if(f.getTicketPrice()<=0) {
			errors.rejectValue("ticketPrice", "ticketPrice.value", "Ticket Price should not be null or less than 0");
		}
		
		if(f.getCapacity()<=0) {
			errors.rejectValue("capacity", "capacity.value", "Capacity should not be less than 0");
		}
		
		if(f.getBooked()<=0) {
			errors.rejectValue("booked", "booked.value", "Booked should not be less than 0");
		}
		
		
	}

}
