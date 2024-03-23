package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdateEmailRequest {

    @NotEmpty(message = "Email cannot be empty.")
    @Email(message = "Email should be in the correct format.")
    private String email;

    @NotEmpty(message = "password cannot be empty.")
    private String password;
}