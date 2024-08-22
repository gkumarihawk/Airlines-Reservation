package com.synergisticit.service;

import java.util.List;

import com.synergisticit.domain.Reservation;

public interface ReservationService {
	
	Reservation saveReservation(Reservation reservation);
	Reservation findById(long ticketNumber);
	List<Reservation> findAll();
	void deleteById(long ticketNumber);
	boolean existsById(long ticketNumber);
	Long getNextTicketNumber();
	
	List<Reservation> findAll(String sortBy);

}
