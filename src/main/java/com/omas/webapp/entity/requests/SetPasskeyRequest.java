package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SetPasskeyRequest { 
    
	
	@NotEmpty(message = "passkey cannot be empty")
	@Size(max = 64,  message = "passkey cannot be larger than 64 characters")
	@Size(min = 3, message = "passkey cannot be fewer than 3 character")
	private String passkey; 

    	
	@NotEmpty(message = "clubName cannot be empty")
	private String clubName; 
  
}