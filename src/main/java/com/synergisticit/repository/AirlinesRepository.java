package com.synergisticit.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Airlines;


@Repository
public interface AirlinesRepository extends JpaRepository<Airlines, Long>{
	
	@Query(value = "SELECT COALESCE(MAX(airlinesId), 0) + 1 FROM airlines", nativeQuery = true)
    Long getNextAirlinesId();
	
	Page<Airlines> findAll(Pageable pageable);
	
	List<Airlines> findAll(Sort sort);

}
