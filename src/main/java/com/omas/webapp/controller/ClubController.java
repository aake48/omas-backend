package com.omas.webapp.controller;

import java.sql.Date;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import com.omas.webapp.entity.ClubRequest;
import com.omas.webapp.service.ClubService;
import com.omas.webapp.table.Club;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/new")
    public ResponseEntity<?> newClub(@Valid @RequestBody ClubRequest club) {

        Club createdClub = clubService
                .registerClub(new Club(club.getClubName(), new Date(Instant.now().toEpochMilli())));
        if (createdClub != null) {
            return new ResponseEntity<>(createdClub, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("the club name: " + club.getClubName() + "  is already taken.",
                HttpStatus.BAD_REQUEST);

    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("auth/club/{name}")
    public ResponseEntity<?> newClub(@PathVariable String name) {
        try {
            return new ResponseEntity<>(clubService.getClub(name), HttpStatus.FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("No club found", HttpStatus.BAD_REQUEST);
        }

    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return errors;
    }
}