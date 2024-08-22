package com.synergisticit.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergisticit.domain.Airlines;
import com.synergisticit.domain.Flight;
import com.synergisticit.service.AirlinesService;
import com.synergisticit.service.FlightService;
import com.synergisticit.validation.FlightValidation;

@Controller
public class FlightController {

    @Autowired
    private FlightService flightService;

    @Autowired
    private AirlinesService airlinesService;

    @Autowired
    private FlightValidation flightValidator;

    @RequestMapping("flightForm")
    public ModelAndView flightForm(Flight flight) {
        return getModelAndView();
    }

    @RequestMapping("saveFlight")
    public ModelAndView savesTheFlight(@Validated @ModelAttribute Flight flight, BindingResult br) {
        flightValidator.validate(flight, br);
        ModelAndView mav = getModelAndView();

        if (br.hasErrors()) {
            mav.addObject("hasErrors", true);
            List<Flight> flights = flightService.findAll();
            List<Airlines> airlines = airlinesService.findAll();
            mav.addObject("flights", flights);
            mav.addObject("airlineses", airlines);

            return mav;
        } else {
            flightService.saveFlight(flight);
            return new ModelAndView("redirect:flightForm");
        }
    }

    @RequestMapping("updateFlight")
    public String forUpdatingTheFlight(@ModelAttribute Flight flight, Model model) {
        Flight retrievedFlight = flightService.findById(flight.getFlightId());
        Airlines retrievedAirlines = airlinesService.findById(retrievedFlight.getOperatingAirlines().getAirlinesId());

        model.addAttribute("flights", flightService.findAll());
        model.addAttribute("airlineses", airlinesService.findAll());
        model.addAttribute("airlines", retrievedAirlines);
        model.addAttribute("f", retrievedFlight);

        return "flightForm";
    }

    @RequestMapping("deleteFlight")
    public String deletesTheFlight(@ModelAttribute Flight flight) {
        flightService.deleteById(flight.getFlightId());
        return "redirect:flightForm";
    }

    private ModelAndView getModelAndView() {
        ModelAndView mav = new ModelAndView("flightForm");
        List<Flight> flights = flightService.findAll();

        mav.addObject("flights", flights);
        mav.addObject("airlineses", airlinesService.findAll());
        mav.addObject("nextFlightId", flightService.getNextFlightId());

        return mav;
    }

    @RequestMapping("findAllFlights")
    public String findAll(@ModelAttribute Flight flight, @RequestParam String sortBy, Model model) {
        model.addAttribute("flights", flightService.findAll(sortBy));
        return "flightForm";
    }

    @GetMapping("/flight")
    public String showFilteredFlights(@RequestParam("departureCity") String departureCity,
                                      @RequestParam("arrivalCity") String arrivalCity,
                                      @RequestParam("departureDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate departureDate,
                                      Model model) {

        // Query flights from the service based on the criteria
        List<Flight> flights = flightService.findFlightsByCriteria(departureCity, arrivalCity, departureDate);

        // Add flights to model to display in JSP
        model.addAttribute("flights", flights);

        return "flight"; // Assuming "flight.jsp" is your view to display filtered flights
    }

    @GetMapping("/flight/select/{flightId}")
    public String selectFlight(@PathVariable int flightId) {
        // Call service method to handle flight selection
        flightService.findById(flightId);
        // Redirect to a confirmation page or any other desired page
        return "redirect:/passengerForm"; // Redirect to the flights list page or any other page
    }

}
