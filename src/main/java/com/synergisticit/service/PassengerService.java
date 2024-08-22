package com.synergisticit.service;

import java.util.List;

import com.synergisticit.domain.Flight;
import com.synergisticit.domain.Passenger;

public interface PassengerService {
	
	Passenger savePassenger(Passenger passenger);
	Passenger findById(long passengerId);
	List<Passenger> findAll();
	void deleteById(long passengerId);
	boolean existsById(long passengerId);
	Long getNextPassengerId();
	
	List<Passenger> findAll(String sortBy);

}
