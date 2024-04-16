package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import com.omas.webapp.entity.requests.AddTeamMemberScoreAsSumRequest;
import com.omas.webapp.entity.requests.TeamMemberJoinRequest;
import com.omas.webapp.entity.requests.TeamMemberScoreRequest;
import com.omas.webapp.entity.requests.AdminAddScoreRequest;
import com.omas.webapp.entity.requests.TeamIdRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
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

        Long userId = UserInfoDetails.getDetails().getId();

        if (teamsService.isUserParticipatingInThisCompetition(userId, request.getCompetitionName())) {
            return new ResponseEntity<>("You are already in a team in this competition.", HttpStatus.BAD_REQUEST);
        }

        if (teamsService.isThisTeamFull(request.getCompetitionName(), request.getTeamName())){
            return new ResponseEntity<>("The team is full.", HttpStatus.BAD_REQUEST);
        }

        Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

        if (competitionOptional.isEmpty()) {
            return new ResponseEntity<>("The requested competition does not exist.", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (competition.hasEnded()) {
            return new ResponseEntity<>("The requested competition has ended.", HttpStatus.BAD_REQUEST);
        }

        try {
            TeamMember savedTeamMember = teamsService.addTeamMember(new TeamMemberId(userId, request.getCompetitionName(), request.getTeamName()));
            return new ResponseEntity<>(savedTeamMember, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/isMember")
    public ResponseEntity<?> isMember(@Valid @RequestBody TeamIdRequest request) {

        long userId = UserInfoDetails.getDetails().getId();

        TeamMemberId teamMemberId = new TeamMemberId(userId, request.getCompetitionName(), request.getTeamName());

        boolean isMember = teamsService.thisUserIsTeamMember(teamMemberId);

        return new ResponseEntity<>(isMember, HttpStatus.OK);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScore(@Valid @RequestBody TeamMemberScoreRequest request) {
        
        TeamMemberScore score = teamMemberScoreService.getUsersScore(request.getUserId(), request.getCompetitionName());
        if (score != null) {
            return new ResponseEntity<>(score, HttpStatus.OK);
        }

        return new ResponseEntity<>("No score found", HttpStatus.OK);
    }

    /**
     * As admin of the team's club, Adds the sum of scores for a team member.
     * Uses teamService.isAdminInClub() to validate that the user has privileges to administer teams of this club
     * @param request the request object containing the necessary information for adding scores
     * @return a ResponseEntity containing the added team member score if successful, or an error message if unsuccessful
     */
    @PreAuthorize("@teamService.isAdminInclub(#request.clubName)")
    @PostMapping("/score/add/sum/admin")
    public ResponseEntity<?> addScoresSumAdmin(@Valid @RequestBody AdminAddScoreRequest request) {

        try {

            Optional<Team> optionalTeam = teamsService
                    .getTeam(new TeamId(request.getCompetitionName(), request.getTeamName()));
            String club = null;
            if (optionalTeam.isPresent()) {
                Team team = optionalTeam.get();
                club = team.getClubName();
            }

            if (club == null || !club.equals(request.getClubName())) {
                throw new Exception("this team belongs to another team");
            }

            Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

            if (competitionOptional.isEmpty()) {
                return new ResponseEntity<>("The requested competition does not exist", HttpStatus.BAD_REQUEST);
            }

            Competition competition = competitionOptional.get();

            if (!competition.isActive()) {
                return new ResponseEntity<>("The requested competition is not active.", HttpStatus.BAD_REQUEST);
            }

            TeamMemberId teamMemberId = teamsService.canUserSubmitScores(request.getUserId(),
                    request.getCompetitionName(),
                    request.getTeamName());

            TeamMemberScore score = teamMemberScoreService.modifyScoreSum(
                teamMemberId, request.getBullsEyeCount(), request.getScore(), request.getRequestType()
            );

            return new ResponseEntity<>(score, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/score/add/sum")
    public ResponseEntity<?> addScoresSum(@Valid @RequestBody AddTeamMemberScoreAsSumRequest request) {

        Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

        if (competitionOptional.isEmpty()) {
            return new ResponseEntity<>("The requested competition does not exist", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (!competition.isActive()) {
            return new ResponseEntity<>("The requested competition is not active.", HttpStatus.BAD_REQUEST);
        }

        try {

            // Allow posting score for another team member by figuring out if the request contains a user id
            TeamMemberId teamMemberId = teamsService.resolveTeamMemberId(request.getUserId(), request.getCompetitionName(), request.getTeamName());

            TeamMemberScore score = teamMemberScoreService.modifyScoreSum(
                teamMemberId, request.getBullsEyeCount(), request.getScore(), request.getRequestType()
            );

            return new ResponseEntity<>(score, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(Exception.class)
    public String handleOtherExceptions(Exception ex) {
        ex.printStackTrace();
        return ex.getMessage();
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
