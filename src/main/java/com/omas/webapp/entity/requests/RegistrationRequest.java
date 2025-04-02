package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationRequest { 
    
	
	@NotEmpty(message = "Username cannot be empty")
	@Size(max = 64,  message = "Username cannot be larger than 64 characters")
	@Size(min = 3, message = "Username cannot be fewer than 3 characters")
	private String username; 

    	
	@NotEmpty(message = "Name cannot be empty")
	@Size(max = 64,  message = "Username cannot be larger than 64 characters")
	@Size(min = 3, message = "Name cannot be fewer than 3 characters")
	private String name; 

	@NotEmpty(message = "Email cannot be empty")
	@Email(message = "Email should be in the correct format")
	private String email;
    
	@NotEmpty(message = "Password cannot be empty")
    @Size(max = 64,  message = "Password cannot be larger than 64 characters")
	@Size(min = 6, message = "Password cannot be fewer than 6 characters")
	private String password;

	@NotEmpty(message = "Role cannot be empty")
	private String role;

	private String club;

  
}