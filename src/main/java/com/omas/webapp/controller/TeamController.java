package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.table.Competition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import com.omas.webapp.entity.requests.AddTeamRequest;
import com.omas.webapp.entity.requests.TeamScoreRequest;
import com.omas.webapp.entity.requests.teamIdRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/competition/team")
public class TeamController {

    @Autowired
    TeamService teamService;

    @Autowired
    TeamMemberScoreService scoreService;

    @Autowired 
    CompetitionService competitionService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/new")
    public ResponseEntity<?> addTeam(@Valid @RequestBody AddTeamRequest request) {

        Optional<Competition> competitionOptional = competitionService.getCompetition(request.getCompetitionName());

        // Handles prior thisCompetitionExists check
        if (competitionOptional.isEmpty()) {
            return new MessageResponse("This competition does not exist", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (competition.hasEnded()) {
            return new MessageResponse("This competition has ended", HttpStatus.FORBIDDEN);
        }

        // This section of the code performs two operations on the 'Id', teamName:
        // 1. It removes whitespaces and characters 'ä', 'ö', 'å' from the 'Id'.
        // 2. It stores the original, unaltered version of 'Id' into 'nameNonId'.
        // If 'Id' still contains unsafe characters after these alterations, the code
        // returns a 400 status.
        String teamDisplayName = request.getTeamName();
        String teamName = request.getTeamName()
                .replace('ä', 'a').replace('Ä', 'A')
                .replace('ö', 'o').replace('Ö', 'O')
                .replace('å', 'a').replace('Å', 'A')
                .replace(' ', '_');

        String regex = "^[a-zA-Z0-9-_]+$";

        if (!teamName.matches(regex)) {
            return new MessageResponse("Team name contains illegal characters. It must match ^[a-zA-Z0-9-_]+$", HttpStatus.BAD_REQUEST);
        }
        
        try {

            Team addedTeam = teamService.addTeam(request.getCompetitionName(), teamName, teamDisplayName);
            return new ResponseEntity<>(addedTeam, HttpStatus.OK);

        } catch (Exception e) {
            return new MessageResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    
    //@PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/teamExists")
    public ResponseEntity<?> hasTeam(@Valid @RequestBody teamIdRequest request) {

        Boolean value = teamService.isTeamPartOfCompetition(request.getCompetitionName(), request.getTeamName());
        return new ResponseEntity<>(value, HttpStatus.OK);
    }

    @GetMapping(params = { "competition, team" }, value = "/")
    public ResponseEntity<?> getTeam(
            @RequestParam(value = "team") String teamName,
            @RequestParam(value = "competition") String competition
    ) {

        Optional<Team> teamOptional = teamService.getTeam(teamName, competition);

        if (teamOptional.isEmpty()) {
            return new MessageResponse("No team found with the given parameters", HttpStatus.OK);
        }

        return new ResponseEntity<>(teamOptional.get(), HttpStatus.OK);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@Valid @RequestBody TeamScoreRequest request) {


        if(!teamService.isTeamPartOfCompetition( request.getCompetitionName(), request.getTeamName())){
            return new ResponseEntity<>(Map.of("error", "No team found"), HttpStatus.OK);
        }
        List<TeamMemberScore> scores = scoreService.getTeamScores(new TeamId(request.getCompetitionName(), request.getTeamName()));

        // Notify client if there are no scores for this team id
        if (scores == null || scores.isEmpty()) {
            return new ResponseEntity<>(Map.of("messge","This team has not yet any submitted scores"), HttpStatus.OK);
        }

        return new ResponseEntity<>(scores, HttpStatus.OK);
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
