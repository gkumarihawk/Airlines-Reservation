package com.synergisticit.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.synergisticit.domain.Passenger;

@Component
public class PassengerValidation implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return Passenger.class.equals(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		Passenger p = (Passenger)target;
		
		if(p.getFirstName().length()<=2) {
			errors.rejectValue("firstName", "firstName.length", "First Name should not be less than 1 characters.");
		}
		
		if(p.getLastName().length()<=2) {
			errors.rejectValue("lastName", "lastName.length", "Last Name should not be less than 1 characters.");
		}
		
		if(p.getMobileNo()==null) {
			errors.rejectValue("mobileNo", "mobileNo.value", "Mobile number not be null");
		}
	
		if(p.getGender()==null) {
			errors.rejectValue("gender", "gender.value", "Please select a Gender");
		}
		
		if(p.getDOB()==null) {
			errors.rejectValue("DOB", "DOB.value", "Date of birth cannot be empty");
		}
	}

}
