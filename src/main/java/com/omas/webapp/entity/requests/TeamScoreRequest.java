package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeamScoreRequest { 
    
	@NotEmpty(message = "clubName cannot be empty")
	private String clubName; 

    	
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}