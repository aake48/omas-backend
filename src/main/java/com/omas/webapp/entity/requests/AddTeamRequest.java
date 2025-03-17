package com.omas.webapp.entity.requests;

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

	@NotEmpty(message = "teamName cannot be empty")
	private String teamName;

	@NotEmpty(message = "teamDisplayShort cannot be empty")
	private String teamDisplayShort;

	@NotEmpty(message = "teamSeries cannot be empty")
	private String teamSeries;
}