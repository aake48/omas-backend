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
    
    @StringOptions(value = {Constants.PISTOL_TYPE, Constants.RIFLE_TYPE},
    message = "Competition Type must be either "+Constants.PISTOL_TYPE +"  or "+Constants.RIFLE_TYPE)
    @NotEmpty(message = "competition type cannot be empty.")
    private String competitionType;

    @StringOptions(value = { Constants.COMPETITION_SERIES, Constants.COMPETITION_SERIES2,
                    Constants.COMPETITION_SERIES3, Constants.COMPETITION_SERIES4},
                    message = "Competition Series must be either " + Constants.COMPETITION_SERIES + ", "
                    + Constants.COMPETITION_SERIES2
                    + ", " + Constants.COMPETITION_SERIES3 + " or " + Constants.COMPETITION_SERIES4)
    @NotEmpty(message = "Competition series cannot be empty.")
    private String competitionSeries;

    @ValidEpochMilli(daysBehind = 1, daysAhead = 365, message = "invalid start")
    private Long startDate = System.currentTimeMillis() - 5L * 60 * 1000; // first digit is minutes == 5m

    @ValidEpochMilli(daysBehind = 0, daysAhead = 365, message = "invalid EndDate")
    private Long endDate = System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000;//adds +7 days

}

