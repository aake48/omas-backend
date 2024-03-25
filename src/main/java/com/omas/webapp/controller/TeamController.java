package com.omas.webapp.controller;

import com.omas.webapp.Util;
import com.omas.webapp.entity.requests.AddTeamRequest;
import com.omas.webapp.entity.requests.TeamScoreRequest;
import com.omas.webapp.entity.requests.teamIdRequest;
import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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

        String club = UserInfoDetails.getDetails().getPartOfClub();

        if(club==null){
            return new ResponseEntity<>(Map.of("messsage", "user creating a team needs to be in a club"), HttpStatus.BAD_REQUEST);
        }

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

            Team addedTeam = teamService.addTeam(request.getCompetitionName(), teamName, teamDisplayName, club);
            return new ResponseEntity<>(addedTeam, HttpStatus.OK);

        } catch (Exception e) {
            return new MessageResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    @GetMapping(params = { "page", "size", "search" }, value = "/query")
    public ResponseEntity<?> queryTeamsByClub(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        if (page < 0) {
            return new MessageResponse("Invalid page number.", HttpStatus.BAD_REQUEST);
        }

        if (search == null || search.isBlank()) {
            search = "";
        }

        Page<Team> resultPage = teamService.findWithPaginatedsearchByClub(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    
    @GetMapping("/teamExists")
    public ResponseEntity<?> hasTeam(@Valid @RequestBody teamIdRequest request) {

        Boolean value = teamService.isTeamPartOfCompetition(request.getCompetitionName(), request.getTeamName());
        return new ResponseEntity<>(value, HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<?> getTeam(
        @RequestParam(name = "team") String team,
        @RequestParam(name = "competition") String competition
    ) {

        String teamName = Util.sanitizeName(team);
        String competitionId = Util.sanitizeName(competition);

        // Sanity check even though it should theoretically be safe already
        if (teamName == null) {
            return new MessageResponse("Team name contains illegal characters. It must match ^[a-zA-Z0-9-_]+$ after sanitation", HttpStatus.BAD_REQUEST);
        }

        // Sanity check even though it should theoretically be safe already
        if (competitionId == null) {
            return new MessageResponse("Competition name contains illegal characters. It must match ^[a-zA-Z0-9-_]+$ after sanitation", HttpStatus.BAD_REQUEST);
        }

        Optional<Team> teamOptional = teamService.getTeam(competitionId, teamName);

        if (teamOptional.isEmpty()) {
            return new MessageResponse("No team found with the given parameters.", HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(teamOptional.get(), HttpStatus.OK);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@Valid @RequestBody TeamScoreRequest request) {

        if (!teamService.isTeamPartOfCompetition( request.getCompetitionName(), request.getTeamName())){
            return new MessageResponse("No team found.", HttpStatus.OK);
        }

        List<TeamMemberScore> scores = scoreService.getTeamScores(new TeamId(request.getCompetitionName(), request.getTeamName()));

        // Notify client if there are no scores for this team id
        if (scores == null || scores.isEmpty()) {
            return new MessageResponse("This team has not yet submitted any scores.", HttpStatus.OK);
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
