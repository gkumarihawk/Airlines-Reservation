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

import com.synergisticit.domain.Airlines;
import com.synergisticit.domain.Flight;
import com.synergisticit.service.AirlinesService;
import com.synergisticit.service.FlightService;
import com.synergisticit.validation.AirlinesValidation;

@Controller
public class AirlinesController {
	
	@Autowired AirlinesService airlinesService;
	
	//@Autowired FlightService flightService;
	
	@Autowired AirlinesValidation airlinesValidator;
	
	@RequestMapping("airlinesForm")
    public String airlinesForm(Airlines airlines, Model model) {
		//model.addAttribute("airlines", new Airlines());
        model.addAttribute("airlineses", airlinesService.findAll());
        model.addAttribute("nextAirlinesId", airlinesService.getNextAirlinesId());
        
        return "airlinesForm";
    }
	
	@RequestMapping("saveAirlines")
	public ModelAndView savesTheAirlines(@Validated @ModelAttribute Airlines airlines, BindingResult br) {
		airlinesValidator.validate(airlines, br);
		ModelAndView mav = new ModelAndView("airlinesForm");
		System.out.println("br.hasErrors(): "+br.hasErrors());
		if(br.hasErrors()) {
			mav.addObject("hasErrors", br.hasErrors());
			List<Airlines> airlineses = airlinesService.findAll();
			mav.addObject("airlineses", airlineses);
			return mav;
		}else {
			
			airlinesService.saveAirlines(airlines);
			return new ModelAndView("redirect:airlinesForm");
		}
	}

	/*@RequestMapping("updateAirlines")
	public String forUpdatingTheAirlines(Airlines airlines, Model model) {
	
		Airlines retrievedAirlines = airlinesService.findById(airlines.getAirlinesId());
		model.addAttribute("airlines", airlinesService.findAll());
		model.addAttribute("a", retrievedAirlines);
		return "airlinesForm";
	}*/
	
	@RequestMapping("updateAirlines")
    public String updateAirlines(@RequestParam long airlinesId, Model model) {
        Airlines retrievedAirlines = airlinesService.findById(airlinesId);
        model.addAttribute("airlines", retrievedAirlines);
        model.addAttribute("airlineses", airlinesService.findAll());
        return "airlinesForm";
    }
	

	@RequestMapping("deleteAirlines")
	public String deletesTheAirlines(Airlines airlines) {
		airlinesService.deleteById(airlines.getAirlinesId());
		return "redirect:airlinesForm";
	}
	
	@RequestMapping("findAllAirlineses")
	public String findAll(Airlines airlines, @RequestParam String sortBy, Model model) {
		model.addAttribute("airlineses", airlinesService.findAll(sortBy));
		return "airlinesForm";
	}
	

}
