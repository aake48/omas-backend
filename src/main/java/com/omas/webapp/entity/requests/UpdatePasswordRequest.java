package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdatePasswordRequest {

    @NotEmpty(message = "newPassword cannot be empty.")
    @Size(max = 64, message = "newPassword cannot be larger than 64 characters")
    @Size(min = 6, message = "newPassword cannot be fewer than 6 characters")
    private String newPassword;

    @NotEmpty(message = "oldPassword cannot be empty.")
    private String oldPassword;
}