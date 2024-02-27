package com.omas.webapp.entity;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data; 
  
@Data
@AllArgsConstructor
public class AddTeamRequest { 
    
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}