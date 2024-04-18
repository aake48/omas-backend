package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import com.omas.webapp.entity.requests.AdminAddScoreRequest;
import com.omas.webapp.entity.requests.DeleteRequest;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.omas.webapp.service.RoleService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.Role;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.User;
import com.omas.webapp.entity.requests.PromoteDemoteRoleRequest;

import jakarta.validation.Valid;

@RestController
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private TeamMemberScoreService teamMemberScoreService;

    @GetMapping(params = { "page", "size", "search" }, value = "user/query")
    public ResponseEntity<?> queryUsers(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size,
        @RequestParam(value = "search", required = false) String search
    ) throws Exception {

        if (page < 0) {
            return new ResponseEntity<>("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (search == null || search.isBlank()) {
            search = "";
        }

        Page<User> resultPage = userService.findWithPaginatedSearch(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message", "Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);

    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/promote")
    public ResponseEntity<?> promote(@Valid @RequestBody PromoteDemoteRoleRequest request) {

        if (!userService.userExists(request.getUserId())) {
            return new ResponseEntity<>((Map.of("message", "There is no user with the given userId")), HttpStatus.BAD_REQUEST);
        }

        Role role = roleService.addRole(request.getUserId(), request.getRole());

        return new ResponseEntity<>(role, HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/demote")
    public ResponseEntity<?> demote(@Valid @RequestBody PromoteDemoteRoleRequest request) {

        Long id = UserInfoDetails.getDetails().getId();

        if (!userService.userExists(request.getUserId())) {
            return new ResponseEntity<>((Map.of("message", "There is no user with the given userId")), HttpStatus.BAD_REQUEST);
        }

        if (request.getUserId() == id) {
            return new ResponseEntity<>("You may not demote yourself", HttpStatus.BAD_REQUEST);
        }

        if (request.getRole().equals("ROLE_ADMIN")) {
            return new ResponseEntity<>(Map.of("message","You may not demote admin roles"), HttpStatus.BAD_REQUEST);
        }

        if (!roleService.hasRole(request.getUserId(), request.getRole())) {
            return new ResponseEntity<>(Map.of("message","Cannot delete nonexistent role"), HttpStatus.BAD_REQUEST);
        }
        
        roleService.removeRole(request.getUserId(), request.getRole());

        return new ResponseEntity<>(Map.of("message","Role: " + request.getRole() + " removed from user: " + request.getUserId()), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/addScores")
    public ResponseEntity<?> addScores(@RequestBody AdminAddScoreRequest request) {

        TeamMemberId teamMemberId = new TeamMemberId(request.getUserId(), request.getCompetitionName(), request.getTeamName());

        TeamMemberScore score = teamMemberScoreService.modifyScoreSum(
            teamMemberId, request.getBullsEyeCount(), request.getScore(), request.getRequestType()
        );

        return new ResponseEntity<>(score, HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/removeScores")
    public ResponseEntity<?> removeScores(@RequestBody TeamMemberId id) {

        if (teamMemberScoreService.removeScore(id)) {
            return new ResponseEntity<>(Map.of("message","Score removed"), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(Map.of("message","No score found"), HttpStatus.OK);
        }

    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteUser(@RequestBody DeleteRequest deleteRequest) {

        UserInfoDetails details = UserInfoDetails.getDetails();

        Optional<User> userOptional = userService.getUserByUserId(deleteRequest.getUserId());

        if (userOptional.isEmpty()) {
            return new ResponseEntity<>(Map.of("message","No user found with that name"), HttpStatus.BAD_REQUEST);
        }

        User user = userOptional.get();

        // Prevent admin from deleting themselves
        if (details.getId().equals(user.getId())) {
            return new ResponseEntity<>(Map.of("message","You cannot delete yourself"), HttpStatus.BAD_REQUEST);
        }

        // Prevent deleting other admins
        if (roleService.findUsersRoles(user.getId()).contains("ROLE_ADMIN")) {
            return new ResponseEntity<>(Map.of("message","You cannot delete other admins"), HttpStatus.BAD_REQUEST);
        }

        roleService.removeRoles(user.getId());
        userService.deleteUser(user.getId());

        return new ResponseEntity<>(Map.of("message","User deleted"), HttpStatus.OK);
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
