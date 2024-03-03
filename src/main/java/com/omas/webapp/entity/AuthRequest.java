package com.omas.webapp.entity;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthRequest { 
    
    @NotEmpty(message = "Username cannot be empty.")
	@Size(max = 64,  message = "Username cannot be larger than 64 characters")
	@Size(min = 3, message = "Username cannot be fewer than 3 character")
    private String username;
    @NotEmpty(message = "Password cannot be empty.") 
    @Size(max = 64,  message = "password cannot be larger than 64 characters")
    @Size(min = 6, message = "Password cannot be fewer than 6 characters.")
    private String password; 
  
}