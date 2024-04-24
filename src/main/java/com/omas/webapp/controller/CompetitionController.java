package com.omas.webapp.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.omas.webapp.Constants;
import com.omas.webapp.entity.requests.AddCompetitionRequest;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserService;
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

import java.time.format.DateTimeFormatter;
import java.util.*;

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
    public ResponseEntity<?> addCompetition(@Valid @RequestBody AddCompetitionRequest request) {

        String competitionName = request.getCompetitionName();
        String competitionId = Constants.createIdString(competitionName);

        // Util.sanitizeName returns null if the sanitation was not possible
        if (competitionId == null) {
            return new ResponseEntity<>(Map.of("message","Competition name contains characters which are forbidden."), HttpStatus.BAD_REQUEST);
        }

        Competition comp = competitionService.addCompetition(
                new Competition(competitionId, competitionName, request.getCompetitionType(), request.getStartDate(), request.getEndDate())
        );

        if (comp != null) {
            return new ResponseEntity<>(comp, HttpStatus.CREATED);
        }

        return new ResponseEntity<>(Map.of("message","Competition name has already been taken"), HttpStatus.BAD_REQUEST);
    }

    @GetMapping(params = { "page", "size" }, value = "competition/upcoming/query")
    public ResponseEntity<?> queryUpcomingCompetitions(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size
    ) {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        Page<Competition> resultPage = competitionService.findUpcomingCompetitions(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping(params = { "page", "size" }, value = "competition/inactive/query")
    public ResponseEntity<?> queryCompetitionsThatHaveEnded(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size
    ) {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        Page<Competition> resultPage = competitionService.findInactiveCompetitions(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping(params = { "page", "size" }, value = "competition/active/query")
    public ResponseEntity<?> queryActiveCompetitions(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size
    ) {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        Page<Competition> resultPage = competitionService.findActiveCompetitions(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping(value = "competition/query")
    public ResponseEntity<?> queryCompetitionByYearAndSearch(
        @RequestParam(value = "page", defaultValue = "0", required = false) int page,
        @RequestParam(value = "size", defaultValue = "10", required = false) int size,
        @RequestParam(value = "year", required = false) Integer year,
        @RequestParam(value = "search", required = false, defaultValue = "") String search
    ) {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        Page<Competition> resultPage;

        if (year == null) {
            resultPage = competitionService.findWithPaginatedSearch(page, size, search);
        } else {
            resultPage = competitionService.findByYearContaining(page, size, year, search);
        }

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping(params = { "page", "size", "search" }, value = "competition/teams")
    public ResponseEntity<?> queryTeamsByCompetition(
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size,
        @RequestParam(value = "search", required = false, defaultValue = "") String search
    ) {

        if (page < 0) {
            return new ResponseEntity<>(Map.of("message","Invalid page number."), HttpStatus.BAD_REQUEST);
        }

        Page<Team> resultPage = teamService.findWithPaginatedSearchByCompetitionId(page, size, search);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("competition/{name}")
    public ResponseEntity<?> getCompetition(@PathVariable String name) {
        try {
            return new ResponseEntity<>(competitionService.getCompetition(name), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","No competition found with the given name."), HttpStatus.BAD_REQUEST);
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

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");


        try {

            String competitionId = Constants.createIdString(name);

            if (competitionId == null) {
                return new ResponseEntity<>(Map.of("message", "Illegal characters in competition name"), HttpStatus.BAD_REQUEST);
            }

            Competition competition = competitionService.getCompetition(competitionId).get();
            List<Team> teams = teamService.getTeamsParticipatingInCompetition(competitionId);
            ObjectMapper mapper = new ObjectMapper();
            List<JsonNode> teamNodesList = new ArrayList<>();

            // Creates teamNode that includes teamMemberScores and adds it to teamNodesList
            for (Team team : teams) {
                // The scores are pre-sorted in descending order by the repository class based
                // on the sum, user's total score.
                List<TeamMemberScore> scores = teamMemberScoreService
                        .getTeamScores(new TeamId(team.getCompetitionId(), team.getTeamName()));
                ArrayNode teamScores = mapper.createArrayNode();
                double teamTotal = 0;
                // adds teamMemberScores into a JSON array
                for (TeamMemberScore score : scores) {
                    ObjectNode scoreNode = mapper.createObjectNode()
                            .put("bullsEyeCount", score.getBullsEyeCount())
                            .put("sum", score.getSum())
                            .put("userId", score.getUserId())
                            .put("name", score.getTeamMember().getLegalName());
                    teamTotal += score.getSum();
                    teamScores.add(scoreNode);
                }
                ObjectNode teamNode = mapper.createObjectNode()
                        .put("totalScore", Math.floor(teamTotal * 10.0) / 10.0)
                        .put("teamName", team.getTeamName())
                        .put("teamDisplayName", team.getTeamDisplayName())
                        .set("scores", teamScores);
                teamNodesList.add(teamNode);
            }
            // sorts teams to descending order
            teamNodesList.sort((node1, node2) -> {
                double totalScore1 = node1.get("totalScore").asDouble();
                double totalScore2 = node2.get("totalScore").asDouble();
                // Compare the totalScore values
                return Double.compare(totalScore2, totalScore1);
            });
            ArrayNode teamNodes = mapper.createArrayNode();
            teamNodesList.forEach(teamNodes::add);
            ObjectNode competitionNode = mapper.createObjectNode()
                    .put("competitionId", competition.getCompetitionId())
                    .put("type", competition.getType())
                    .put("displayName", competition.getDisplayName())
                    .put("competitionType", competition.getType())
                    .put("creationDate", competition.getCreationDate().toLocalDateTime().format(formatter))
                    .put("startDate", competition.getStartDate().toLocalDateTime().format(formatter))
                    .put("endDate", competition.getEndDate().toLocalDateTime().format(formatter))
                    .set("teams", teamNodes);
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