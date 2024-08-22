package com.synergisticit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.synergisticit.domain.Reservation;
import com.synergisticit.service.ReservationService;
import com.synergisticit.validation.ReservationValidation;

import jakarta.validation.Valid;

@RestController
@RequestMapping("reservation")
public class ReservationRestController {
	
	@Autowired ReservationService reservationService;
	
	@Autowired ReservationValidation reservationValidator;
	
	@PostMapping(value="save")
	public ResponseEntity<?> saveReservation(@Valid @RequestBody Reservation reservation, BindingResult br){
		reservationValidator.validate(reservation, br);
		HttpHeaders headers = new HttpHeaders();
		if(reservationService.existsById(reservation.getTicketNumber()) || br.hasFieldErrors()) {
			StringBuilder sb = new StringBuilder();
			if(br.hasFieldErrors()) {
				List<FieldError> fieldErrors = br.getFieldErrors();
				for(FieldError fe : fieldErrors) {
					sb.append(fe.getField()+": ")
					.append(fe.getDefaultMessage() +"\n");
				}
				System.out.println(sb.toString());
				headers.add("Error Count", String.valueOf(fieldErrors.size()));
				return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.CONFLICT);
			}else {
				return new ResponseEntity<String>("Reservation with Ticket number "+ reservation.getTicketNumber() + " already exists.",  HttpStatus.CREATED);
			}
			
		}else {
			Reservation retrivedReservation = reservationService.saveReservation(reservation);
			return new ResponseEntity<Reservation>(retrivedReservation, HttpStatus.CREATED);
		}
	};

}
