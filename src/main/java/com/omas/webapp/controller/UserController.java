package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;

import com.omas.webapp.entity.response.MessageResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.omas.webapp.entity.requests.AuthRequest;
import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.service.JwtService;
import com.omas.webapp.service.UserInfoDetails;
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
    public ResponseEntity<?> addNewUser(@Valid @RequestBody RegistrationRequest request) {

        if (service.registerUser(request)) {
            return new MessageResponse("User added", HttpStatus.OK);
        } else {
            return new MessageResponse("Username has already been taken.", HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping(value = "/login")
    public ResponseEntity<?> authenticateAndGetToken(@Valid @RequestBody AuthRequest authRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
            String token = jwtService.generateToken(authRequest.getUsername());
            UserInfoDetails userDetails = service.loadUserByUsername(authRequest.getUsername());

            ObjectMapper mapper = new ObjectMapper();
            ObjectNode user = mapper.createObjectNode()
                    .put("username", userDetails.getUsername())
                    .put("legalName", userDetails.getLegalName())
                    .put("email", userDetails.getEmail())
                    .put("userId", userDetails.getId())
                    .put("authorities", userDetails.getAuthorities().toString())
                    .put("creationDate", userDetails.getCreationDate().toString())
                    .put("club", userDetails.getPartOfClub());

            ObjectNode root = mapper.createObjectNode();
            root.set("user", user);
            root.put("token", token);
            String jsonString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(root);

            return new ResponseEntity<>(jsonString, HttpStatus.OK);

        } catch (AuthenticationException e) {
            return new MessageResponse(e.getMessage(), HttpStatus.FORBIDDEN);
        } catch (JsonProcessingException e) {
            return new MessageResponse(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
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