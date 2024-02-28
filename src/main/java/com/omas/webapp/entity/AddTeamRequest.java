package com.omas.webapp.entity;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddTeamRequest { 
    
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

}