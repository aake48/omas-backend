package com.omas.webapp.entity.requests;

import com.omas.webapp.Constants;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminAddScoreRequest {
    
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

	@NotEmpty(message = "teamName cannot be empty")
	private String teamName;

    @NotEmpty(message = "clubName cannot be empty")
	private String clubName;

    @NotNull(message = "userId cannot be Null")
	private long userId;

    @NotNull(message = "score cannot be empty")
	private double score;

	private String requestType = Constants.ADD_METHOD_SET;

    @NotNull(message = "bullsEyeCount cannot be empty")
	private int bullsEyeCount; 

}