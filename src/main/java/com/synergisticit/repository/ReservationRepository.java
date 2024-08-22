package com.synergisticit.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Reservation;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long>{
	
	@Query(value = "SELECT COALESCE(MAX(ticketNumber), 0) + 1 FROM Reservation", nativeQuery = true)
    Long getNextTicketNumber();
	
	Page<Reservation> findAll(Pageable pageable);
	
	List<Reservation> findAll(Sort sort);

}
