package com.synergisticit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergisticit.domain.Flight;
import com.synergisticit.domain.Gender;
import com.synergisticit.domain.IdentificationType;
import com.synergisticit.domain.Passenger;
import com.synergisticit.service.PassengerService;
import com.synergisticit.validation.PassengerValidation;

@Controller
public class PassengerController {
	
	@Autowired PassengerService passengerService;
	
	@Autowired PassengerValidation passengerValidator;
	
	@RequestMapping("passengerForm")
	public ModelAndView passengerForm(Passenger passenger) {
		return getModelAndView(); 
	}
	
	@RequestMapping("savePassenger")
	public ModelAndView savesThePassenger(@Validated @ModelAttribute Passenger passenger, BindingResult br) {
	    passengerValidator.validate(passenger, br);
	    if (br.hasErrors()) {
	        ModelAndView mav = getModelAndView();
	        mav.addObject("hasErrors", br.hasErrors());
	        mav.addObject("passengers", passengerService.findAll());
	        return mav;
	    } else {
	        passengerService.savePassenger(passenger);
	        return new ModelAndView("redirect:passengerForm");
	    }
	}

	@RequestMapping("updatePassenger")
	public String forUpdatingThePassenger(Passenger passenger, Model model) {
		Passenger retrievedPassenger = passengerService.findById(passenger.getPassengerId());
		IdentificationType retrievedIndentificationType =  retrievedPassenger.getIdType();
		Gender retrievedGenderType =  retrievedPassenger.getGender();
		
		model.addAttribute("passengers", passengerService.findAll());
		model.addAttribute("p", retrievedPassenger);
		model.addAttribute("identificationTypes", IdentificationType.values());	
		model.addAttribute("retrievedIdentificationType", retrievedIndentificationType);
		model.addAttribute("genders", Gender.values());	
		model.addAttribute("retrievedGenderType", retrievedGenderType);
		return "passengerForm";
	}
		
	@RequestMapping("deletePassenger")
	public String deletesTheAccount(Passenger passenger) {
		passengerService.deleteById(passenger.getPassengerId());
		return "redirect:passengerForm";
	}
	
	private ModelAndView getModelAndView() {
		ModelAndView mav = new ModelAndView("passengerForm");
		List<Passenger> passengers = passengerService.findAll();
		
		mav.addObject("passengers", passengers);
		mav.addObject("genders", Gender.values());
		mav.addObject("identificationTypes", IdentificationType.values());
		mav.addObject("nextPassengerId", passengerService.getNextPassengerId());
	
		return mav;
	}
	
	@RequestMapping("findAllPassengers")
	public String findAll(Passenger passenger, @RequestParam String sortBy, Model model) {
		model.addAttribute("passengers", passengerService.findAll(sortBy));
		return "passengerForm";
	}
}
