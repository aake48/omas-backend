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
import com.omas.webapp.service.JwtService;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.User;
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
    public ResponseEntity<String> addNewUser(@Valid @RequestBody User userInfo) {
        if (service.registerUser(userInfo)) {
            return new ResponseEntity<>("User added.", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("User not added.", HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping(value = "/login" ) 
    public ResponseEntity<String> authenticateAndGetToken(@Valid @RequestBody AuthRequest authRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
            String token = jwtService.generateToken(authRequest.getUsername());
            return new ResponseEntity<>(token, HttpStatus.OK);
        } catch (AuthenticationException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.FORBIDDEN);
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