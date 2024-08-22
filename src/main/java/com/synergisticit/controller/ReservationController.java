package com.synergisticit.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.synergisticit.domain.Flight;
import com.synergisticit.domain.Passenger;
import com.synergisticit.domain.Reservation;
import com.synergisticit.service.FlightService;
import com.synergisticit.service.PassengerService;
import com.synergisticit.service.ReservationService;
import com.synergisticit.validation.ReservationValidation;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private PassengerService passengerService;

    @Autowired
    private FlightService flightService;

    @Autowired
    private ReservationValidation reservationValidator;

    @RequestMapping("reservationForm")
    public ModelAndView reservationForm(@RequestParam(required = false) Integer flightId, Reservation reservation) {
        ModelAndView mav = getModelAndView();
        mav.addObject("nextTicketNumber", reservationService.getNextTicketNumber());

        if (flightId != null) {
            Flight flight = flightService.findById(flightId);
            reservation.setFlight(flight);
        }

        return mav;
    }

    @RequestMapping("saveReservation")
    public String saveReservation(@Validated @ModelAttribute Reservation reservation, BindingResult br,
                                        @RequestParam(required = false) Integer flightId, Model model) {
        reservationValidator.validate(reservation, br);

        if (br.hasErrors()) {
            ModelAndView mav = getModelAndView();
            mav.addObject("hasErrors", true);
            mav.addObject("reservations", reservationService.findAll());
            mav.addObject("passengers", passengerService.findAll());
            mav.addObject("flights", flightService.findAll());
            return "reservationForm";
        } else {
            if (flightId != null) {
                Flight flight = flightService.findById(flightId);
                reservation.setFlight(flight);
            }

            reservationService.saveReservation(reservation);
            
            String confirmationMessage = "Confirmed! Your tickets have been booked and the flight details are:<br>"
                    + "Ticket Number: " + reservation.getTicketNumber() + "<br>"
                    + "Flight Number: " + reservation.getFlight().getFlightNumber() + "<br>"
                    + "Departure City: " + reservation.getFlight().getDepartureCity() + "<br>"
                    + "Arrival City: " + reservation.getFlight().getArrivalCity() + "<br>"
                    + "Date of Departure: " + reservation.getFlight().getDepartureDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            model.addAttribute("confirmationMessage", confirmationMessage);
            model.addAttribute("reservation", new Reservation());
            
            return "reservationForm";
        }
    }

    @RequestMapping("updateReservation")
    public String updateReservation(@ModelAttribute Reservation reservation, Model model,
                                    @RequestParam(required = false) Integer flightId) {
        Reservation retrievedReservation = reservationService.findById(reservation.getTicketNumber());

        if (flightId != null) {
            Flight flight = flightService.findById(flightId);
            reservation.setFlight(flight);
        }

        model.addAttribute("reservations", reservationService.findAll());
        model.addAttribute("passengers", passengerService.findAll());
        model.addAttribute("flights", flightService.findAll());
        model.addAttribute("reservation", retrievedReservation);

        return "reservationForm";
    }

    @RequestMapping("deleteReservation")
    public String deleteReservation(@ModelAttribute Reservation reservation) {
        reservationService.deleteById(reservation.getTicketNumber());
        return "redirect:reservationForm";
    }

    @RequestMapping("findAllReservations")
    public String findAllReservations(@ModelAttribute Reservation reservation, @RequestParam String sortBy, Model model) {
        model.addAttribute("reservations", reservationService.findAll(sortBy));
        return "reservationForm";
    }

    private ModelAndView getModelAndView() {
        ModelAndView mav = new ModelAndView("reservationForm");
        mav.addObject("reservations", reservationService.findAll());
        mav.addObject("flights", flightService.findAll());
        mav.addObject("passengers", passengerService.findAll());
        mav.addObject("nextTicketNumber", reservationService.getNextTicketNumber());
        return mav;
    }
    
    @GetMapping("/reservation/select/{flightId}") // Changed the mapping path
    public String selectFlight(@PathVariable Integer flightId, Model model) {
        // Retrieve the selected flight from the service
        Flight selectedFlight = flightService.findById(flightId);

        // Add selected flight to the model
        model.addAttribute("selectedFlight", selectedFlight);

        // Add other necessary attributes to the model
        model.addAttribute("passengers", passengerService.findAll()); // Assuming you have a method to fetch all passengers
        model.addAttribute("nextTicketNumber", reservationService.getNextTicketNumber()); // Assuming you have a method to get the next ticket number

        return "redirect:/reservationForm"; // Redirect to reservationForm or any other view
    }

}
