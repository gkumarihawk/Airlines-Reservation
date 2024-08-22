package com.synergisticit.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.synergisticit.domain.Airlines;
import com.synergisticit.domain.Flight;
import com.synergisticit.repository.FlightRepository;

@Service
public class FlightServiceImpl implements FlightService {
	
	@Autowired FlightRepository flightRepository;

	@Override
	public Flight saveFlight(Flight flight) {

		return flightRepository.save(flight);
	}

	@Override
	public Flight findById(long flightId) {
		
		Optional<Flight> optFlight = flightRepository.findById(flightId);
		if(optFlight.isPresent()) {
			return optFlight.get();
		}
		return null;
	}

	@Override
	public List<Flight> findAll() {
		
		return flightRepository.findAll();
	}

	@Override
	public void deleteById(long flightId) {
		
		flightRepository.deleteById(flightId);

	}

	@Override
	public boolean existsById(long flightId) {
		
		return flightRepository.existsById(flightId);
	}

	@Override
	public Long getNextFlightId() {
		
		return flightRepository.getNextFlightId();
	}

	@Override
	public List<Flight> findAll(String sortBy) {
		
		return flightRepository.findAll(Sort.by(sortBy));
	}
	
	public List<Flight> findFlightsByCriteria(String departureCity, String arrivalCity, LocalDate departureDate) {
        return flightRepository.findByDepartureCityAndArrivalCityAndDepartureDate(departureCity, arrivalCity, departureDate);
    }

}
