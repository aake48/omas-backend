package com.omas.webapp.controller;

import com.omas.webapp.entity.requests.AddCompetitionRequest;
import com.omas.webapp.entity.requests.GetCompetitionTeamsRequest;
import com.omas.webapp.entity.response.*;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;
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

    @GetMapping("competition/teams")
    public ResponseEntity<?> getCompetitionTeams(GetCompetitionTeamsRequest request) {

        String competitionName = request.getCompetitionName();

        Optional<Competition> competitionOptional = competitionService.getCompetition(competitionName);

        if (competitionOptional.isEmpty()) {
            return new MessageResponse("No competition found with the given name.", HttpStatus.BAD_REQUEST);
        }

        List<Team> teams = teamService.getTeamsParticipatingInCompetition(competitionName);
        List<TeamInformation> teamInformation = new ArrayList<>(teams.size());

        for (Team team : teams) {
            teamInformation.add(new TeamInformation(team.getTeamName(), team.getTeamDisplayName()));
        }

        return new ResponseEntity<>(new CompetitionTeamListResponse(competitionOptional.get().getCompetitionId(), teamInformation), HttpStatus.OK);
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

            List<TeamMemberScore> scores = teamMemberScoreService.getTeamScores(team.getTeamId());
            List<TeamMemberScoreResponse> scoreResponses = new ArrayList<>(scores.size());

            for (TeamMemberScore score : scores) {
                scoreResponses.add(new TeamMemberScoreResponse(
                    score.getBullsEyeCount(), score.getSum(), score.getUserId(), userService.getName(score.getUserId()), score.getScorePerShot())
                );
            }

            // Sort the scores in ascending order
            Collections.sort(scoreResponses);

            // The score sum is calculated in the CompetitionTeamResponse constructor so there is no need to calculate it here
            competitionResponse.addTeam(new CompetitionTeamResponse(team.getTeamName(), team.getTeamDisplayName(), scoreResponses));
        }

        return new ResponseEntity<>(competitionResponse, HttpStatus.OK);

        /*try {

            Competition competition = competitionService.getCompetition(name).get();
            List<Team> teams = teamService.getTeamsParticipatingInCompetition(name);
            ObjectMapper mapper = new ObjectMapper();
            List<JsonNode> teamNodesList = new ArrayList<>();



            // Creates teamNode that includes teamMemberScores and adds it to teamNodesList
            for (Team team : teams) {
                // The scores are pre-sorted in descending order by the repository class based
                // on the sum, user's total score.
                List<TeamMemberScore> scores = teamMemberScoreService.getTeamScores(new TeamId(team.getCompetitionId(), team.getTeamName()));
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
                    .put("displayName", competition.getDisplayName())
                    .put("competitionType", competition.getType())
                    .put("creationDate", competition.getCreationDate().toString())
                    .put("startDate", competition.getStartDate().toString())
                    .put("endDate", competition.getEndDate().toString())
                    .set("teams", teamNodes);

            String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(competitionNode);

            return new ResponseEntity<>(json, HttpStatus.OK);

        } catch (JsonProcessingException e) {
            return new ResponseEntity<>(Map.of("error", e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            log.info(e);
            return new ResponseEntity<>(Map.of("message", "No competition found with the given name"),
                    HttpStatus.BAD_REQUEST);
        }*/
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