package com.omas.webapp.entity.requests;
import com.omas.webapp.entity.StringOptionsValidator.StringOptions;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor;
import com.omas.webapp.Constants;
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

}

