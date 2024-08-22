package com.synergisticit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.synergisticit.domain.Flight;
import com.synergisticit.domain.Passenger;
import com.synergisticit.repository.PassengerRepository;

@Service
public class PassengerServiceImpl implements PassengerService {
	
	@Autowired PassengerRepository passengerRepository;

	@Override
	public Passenger savePassenger(Passenger passenger) {
		
		return passengerRepository.save(passenger);
	}

	@Override
	public Passenger findById(long passengerId) {
		
		Optional<Passenger> optPassenger = passengerRepository.findById(passengerId);
		if(optPassenger.isPresent()) {
			return optPassenger.get();
		}
		return null;
	}

	@Override
	public List<Passenger> findAll() {
		
		return passengerRepository.findAll();
	}

	@Override
	public void deleteById(long passengerId) {
		passengerRepository.deleteById(passengerId);

	}

	@Override
	public boolean existsById(long passengerId) {
		
		return passengerRepository.existsById(passengerId);
	}

	@Override
	public Long getNextPassengerId() {
		
		return passengerRepository.getNextPassengerId();
	}

	@Override
	public List<Passenger> findAll(String sortBy) {
		
		return passengerRepository.findAll(Sort.by(sortBy));
	}

}
