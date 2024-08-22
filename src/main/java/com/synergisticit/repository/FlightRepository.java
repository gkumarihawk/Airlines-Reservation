package com.synergisticit.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Flight;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Long>{
	
	@Query(value = "SELECT COALESCE(MAX(FlightId), 0) + 1 FROM Flight", nativeQuery = true)
    Long getNextFlightId();
	
	Page<Flight> findAll(Pageable pageable);
	
	List<Flight> findAll(Sort sort);
	
	List<Flight> findByDepartureCityAndArrivalCityAndDepartureDate(String departureCity, String arrivalCity, LocalDate departureDate);

}
