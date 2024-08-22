package com.synergisticit.domain;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Email;
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
public class Passenger {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long passengerId;
	
	private String firstName;
	
	private String lastName;
	
	@Email
	private String email;
	
	private String mobileNo;
	
	@Enumerated(EnumType.STRING)
	private Gender gender;
	
	@DateTimeFormat(iso=DateTimeFormat.ISO.DATE)
	private LocalDate DOB;
	
	@Enumerated(EnumType.STRING)
	private IdentificationType idType;
	
	

}
