package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteRequest {

    @NotEmpty(message = "username cannot be empty.")
    private String username;

}
