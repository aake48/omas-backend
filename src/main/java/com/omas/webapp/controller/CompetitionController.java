package com.omas.webapp.controller;

import com.omas.webapp.entity.CompetitionRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.table.Competition;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CompetitionController {

    @Autowired
    CompetitionService service;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/competition/new")
    public ResponseEntity<?> addCompetition(@Valid @RequestBody CompetitionRequest CompetitionRequest) {

        Competition comp = service.addCompetition(
                new Competition(CompetitionRequest.getCompetitionName(), new Date(Instant.now().toEpochMilli())));
        if (comp!=null) {
            return new ResponseEntity<>(comp, HttpStatus.CREATED);
        }

        return new ResponseEntity<>(Map.of("message","Competition name has already been taken"), HttpStatus.BAD_REQUEST);
    }


    @GetMapping(params = { "page", "size", "search" }, value = "competition/query")
    public ResponseEntity<?> queryCompetitions(@RequestParam("page") int page, @RequestParam("size") int size,
            @RequestParam("search") String search) throws Exception {

        if (!search.equals(null) || !search.isBlank()) {
            Page<Competition> resultPage = service.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        Page<Competition> resultPage = service.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>("{\"message\":\"Requested page does not exist.\"}", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("competition/{name}")
    public ResponseEntity<?> getCompetition(@PathVariable String name) {
        try {
            return new ResponseEntity<>(service.getCompetition(name), HttpStatus.FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","No competition found with the given name"), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("competition/all")
    public List<Competition> getCompetitions() {
        return service.getAllCompetitions();
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