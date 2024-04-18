package com.omas.webapp.controller;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.*;
import com.omas.webapp.service.*;
import com.omas.webapp.table.Team;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
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
import com.omas.webapp.entity.requests.UpdateEmailRequest;
import com.omas.webapp.entity.requests.UpdatePasswordRequest;
import com.omas.webapp.entity.requests.PasswordResetRequest;
import com.omas.webapp.table.User;
import jakarta.servlet.http.HttpServletRequest;
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

    @Autowired
    private MailService mailService;

    @Autowired
    private TeamService teamService;

    @Autowired
    private LoginAttemptService loginAttemptService;

    @Autowired
    private HttpServletRequest request;

    @Value("${frontend.RecoveryPage}")
    private String recoveryPage;

    @PostMapping("/reg")
    public ResponseEntity<?> addNewUser(@Valid @RequestBody RegistrationRequest request) {

        try {
            service.registerUser(request);
            return new ResponseEntity<>(Map.of("message","User added"), HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message",e.getMessage()), HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping("/updatePassword")
    @PreAuthorize("hasAuthority('ROLE_USER')")
    public ResponseEntity<?> updatePassword(@Valid @RequestBody UpdatePasswordRequest request) {

        UserInfoDetails userInfo = UserInfoDetails.getDetails();

        try {
            // authenticate throws an exception if it fails to authenticate user
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(userInfo.getUsername(), request.getOldPassword()));

            service.changePassword(userInfo.getId(), request.getNewPassword());
            return new ResponseEntity<>(Map.of("message","password was updated!"), HttpStatus.OK);

        } catch (BadCredentialsException e) {
            return new ResponseEntity<>(Map.of("message","password was not updated! Bad credentials"), HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","password was not updated!"), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/updateEmail")
    @PreAuthorize("hasAuthority('ROLE_USER')")
    public ResponseEntity<?> updateEmail(@Valid @RequestBody UpdateEmailRequest request) {

        UserInfoDetails userInfo = UserInfoDetails.getDetails();

        try {
            // authenticate throws an exception if it fails to authenticate user
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(userInfo.getUsername(), request.getPassword()));

            service.changeEmail(userInfo.getId(), request.getEmail());
            return new ResponseEntity<>(Map.of("message","Email was updated!"), HttpStatus.OK);

        } catch (BadCredentialsException e) {
            return new ResponseEntity<>(Map.of("message","Email was not updated! Bad credentials"), HttpStatus.BAD_REQUEST);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","Email was not updated!"), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping(value = "/login")
    public ResponseEntity<?> authenticateAndGetToken(@Valid @RequestBody AuthRequest authRequest) {

        if (loginAttemptService.isBlocked()) {
            return new ResponseEntity<>("Too many failed login attempts", HttpStatus.FORBIDDEN);
        }

        try {
            //authenticate throws an exception if it fails to authenticate user
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
                    UserInfoDetails userInfo = (UserInfoDetails) authentication.getPrincipal();

            String token = jwtService.generateToken(authRequest.getUsername(), userInfo.getId());
            UserInfoDetails userDetails = service.loadUserByUsername(authRequest.getUsername());

            ObjectMapper mapper = new ObjectMapper();
            ObjectNode user = mapper.createObjectNode()
                    .put("username", userDetails.getUsername())
                    .put("legalName", userDetails.getLegalName())
                    .put("email", userDetails.getEmail())
                    .put("userId", userDetails.getId())
                    .put("roles", userDetails.getAuthorities().toString())
                    .put("creationDate", userDetails.getCreationDate().toString())
                    .put("club", userDetails.getPartOfClub());

            ObjectNode root = mapper.createObjectNode();
            root.set("user", user);
            root.put("token", token);
            String jsonString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(root);

            // Reset login attempts on successful login
            loginAttemptService.clearCache();

            return new ResponseEntity<>(jsonString, HttpStatus.OK);

        } catch (AuthenticationException e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.FORBIDDEN);
        } catch (JsonProcessingException e) {
            return new ResponseEntity<>(Map.of("error", e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/forgot_password")
    public ResponseEntity<?> processForgotPassword(@Valid @RequestBody PasswordRecoveryRequest reqRequest) {

        String email = reqRequest.getEmail();

        SecureRandom random = new SecureRandom();
        String token = new BigInteger(130, random).toString(32);
        token = URLEncoder.encode(token, StandardCharsets.UTF_8);

        try {
            service.updateResetPasswordToken(token, email);
            String resetPasswordLink = recoveryPage + "?token=" + token;
            mailService.sendRecoveryEmail(email, resetPasswordLink);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","Email not sent, " + e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>(Map.of("message","Email sent"), HttpStatus.OK);
    }

    @PostMapping("/reset_password")
    public ResponseEntity<?> processResetPassword(HttpServletRequest request,
            @Valid PasswordResetRequest resetRequest) {

        User user = service.getByResetPasswordToken(resetRequest.getToken());

        if (user == null) {
            return new ResponseEntity<>(Map.of("message","Token is either invalid or expired"), HttpStatus.BAD_REQUEST);
        }

        service.updatePassword(user, resetRequest.getPassword());

        return new ResponseEntity<>(Map.of("message","Password updated"), HttpStatus.OK);
    }
    

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/user/team")
    public ResponseEntity<?> getUserTeam(@RequestParam(name = "competitionId") String competitionId) {

        Long userId = UserInfoDetails.getDetails().getId();

        Optional<Team> teamOptional = teamService.getUserTeam(userId, competitionId);

        if (teamOptional.isEmpty()) {
            return new ResponseEntity<>(Map.of("message","That user is not in a team in that competition"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(teamOptional.get(), HttpStatus.OK);
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