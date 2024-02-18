package com.omas.webapp.controller;

import java.sql.Date;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import com.omas.webapp.entity.ClubRequest;
import com.omas.webapp.service.ClubService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.Club;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
public class ClubController {

    @Autowired
    private ClubService service;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/new")
    public ResponseEntity<?> newClub(@Valid @RequestBody ClubRequest club) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();

        Club createdClub = service
                .registerClub(
                        new Club(club.getClubName(), new Date(Instant.now().toEpochMilli()), userDetails.getId()));
        if (createdClub != null) {
            return new ResponseEntity<>(createdClub, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("{\"message\":\"Club name has already been taken.\"}",
                HttpStatus.BAD_REQUEST);

    }

    @GetMapping("club/{name}")
    public ResponseEntity<?> getClub(@PathVariable String name) {
        try {
            return new ResponseEntity<>(service.getClub(name), HttpStatus.FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("{\"message\":\"No club found with the given name.\"}", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("club/all")
    public ResponseEntity<List<Club>> getAll() {
            return new ResponseEntity<>(service.getall(), HttpStatus.FOUND);

    }

    @GetMapping(params = { "page", "size", "search" }, value = "club/query")
    public ResponseEntity<?> queryClubs(@RequestParam("page") int page, @RequestParam("size") int size,
            @RequestParam("search") String search) throws Exception {

        if (search.equals(null) || !search.isBlank()) {
            Page<Club> resultPage = service.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                return new ResponseEntity<>("{\"message\":\"Requested page does not exist.\"}",
                HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(resultPage,
            HttpStatus.OK);
        }

        Page<Club> resultPage = service.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>("{\"message\":\"Requested page does not exist.\"}",
            HttpStatus.BAD_REQUEST);

        }
        return new ResponseEntity<>(resultPage,
        HttpStatus.OK);
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