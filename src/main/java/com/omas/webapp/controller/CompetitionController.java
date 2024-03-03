package com.omas.webapp.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.omas.webapp.entity.CompetitionRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;
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

import java.sql.Date;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CompetitionController {

    @Autowired
    CompetitionService competitionService;

    @Autowired
    TeamService teamService;

    @Autowired
    TeamMemberScoreService teamMemberScoreService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/competition/new")
    public ResponseEntity<?> addCompetition(@Valid @RequestBody CompetitionRequest competitionRequest) {

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
            return new ResponseEntity<>(
                    "{\"competitionName\":\"competition name contains characters which are forbidden.\"}",
                    HttpStatus.BAD_REQUEST);
        }

        Competition comp = competitionService.addCompetition(
                new Competition(competitionName, nonIdName,
                        new Date(Instant.now().toEpochMilli())));
        if (comp != null) {
            return new ResponseEntity<>(comp, HttpStatus.CREATED);
        }

        return new ResponseEntity<>(Map.of("message", "Competition name has already been taken"),
                HttpStatus.BAD_REQUEST);
    }

    @GetMapping(params = { "page", "size", "search" }, value = "competition/query")
    public ResponseEntity<?> queryCompetitions(@RequestParam("page") int page, @RequestParam("size") int size,
            @RequestParam("search") String search) throws Exception {

        if (!search.equals(null) || !search.isBlank()) {
            Page<Competition> resultPage = competitionService.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                return new ResponseEntity<>(Map.of("message", "Requested page does not exist."),
                        HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        Page<Competition> resultPage = competitionService.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>("{\"message\":\"Requested page does not exist.\"}", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("competition/{name}")
    public ResponseEntity<?> getCompetition(@PathVariable String name) {
        try {
            return new ResponseEntity<>(competitionService.getCompetition(name), HttpStatus.FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", "No competition found with the given name"),
                    HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/competition/result/{name}")
    public ResponseEntity<?> getResultsForCompetition(@PathVariable String name) {
        try {
            Competition competition = competitionService.getCompetition(name).get();
            List<Team> teams = teamService.getTeamsParticipatingInCompetition(name);

            ObjectMapper mapper = new ObjectMapper();

            ObjectNode competitionNode = mapper.createObjectNode()
                    .put("name", competition.getName())
                    .put("nameNonId", competition.getNameNonId())
                    .put("creationDate", competition.getCreationDate().toString());

            ArrayNode teamNodes = mapper.createArrayNode();
            for (Team team : teams) {
                List<TeamMemberScore> scores = teamMemberScoreService.getTeamScores(team.getTeamId());
                ArrayNode teamScores = mapper.createArrayNode();
                double teamTotal = 0;
                for (TeamMemberScore score : scores) {
                    ObjectNode scoreNode = mapper.createObjectNode()
                            .put("bullsEyeCount", score.getBullsEyeCount())
                            .put("sum", score.getSum())
                            .put("userId", score.getUserId())
                            .put("scorePerShot", score.getScorePerShot());
                    teamTotal += score.getSum();
                    teamScores.add(scoreNode);
                }
                ObjectNode teamNode = mapper.createObjectNode()
                        .put("club", team.getClubId())
                        .put("totalScore", teamTotal)
                        .set("scores", teamScores);

                teamNodes.add(teamNode);
            }

            competitionNode.set("teams", teamNodes);
            String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(competitionNode);

            return new ResponseEntity<>(json, HttpStatus.OK);

        } catch (JsonProcessingException e) {
            return new ResponseEntity<>(Map.of("error", e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", "No competition found with the given name"),
                    HttpStatus.BAD_REQUEST);
        }
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