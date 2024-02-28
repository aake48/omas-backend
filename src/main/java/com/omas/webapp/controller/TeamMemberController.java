package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import com.omas.webapp.entity.AddTeamMemberScoreRequest;
import com.omas.webapp.entity.CompetitionRequest;
import com.omas.webapp.entity.TeamMemberScoreRequest;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberScore;

import jakarta.validation.Valid;

import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api/competition/team/member")
public class TeamMemberController {

    @Autowired
    TeamService teamsService;

    @Autowired
    TeamMemberScoreService ScoreService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/add")
    public ResponseEntity<?> addYourselfToThisTeam(@Valid @RequestBody CompetitionRequest request) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();

        TeamMember savedTeamMember;
        String club = userDetails.getPartOfClub();
        try {
            savedTeamMember = teamsService.addTeamMember(new TeamMemberId(userDetails.getId(), club, request.getCompetitionName()));

        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(savedTeamMember, HttpStatus.OK);
    }

    // non final - does not work yet
    @GetMapping("/score")
    public ResponseEntity<?> getScore(@Valid @RequestBody TeamMemberScoreRequest request) {
        
        List<TeamMemberScore> score = ScoreService.getUsersScore(request.getUserId(), request.getCompetitionName());
        if(score!=null){
            return new ResponseEntity<>(score, HttpStatus.OK);
        }
        return new ResponseEntity<>(Map.of("message", "no score found"), HttpStatus.NOT_FOUND);

    }
    // non final - does not work yet
    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/score/add")
    public ResponseEntity<?> addScores(@Valid @RequestBody AddTeamMemberScoreRequest request) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();

        TeamMemberId teamMemberId;

        // validates that user is part of the team and that the team has entered this
        // competition;
        try {
            teamMemberId = teamsService.thisUserIsValidMember(userDetails, request.getCompetitionName());
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

        // if the score already exists in db, it will be overwritten
        TeamMemberScore score = ScoreService.addUsersScore(teamMemberId, request.getScoreList());

        return new ResponseEntity<>(score, HttpStatus.CREATED);
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
