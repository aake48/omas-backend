package com.omas.webapp.controller;

import com.omas.webapp.entity.requests.AddCompetitionRequest;
import com.omas.webapp.entity.response.*;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;
import jakarta.validation.Valid;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Log4j2
@RestController
@RequestMapping("/api")
public class CompetitionController {

    @Autowired
    CompetitionService competitionService;

    @Autowired
    TeamService teamService;

    @Autowired
    TeamMemberScoreService teamMemberScoreService;

    @Autowired
    UserService userService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/competition/new")
    public ResponseEntity<?> addCompetition(@Valid @RequestBody AddCompetitionRequest competitionRequest) {

        

        // This section of the code performs two operations on the 'Id',
        // competitionName:
        // 1. It removes whitespaces and characters 'ä', 'ö', 'å' from the 'Id'.
        // 2. It stores the original, unaltered version of 'Id' into 'nameNonId'.
        // If 'Id' still contains unsafe characters after these alterations, the code
        // returns a 400 status.
        String nonIdName = competitionRequest.getCompetitionName();
        String competitionName = competitionRequest.getCompetitionName()
                .replace('ä', 'a').replace('Ä', 'A')
                .replace('ö', 'o').replace('Ö', 'O')
                .replace('å', 'a').replace('Å', 'A')
                .replace(' ', '_');

        String regex = "^[a-zA-Z0-9-_]+$";
        if (!competitionName.matches(regex)) {
            return new MessageResponse("Competition name contains characters which are forbidden.", HttpStatus.BAD_REQUEST);
        }

        Competition comp = competitionService.addCompetition(
                new Competition(competitionName, 
                nonIdName, 
                competitionRequest.getCompetitionType()
                ,competitionRequest.getStartDate()
                ,competitionRequest.getEndDate()));
        if (comp != null) {
            return new ResponseEntity<>(comp, HttpStatus.CREATED);
        }

        return new MessageResponse("Competition name has already been taken", HttpStatus.BAD_REQUEST);
    }

    @GetMapping(params = { "page", "size", "search" }, value = "competition/query")
    public ResponseEntity<?> queryCompetitions(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        if (page < 0) {
            return new MessageResponse("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (search != null && !search.isBlank()) {
            Page<Competition> resultPage = competitionService.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        Page<Competition> resultPage = competitionService.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping(params = { "page", "size", "year" }, value = "competition/query")
    public ResponseEntity<?> queryCompetitionByYear(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "year", required = true) int year) {

        if (page < 0) {
            return new MessageResponse("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (year > 1990 && year < 2100) {
            Page<Competition> resultPage = competitionService.findByYear(page, size, year);

            if (page > resultPage.getTotalPages()) {
                return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        return new MessageResponse("Invalid year.", HttpStatus.BAD_REQUEST);
    }

    @GetMapping(params = { "page", "size", "search" }, value = "competition/teams")
    public ResponseEntity<?> queryTeamsByCompetition(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size,
        @RequestParam(value = "search", required = false) String search
    ) {

        if (page < 0) {
            return new MessageResponse("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (search == null || search.isBlank()) {
            search = "";
        }

        Page<Team> resultPage = teamService.findWithPaginatedSearchByCompetitionId(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("competition/{name}")
    public ResponseEntity<?> getCompetition(@PathVariable String name) {
        try {
            return new ResponseEntity<>(competitionService.getCompetition(name), HttpStatus.OK);
        } catch (Exception e) {
            return new MessageResponse("No competition found with the given name.", HttpStatus.BAD_REQUEST);
        }
    }


    /**
     * Retrieves the results for a specific competition. The competitionResults are
     * sorted into descending order by totalScore.
     *
     * @param name The name of the competition.
     * @return ResponseEntity containing the JSON representation of the competition
     *         results.
     *         Returns HttpStatus.OK if successful, HttpStatus.INTERNAL_SERVER_ERROR
     *         if there is an error processing the JSON,
     *         or HttpStatus.BAD_REQUEST if no competition is found with the given
     *         name.
     */
    
    @GetMapping(value = "/competition/result/{name}", produces = "application/json")
    public ResponseEntity<?> getResultsForCompetition(@PathVariable String name) {

        Optional<Competition> competitionOptional = competitionService.getCompetition(name);

        if (competitionOptional.isEmpty()) {
            return new MessageResponse("No competition found with the given name", HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();
        CompetitionResponse competitionResponse = new CompetitionResponse(competition);
        List<Team> teams = teamService.getTeamsParticipatingInCompetition(name);

        for (Team team : teams) {

            List<TeamMemberScore> scores = teamMemberScoreService.getTeamScores(new TeamId(team.getCompetitionId(), team.getTeamName()));
            List<TeamMemberScoreResponse> scoreResponses = new ArrayList<>(scores.size());

            for (TeamMemberScore score : scores) {
                scoreResponses.add(new TeamMemberScoreResponse(score,  userService.getName(score.getUserId())));
            }

            // Sort the scores in descending order
            Collections.sort(scoreResponses);

            // The score sum is calculated in the CompetitionTeamResponse constructor so there is no need to calculate it here
            competitionResponse.addTeam(new CompetitionTeamResponse(team.getTeamName(), team.getTeamDisplayName(), scoreResponses));
        }

        // Sort the teams in descending order
        Collections.sort(competitionResponse.getTeams());

        return new ResponseEntity<>(competitionResponse, HttpStatus.OK);
    }

    @GetMapping("competition/all")
    public List<Competition> getCompetitions() {
        return competitionService.getAllCompetitions();
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