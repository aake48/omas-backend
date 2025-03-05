package com.omas.webapp.controller;

import com.omas.webapp.Constants;
import com.omas.webapp.entity.requests.AddTeamRequest;
import com.omas.webapp.entity.requests.CompetitionNameRequest;
import com.omas.webapp.entity.requests.TeamScoreRequest;
import com.omas.webapp.entity.requests.TeamIdRequest;
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

        if (club == null) {
            return new ResponseEntity<>(Map.of("message","User creating a team needs to be in a club"), HttpStatus.BAD_REQUEST);
        }

        String teamDisplayName = request.getTeamName();
        String teamDisplayShort = request.getTeamDisplayShort();
        String teamName = Constants.createIdString(teamDisplayName);

        if (teamName == null) {
            return new ResponseEntity<>(Map.of("message","Team name contains illegal characters. It must match ^[a-z0-9-_]+$"), HttpStatus.BAD_REQUEST);
        }

        String competitionId = Constants.createIdString(request.getCompetitionName());

        if (competitionId == null) {
            return new ResponseEntity<>(Map.of("message", "Competition name contains illegal characters. It must match ^[a-z0-9-_]+$"), HttpStatus.BAD_REQUEST);
        }

        if (teamService.teamExists(competitionId, teamName)) {
            return new ResponseEntity<>(Map.of("message","A team with that name already exists."), HttpStatus.BAD_REQUEST);
        }

        Optional<Competition> competitionOptional = competitionService.getCompetition(competitionId);

        // Handles prior thisCompetitionExists check
        if (competitionOptional.isEmpty()) {
            return new ResponseEntity<>(Map.of("message","The requested competition does not exist"), HttpStatus.BAD_REQUEST);
        }

        Competition competition = competitionOptional.get();

        if (competition.hasEnded()) {
            return new ResponseEntity<>(Map.of("message","The requested competition has ended."), HttpStatus.BAD_REQUEST);
        }
        
        try {

            Team addedTeam = teamService.addTeam(competitionId, teamName, teamDisplayName, club, teamDisplayShort);
            return new ResponseEntity<>(addedTeam, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message",e.getMessage()), HttpStatus.BAD_REQUEST);
        }

    }
    

    @GetMapping(params = { "page", "size", "search" }, value = "/query")
    public ResponseEntity<?> queryTeamsByClub(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        if (search == null || search.isBlank()) {
            search = "";
        }

        Page<Team> resultPage = teamService.findWithPaginatedsearchByClub(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping(value = "/amParticipating")
    public ResponseEntity<?> getTeamInWhichThisUserIsParticipating(@Valid @RequestBody CompetitionNameRequest request) {

        Long userId = UserInfoDetails.getDetails().getId();

        Optional<Team> team = teamService.getUserTeam(userId, request.getCompetitionName());

        if (team.isPresent()) {
            return new ResponseEntity<>(team.get(), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping(params = { "page", "size", "club" }, value = "active/query")
    public ResponseEntity<?> queryUsers(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "club", required = false) String club) throws Exception {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        if (club == null || club.isBlank()) {
            club = "";
        }

        Page<Team> resultPage = teamService.findThisClubsTeamsWhichAreInActiveCompetitions(page, size, club);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);

    }

    
    @GetMapping("/teamExists")
    public ResponseEntity<?> hasTeam(@Valid @RequestBody TeamIdRequest request) {

        Boolean value = teamService.isTeamPartOfCompetition(request.getCompetitionName(), request.getTeamName());
        return new ResponseEntity<>(value, HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<?> getTeam(
        @RequestParam(name = "team") String team,
        @RequestParam(name = "competition") String competition
    ) {

        Optional<Team> teamOptional = teamService.getTeam(competition, team);

        if (teamOptional.isEmpty()) {
            return new ResponseEntity<>(Map.of("message","No team found with the given parameters."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(teamOptional.get(), HttpStatus.OK);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@Valid @RequestBody TeamScoreRequest request) {

        if (!teamService.isTeamPartOfCompetition( request.getCompetitionName(), request.getTeamName())){
            return new ResponseEntity<>(Map.of("message","No team found."), HttpStatus.OK);
        }

        List<TeamMemberScore> scores = scoreService.getTeamScores(new TeamId(request.getCompetitionName(), request.getTeamName()));

        // Notify client if there are no scores for this team id
        if (scores == null || scores.isEmpty()) {
            return new ResponseEntity<>(Map.of("message","This team has not yet submitted any scores."), HttpStatus.OK);
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
