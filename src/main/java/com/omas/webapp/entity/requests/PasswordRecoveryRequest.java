package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class PasswordRecoveryRequest {
    
    @NotEmpty(message = "Email cannot be empty.")
    @Email(message = "Email should be in the correct format.")
    private String email;
}
