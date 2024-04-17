package com.omas.webapp.entity.requests;

import com.omas.webapp.Constants;
import com.omas.webapp.entity.validators.scoreValidator.ValidScore;
import com.omas.webapp.entity.validators.stringValidator.StringOptions;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor; 
import lombok.Data;
import lombok.NoArgsConstructor; 
  
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddTeamMemberScoreAsSumRequest { 
    
	@NotEmpty(message = "competitionName cannot be empty")
	private String competitionName; 

	@NotEmpty(message = "teamName cannot be empty")
	private String teamName;

	@ValidScore
    @NotNull(message = "score cannot be empty")
	private Double score;

	private Long userId = null;

	// requestType determines the operation used to update the user's scores.
	// Constants.ADD_METHOD_SET sets the score overwriting any previous while
	// Constants.ADD_METHOD_UPDATE adds to the previous score or sets the score if there are none yet
	@StringOptions(
		value = {Constants.ADD_METHOD_SET, Constants.ADD_METHOD_UPDATE},
		message = "requestType must be either " + Constants.ADD_METHOD_SET + " or " + Constants.ADD_METHOD_UPDATE
	)
	private String requestType = Constants.ADD_METHOD_SET;

    @NotNull(message = "bullsEyeCount cannot be empty")
	private Integer bullsEyeCount;

}