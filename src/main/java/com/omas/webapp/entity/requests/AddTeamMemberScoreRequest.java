package com.omas.webapp.entity.requests;

import java.util.List;

import com.omas.webapp.entity.ValidScoreList;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddTeamMemberScoreRequest { 
    
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

	@ValidScoreList
    @NotEmpty(message = "ScoreList cannot be empty")
	private List<Double> ScoreList; 

}