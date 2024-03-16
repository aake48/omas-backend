package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import com.omas.webapp.entity.response.MessageResponse;
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
import com.omas.webapp.Constants;
import com.omas.webapp.entity.requests.AddTeamMemberScoreRequest;
import com.omas.webapp.entity.requests.TeamMemberJoinRequest;
import com.omas.webapp.entity.requests.TeamMemberScoreRequest;
import com.omas.webapp.entity.requests.teamIdRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.Competition;
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
    TeamMemberScoreService teamMemberScoreService;

    @Autowired 
    CompetitionService competitionService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/add")
    public ResponseEntity<?> addUserToTeam(@Valid @RequestBody TeamMemberJoinRequest request) {

        UserInfoDetails userDetails = UserInfoDetails.getDetails();

        Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

        if (competitionOptional.isEmpty()) {
            return new MessageResponse("The requested competition does not exist.", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (competition.hasEnded()) {
            return new MessageResponse("The requested competition has ended.", HttpStatus.FORBIDDEN);
        }

        try {
            TeamMember savedTeamMember = teamsService.addTeamMember(new TeamMemberId(userDetails.getId(), request.getCompetitionName(), request.getTeamName()));
            return new ResponseEntity<>(savedTeamMember, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/isMember")
    public ResponseEntity<?> isMember(@Valid @RequestBody teamIdRequest request) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();

        try {
            teamsService.CanUserSubmitScores(userDetails, request.getCompetitionName(), request.getTeamName());
            return new ResponseEntity<>(true, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(false, HttpStatus.OK);
        }

    }


    @GetMapping("/score")
    public ResponseEntity<?> getScore(@Valid @RequestBody TeamMemberScoreRequest request) {
        
        TeamMemberScore score = teamMemberScoreService.getUsersScore(request.getUserId(), request.getCompetitionName());
        if(score!=null){
            return new ResponseEntity<>(score, HttpStatus.OK);
        }

        return new MessageResponse("No score found", HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/score/add")
    public ResponseEntity<?> addScores(@Valid @RequestBody AddTeamMemberScoreRequest request) {

        Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

        if (competitionOptional.isEmpty()) {
            return new MessageResponse("The requested competition does not exist", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (competition.hasEnded()) {
            return new MessageResponse("The requested competition has ended.", HttpStatus.FORBIDDEN);
        }

        try {

            UserInfoDetails userDetails = UserInfoDetails.getDetails();

            // validates that user is part of the team and that the team has entered this
            // competition
            TeamMemberId teamMemberId = teamsService.CanUserSubmitScores(userDetails, request.getCompetitionName(), request.getTeamName());

            String type = competition.getType();
            TeamMemberScore score;
            switch (type) {
                case Constants.rifleType -> {
                    score = teamMemberScoreService.addRifleScore(teamMemberId, request.getScoreList());
                }
                case Constants.pistolType -> {
                    score = teamMemberScoreService.addPistolScore(teamMemberId, request.getScoreList());
                }
                default -> throw new Exception("Invalid competition type");
            }
            // if the scores already exist in the DB, they will be overwritten
            return new ResponseEntity<>(score, HttpStatus.OK);
        } catch (Exception e) {
            return new MessageResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
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
