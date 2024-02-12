package com.omas.webapp.table;

import jakarta.persistence.Entity; 
import jakarta.persistence.GeneratedValue; 
import jakarta.persistence.GenerationType; 
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_")
public class User { 

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private int id; 
	@NotEmpty(message = "Username cannot be empty")
	@Size(max = 20,  message = "Username cannot be larger than 20 characters")
	@Size(min = 3, message = "Username cannot be fewer than 3.")
	private String name; 
	@NotEmpty(message = "Email cannot be empty.")
	@Email(message = "Email should be in the correct format.")
	private String email;
	@NotEmpty(message = "Password cannot be empty.")
	@Size(min = 6, message = "Password cannot be fewer than 6 characters")
	private String password;
	@NotEmpty(message = "User should have a role.")
	private String roles; 

} 
