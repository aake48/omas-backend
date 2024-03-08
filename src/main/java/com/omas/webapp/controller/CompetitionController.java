package com.omas.webapp.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
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
import lombok.extern.log4j.Log4j2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            return new ResponseEntity<>(
                    "{\"competitionName\":\"competition name contains characters which are forbidden.\"}",
                    HttpStatus.BAD_REQUEST);
        }

        Competition comp = competitionService.addCompetition(
                new Competition(competitionName, nonIdName, competitionRequest.getCompetitionType()));
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
            return new ResponseEntity<>(competitionService.getCompetition(name), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", "No competition found with the given name"),
                    HttpStatus.BAD_REQUEST);
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
        try {

            Competition competition = competitionService.getCompetition(name).get();
            List<Team> teams = teamService.getTeamsParticipatingInCompetition(name);
            ObjectMapper mapper = new ObjectMapper();
            List<JsonNode> teamNodesList = new ArrayList<>();
     
            

            // Creates teamNode that includes teamMemberScores and adds it to teamNodesList
            for (Team team : teams) {
                // The scores are pre-sorted in descending order by the repository class based
                // on the sum, user's total score.
                List<TeamMemberScore> scores = teamMemberScoreService.getTeamScores(new TeamId(team.getClubId(), team.getCompetitionId()));
                ArrayNode teamScores = mapper.createArrayNode();
                double teamTotal = 0;

                // adds teamMemberScores into a JSON array
                for (TeamMemberScore score : scores) {
                    ObjectNode scoreNode = mapper.createObjectNode()
                            .put("bullsEyeCount", score.getBullsEyeCount())
                            .put("sum", score.getSum())
                            .put("userId", score.getUserId())
                            .put("name", userService.getName(score.getUserId()))
                            .put("scorePerShot", score.getScorePerShot());
                    teamTotal += score.getSum();
                    teamScores.add(scoreNode);
                }

                ObjectNode teamNode = mapper.createObjectNode()
                        .put("club", team.getClubId())
                        .put("totalScore", Math.floor(teamTotal * 10.0) / 10.0)
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
                    .put("name", competition.getName())
                    .put("nameNonId", competition.getNameNonId())
                    .put("competitionType", competition.getType())
                    .put("creationDate", competition.getCreationDate().toString())
                    .set("teams", teamNodes);

            String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(competitionNode);

            return new ResponseEntity<>(json, HttpStatus.OK);

        } catch (JsonProcessingException e) {
            return new ResponseEntity<>(Map.of("error", e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            log.info(e);
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