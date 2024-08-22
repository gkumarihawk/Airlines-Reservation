package com.synergisticit.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.synergisticit.domain.Airlines;


@Component
public class AirlinesValidation implements Validator {
	

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return Airlines.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Airlines a = (Airlines)target;
		
		if(a.getAirlinesName().length()<2) {
			errors.rejectValue("airlinesName", "airlinesName.length", "Name should not be less than 1 characters.");
		}
	
		if(a.getAirlinesCode().length()<=0) {
			errors.rejectValue("airlinesCode", "airlinesCode.length", "airlines Code should not be null");
		}
		
		
		
	}

}

