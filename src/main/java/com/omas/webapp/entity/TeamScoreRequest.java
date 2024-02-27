package com.omas.webapp.entity;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data; 
  
@Data
@AllArgsConstructor
public class TeamScoreRequest { 
    
	@NotEmpty(message = "clubName cannot be empty")
	private String clubName; 

    	
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}