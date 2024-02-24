package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import com.omas.webapp.entity.AuthRequest;
import com.omas.webapp.entity.RegistrationRequest;
import com.omas.webapp.service.JwtService;
import com.omas.webapp.service.UserService;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @PostMapping("/reg")
    public ResponseEntity<Map<String, String>> addNewUser(@Valid @RequestBody RegistrationRequest request) {

        if (service.registerUser(request)) {
            return new ResponseEntity<>(Map.of("message", "user added"), HttpStatus.ACCEPTED);
        } else {
            return new ResponseEntity<>(Map.of("message", "Username has already been taken."), HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping(value = "/login")
    public ResponseEntity<Map<String, String>> authenticateAndGetToken(@Valid @RequestBody AuthRequest authRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
            String token = jwtService.generateToken(authRequest.getUsername());
            return new ResponseEntity<>(Map.of("token", token), HttpStatus.ACCEPTED);
        } catch (AuthenticationException e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.FORBIDDEN);
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