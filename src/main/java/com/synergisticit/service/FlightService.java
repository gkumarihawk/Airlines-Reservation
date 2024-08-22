package com.synergisticit.service;

import java.time.LocalDate;
import java.util.List;

import com.synergisticit.domain.Flight;

public interface FlightService {
	
	Flight saveFlight(Flight flight);
	Flight findById(long flightId);
	List<Flight> findAll();
	void deleteById(long flightId);
	boolean existsById(long flightId);
	Long getNextFlightId();
	
	List<Flight> findAll(String sortBy);
	
	List<Flight> findFlightsByCriteria(String departureCity, String arrivalCity, LocalDate departureDate);
	
	
	

}
