package com.omas.webapp.entity;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompetitionRequest { 
    
    @NotEmpty(message = "Competition name cannot be empty.")
    @Size(max = 40, message = "Competition name cannot be larger than 40 characters.")
    @Size( min = 3, message = "Competition name cannot be fewer than 3 characters.")
    private String competitionName;

}