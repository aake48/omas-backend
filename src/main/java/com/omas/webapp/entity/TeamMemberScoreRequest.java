package com.omas.webapp.entity;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeamMemberScoreRequest { 
    
	//@NotEmpty(message = "userId cannot be empty")
	private long userId; 

    	
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}