package com.omas.webapp.entity;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data; 
  
@Data
@AllArgsConstructor
public class TeamMemberScoreRequest { 
    
	@NotEmpty(message = "userId cannot be empty")
	private long id; 

    	
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}