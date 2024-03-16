package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;
import com.omas.webapp.entity.response.MessageResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.omas.webapp.entity.requests.PasswordRecoveryRequest;
import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.entity.requests.PasswordResetRequest;
import com.omas.webapp.service.JwtService;
import com.omas.webapp.service.MailService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import net.bytebuddy.utility.RandomString;

@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private MailService mailService;

    @Value("${frontend.RecoveryPage}")
	private String recoveryPage; 

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

    @PostMapping("/forgot_password")
    public ResponseEntity<?> processForgotPassword(@Valid @RequestBody PasswordRecoveryRequest reqRequest) {

        String email = reqRequest.getEmail();
        String token = RandomString.make(30);

        try {
            service.updateResetPasswordToken(token, email);
            String resetPasswordLink = recoveryPage +"?token="+ token;
            mailService.sendRecoveryEmail(email, resetPasswordLink);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", "email not sent, " + e.getMessage()),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(Map.of("message", "email sent"), HttpStatus.OK);
    }



    @PostMapping("/reset_password")
    public ResponseEntity<?> processResetPassword(HttpServletRequest request, PasswordResetRequest resetRequest) {

        User user = service.getByResetPasswordToken(resetRequest.getToken());

        if (user == null) {
            return new ResponseEntity<>(Map.of("message", "Token is either invalid or expired"), HttpStatus.BAD_REQUEST);
        } else {
            service.updatePassword(user, resetRequest.getPassword());
            return new ResponseEntity<>(Map.of("message", "password updated"), HttpStatus.OK);
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