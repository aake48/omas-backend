package com.omas.webapp.entity;

import java.util.List;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data; 
  
@Data
@AllArgsConstructor
public class AddTeamMemberScoreRequest { 
    
	@NotEmpty(message = "userId cannot be empty")
	private Long userId; 

	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

    @NotEmpty(message = "ScoreList cannot be empty")
	private List<Double> ScoreList; 

}