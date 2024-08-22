package com.synergisticit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.synergisticit.domain.Airlines;
import com.synergisticit.repository.AirlinesRepository;

@Service
public class AirlinesServiceImpl implements AirlinesService {
	
	@Autowired AirlinesRepository airlinesRepository;

	@Override
	public Airlines saveAirlines(Airlines airlines) {

		return airlinesRepository.save(airlines);
	}

	@Override
	public Airlines findById(long airlinesId) {
		Optional<Airlines> optAirlines = airlinesRepository.findById(airlinesId);
		if(optAirlines.isPresent()) {
			return optAirlines.get();
		}
		return null;
	}

	@Override
	public List<Airlines> findAll() {
		
		return airlinesRepository.findAll();
	}

	@Override
	public void deleteById(long airlinesId) {
		
		airlinesRepository.deleteById(airlinesId);

	}

	@Override
	public boolean existsById(long airlinesId) {
		
		return airlinesRepository.existsById(airlinesId);
	}

	@Override
	public Long getNextAirlinesId() {
		
		return airlinesRepository.getNextAirlinesId();
	}

	@Override
	public List<Airlines> findAll(String sortBy) {

		return airlinesRepository.findAll(Sort.by(sortBy));
	}
	

}
