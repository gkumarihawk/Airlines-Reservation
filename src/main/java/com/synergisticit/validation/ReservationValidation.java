package com.synergisticit.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.synergisticit.domain.Passenger;
import com.synergisticit.domain.Reservation;

@Component
public class ReservationValidation implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return Reservation.class.equals(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		Reservation r = (Reservation)target;
		
		if(r.getCheckedBags()<0) {
			errors.rejectValue("checkedBags", "checkedBags.length", "Number of bags cannot be negative");
		}
		
		if(r.getFlight()==null) {
			errors.rejectValue("flight", "flight.value", "Please Enter the flight Id");
		}
		
		if(r.getPassenger()==null) {
			errors.rejectValue("passenger", "passenger.value", "Please Enter the Passenger Id");
		}
	}
}
	
