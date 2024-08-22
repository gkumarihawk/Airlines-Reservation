package com.synergisticit.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Passenger;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, Long>{
	
	@Query(value = "SELECT COALESCE(MAX(PassengerId), 0) + 1 FROM Passenger", nativeQuery = true)
    Long getNextPassengerId();
	
	Page<Passenger> findAll(Pageable pageable);
	
	List<Passenger> findAll(Sort sort);

}
