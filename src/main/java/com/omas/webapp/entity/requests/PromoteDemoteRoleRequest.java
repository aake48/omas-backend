package com.omas.webapp.entity.requests;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class PromoteDemoteRoleRequest {
    
    @NotNull(message = "userId cannot be null.")
    private long userId;

    @NotNull(message = "role cannot be nulls.") 
    private String role;
}
