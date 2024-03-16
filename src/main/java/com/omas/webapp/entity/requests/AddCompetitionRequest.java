package com.omas.webapp.entity.requests;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor;
import com.omas.webapp.Constants;
import com.omas.webapp.entity.validators.stringValidator.StringOptions;
import com.omas.webapp.entity.validators.timevalidator.ValidEpochMilli;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddCompetitionRequest { 
    
    @NotEmpty(message = "Competition name cannot be empty.")
    @Size(max = 40, message = "Competition name cannot be larger than 40 characters.")
    @Size( min = 3, message = "Competition name cannot be fewer than 3 characters.")
    private String competitionName;
    
    @StringOptions(value = {Constants.pistolType, Constants.rifleType},
    message = "Competition Type must be either "+Constants.pistolType+"  or "+Constants.pistolType)
    @NotEmpty(message = "competition type cannot be empty.")
    private String competitionType;

    @ValidEpochMilli(daysBehind = 1, daysAhead = 365, message = "invalid start")
    private Long startDate = System.currentTimeMillis();

    @ValidEpochMilli(daysBehind = 0, daysAhead = 365, message = "invalid EndDate")
    private Long endDate = System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000;//adds +7 days

}

