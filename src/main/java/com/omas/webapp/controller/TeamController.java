package com.omas.webapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.omas.webapp.entity.requests.CompetitionIdRequest;
import com.omas.webapp.entity.requests.TeamScoreRequest;
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




        if(!competitionService.thisCompetitionExists(request.getCompetitionName())){
            return new ResponseEntity<>(Map.of("error","This competition does not exist"), HttpStatus.BAD_REQUEST);
        }
        
        try {
            Team addedTeam = teamService.addTeam(request.getCompetitionName(), request.getTeamName());
            return new ResponseEntity<>(addedTeam, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("error",e.getMessage()), HttpStatus.BAD_REQUEST);

        }        


    }

    
    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/teamExists")
    public ResponseEntity<?> hasTeam(@Valid @RequestBody CompetitionIdRequest request) {



            Boolean value = teamService.isTeamPartOfCompetition( request.getCompetitionName(), request.getTeamName());
            return new ResponseEntity<>(value, HttpStatus.OK);
    }

    @GetMapping(params = { "competition, team" }, value = "/")
    public ResponseEntity<?> getTeam(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "team") String teamName,
            @RequestParam(value = "competition") String competition) throws Exception {

        try {
            Team team = teamService.getTeam(competition, teamName);

            return new ResponseEntity<>(team, HttpStatus.OK);

        } catch (Exception  e) {
            return new ResponseEntity<>(
                    Map.of("error", "No team found with the given parameters"), HttpStatus.OK);
        }

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
