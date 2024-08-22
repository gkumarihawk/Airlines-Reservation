package com.synergisticit.domain;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Flight {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long flightId;
	
	private String flightNumber;
	
	@ManyToOne
	private Airlines operatingAirlines;
	
	private String departureCity;
	
	private String arrivalCity;
	
	@DateTimeFormat(iso=DateTimeFormat.ISO.DATE)
	private LocalDate departureDate;
	
	@DateTimeFormat(iso=DateTimeFormat.ISO.TIME)
	private LocalTime departureTime;
	
	@NotNull
	private Double ticketPrice;
	
	@NotNull
	private int capacity;
	
	@NotNull
	private int booked;
	
	@OneToMany
	private List<Reservation> reservation = new ArrayList<>();
	

}
