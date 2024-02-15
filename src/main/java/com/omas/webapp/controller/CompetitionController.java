package com.omas.webapp.controller;

import java.sql.Date;
import java.time.Instant;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.omas.webapp.table.Competition;
import jakarta.validation.Valid;
import com.omas.webapp.entity.CompetitionRequest;
import com.omas.webapp.service.CompetitionService;

@RestController
@RequestMapping("/api/competition")
public class CompetitionController {

    @Autowired
    CompetitionService service;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/new")
    public ResponseEntity<?> addCompetition(@Valid @RequestBody CompetitionRequest CompetitionRequest) {

        Competition comp = service.addCompetition(
                new Competition(CompetitionRequest.getCompetitionName(), new Date(Instant.now().toEpochMilli())));
        if (comp.equals(null)) {
            return new ResponseEntity<>(comp, HttpStatus.CREATED);
        }
        return new ResponseEntity<>("the name: " + comp.getName() + "  is already taken.",
                HttpStatus.BAD_REQUEST);

    }

    @GetMapping(params = { "page", "size", "search" }, value = "/query")
    public Page<Competition> queryCompetitions(@RequestParam("page") int page, @RequestParam("size") int size,
            @RequestParam("search") String search) throws Exception {

        if (search.equals(null) || !search.isBlank()) {
            Page<Competition> resultPage = service.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                throw new Exception();
            }
            return resultPage;
        }

        Page<Competition> resultPage = service.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            throw new Exception();
        }
        return resultPage;
    }

    @GetMapping("/all")
    public List<Competition> getCompetitions() {
        return service.getAllCompetitions();
    }

}