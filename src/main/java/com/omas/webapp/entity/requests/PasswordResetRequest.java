package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class PasswordResetRequest {
    
    @NotEmpty(message = "token cannot be empty.")
    private String token;

    @NotEmpty(message = "Password cannot be empty.") 
    @Size(max = 64,  message = "password cannot be larger than 64 characters")
    @Size(min = 6, message = "Password cannot be fewer than 6 characters.")
    private String password;
}
