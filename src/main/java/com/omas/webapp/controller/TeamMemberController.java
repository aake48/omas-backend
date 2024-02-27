package com.omas.webapp.controller;

import java.util.HashMap;
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
import com.omas.webapp.entity.TeamMemberScoreRequest;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberScore;

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

    // not implemented yet
    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("competition/team/member/add")
    public ResponseEntity<?> addYourselfToThisTeam(String competitionName) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();

        TeamMember savedTeamMember;
        String club = userDetails.getPartOfClub();
        try {
            savedTeamMember = teamsService.addTeamMember(new TeamMemberId(userDetails.getId(), competitionName, club));

        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(savedTeamMember, HttpStatus.OK);
    }

    // not implemented
    @GetMapping("/score")
    public ResponseEntity<?> getScore(@RequestBody TeamMemberScoreRequest request) {
        // return ScoreService.getTeamMemberScore(request);
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping
    public ResponseEntity<?> addScores(@RequestBody AddTeamMemberScoreRequest request) {

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
