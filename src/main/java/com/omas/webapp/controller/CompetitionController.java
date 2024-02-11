package com.omas.webapp.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class CompetitionController {

    @GetMapping("/auth/user") 
    @PreAuthorize("hasAuthority('ROLE_USER')") 
    public String userRoleTest() { 
        return "user with ROLE_USER authorized"; 
    } 

}