package com.synergisticit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.synergisticit.domain.Passenger;
import com.synergisticit.domain.Reservation;
import com.synergisticit.repository.ReservationRepository;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired ReservationRepository reservationRepository;

	@Override
	public Reservation saveReservation(Reservation reservation) {
		
		return reservationRepository.save(reservation);
	}

	@Override
	public Reservation findById(long ticketNumber) {
		
		Optional<Reservation> optReservation = reservationRepository.findById(ticketNumber);
		if(optReservation.isPresent()) {
			return optReservation.get();
		}
		return null;
	}

	@Override
	public List<Reservation> findAll() {
		
		return reservationRepository.findAll();
	}

	@Override
	public void deleteById(long ticketNumber) {
		reservationRepository.deleteById(ticketNumber);

	}

	@Override
	public boolean existsById(long ticketNumber) {
		
		return reservationRepository.existsById(ticketNumber);
	}

	@Override
	public Long getNextTicketNumber() {
		
		return reservationRepository.getNextTicketNumber();
	}

	@Override
	public List<Reservation> findAll(String sortBy) {
		
		return reservationRepository.findAll(Sort.by(sortBy));
	}

}
