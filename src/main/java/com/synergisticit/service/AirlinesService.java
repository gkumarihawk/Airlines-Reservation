package com.synergisticit.service;

import java.util.List;

import com.synergisticit.domain.Airlines;


public interface AirlinesService {
	
	Airlines saveAirlines(Airlines airlines);
	Airlines findById(long airlinesId);
	List<Airlines> findAll();
	void deleteById(long airlinesId);
	boolean existsById(long airlinesId);
	Long getNextAirlinesId();
	
	List<Airlines> findAll(String sortBy);

}
