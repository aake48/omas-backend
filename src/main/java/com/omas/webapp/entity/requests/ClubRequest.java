package com.omas.webapp.entity.requests;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClubRequest { 
    
    @NotEmpty(message = "Club name cannot be empty.")
    @Size(max = 20, message = "Club name cannot be larger than 20 characters.")
    @Size( min = 3, message = "Club name cannot be fewer than 3 characters.")
    private String clubName;

    private String passkey = null;

}