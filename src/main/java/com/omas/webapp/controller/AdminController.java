package com.omas.webapp.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.service.RoleService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.User;

@RestController
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @GetMapping(params = { "page", "size", "search" }, value = "user/query")
    public ResponseEntity<?> queryUsers(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        if (page < 0) {
            return new MessageResponse("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (search == null && search.isBlank()) {
            search = "";
        }

        Page<User> resultPage = userService.findWithPaginatedSearch(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);

    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/promote")
    public ResponseEntity<?> promote(@RequestBody String role, Long userId) {
        // TODO: Implement this method.
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/demote")
    public ResponseEntity<?> demote(@RequestBody String role, Long userId) {
        // TODO: Implement this method.
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/addScores")
    public ResponseEntity<?> addScores(@RequestBody TeamMemberId id) {
        // TODO: Implement this method.
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/removeScores")
    public ResponseEntity<?> removeScores(@RequestBody TeamMemberId id) {
        // TODO: Implement this method.
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteUser(@RequestBody String username) {

        UserInfoDetails details = UserInfoDetails.getDetails();

        Optional<User> userOptional = userService.getUserByUsername(username);

        if (userOptional.isEmpty()) {
            return new MessageResponse("No user found with that name", HttpStatus.BAD_REQUEST);
        }

        User user = userOptional.get();

        // Prevent admin from deleting themselves
        if (details.getId().equals(user.getId())) {
            return new MessageResponse("You cannot delete yourself", HttpStatus.BAD_REQUEST);
        }

        // Prevent deleting other admins
        if (roleService.FindUsersRoles(user.getId()).contains("ROLE_ADMIN")) {
            return new MessageResponse("You cannot delete other admins", HttpStatus.BAD_REQUEST);
        }

        userService.deleteUser(user.getId());

        return new MessageResponse("User deleted", HttpStatus.OK);
    }

}
