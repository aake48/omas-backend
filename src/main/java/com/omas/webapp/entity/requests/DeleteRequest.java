package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteRequest {

    @NotNull(message = "userId cannot be empty.")
    private Long userId;

}
