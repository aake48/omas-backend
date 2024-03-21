package com.omas.webapp.controllerTests;

import com.omas.webapp.Constants;
import com.omas.webapp.Json;
import com.omas.webapp.TestUtils;
import com.omas.webapp.entity.response.CompetitionResponse;
import com.omas.webapp.entity.response.CompetitionTeamResponse;
import com.omas.webapp.entity.response.TeamMemberScoreResponse;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class CompetitionControllerTests {

    @Autowired
    private MockMvc mockMvc;

    private static final String baseUrl = "/api/competition";
    private static final String authUrl = "/api/auth/competition";

    private static final String addNewUrl = authUrl + "/new";
    private static final String getAllUrl = baseUrl + "/all";
    private static final String searchUrl = baseUrl + "/query?search=&page=0&size=10";
    private static final String getResultsUrl = "/api/competition/result/";

    private static final String competitionDisplayName = "köyräs ensimmäinen sarja -kilpailu";
    private static final String competitionNameId = Constants.createIdString(competitionDisplayName);

    @Test
    public void getResults() throws Exception {

        String url = getResultsUrl + competitionNameId;

        String club1 = "talo";
        String club2 = "club2";
        String club3 = "club3";
        String club4 = "club4";
        String club5 = "club5";

        String team1 = "team1";
        String team2 = "team2";
        String team3 = "team3";
        String team4 = "team4";
        String team5 = "team5";

        // sets up 5 clubs with scores to same competition
        TestUtils.setupScores(mockMvc, club1, team1, competitionNameId);
        TestUtils.setupScores(mockMvc, club2, team2, competitionNameId);
        TestUtils.setupScores(mockMvc, club3, team3, competitionNameId);
        TestUtils.setupScores(mockMvc, club4, team4, competitionNameId);
        TestUtils.setupScores(mockMvc, club5, team5, competitionNameId);

        String response = mockMvc.perform(MockMvcRequestBuilders.get(url))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId))
                .andReturn()
                .getResponse()
                .getContentAsString();

        CompetitionResponse competitionResponse = Json.fromString(response, CompetitionResponse.class);

        List<CompetitionTeamResponse> teams = competitionResponse.getTeams();

        double largestTotalScore = teams.get(0).getTotalScore();

        for (CompetitionTeamResponse team : teams) {

            assertFalse(team.getTotalScore() > largestTotalScore, "The team must be sorted in descending order");

            List<TeamMemberScoreResponse> scores = team.getScores();

            double largestTeamScore = scores.get(0).getSum();

            for (TeamMemberScoreResponse teamScore : scores) {
                assertFalse(teamScore.getSum() > largestTeamScore, "The score list must be sorted in descending order");
            }

        }

        System.out.println(Json.stringify(competitionResponse, true));
    }

    @Test
    public void addRifleCompetition() throws Exception {

        String json = new JSONObject()
                .put("competitionName", competitionDisplayName)
                .put("competitionType", TestUtils.rifleCompetitionType)
                .toString();



        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.type").value(TestUtils.rifleCompetitionType))
                .andExpect(jsonPath("$.displayName").value(competitionDisplayName))
                .andExpect(jsonPath("$.startDate").exists())
                .andExpect(jsonPath("$.endDate").exists())
                .andExpect(jsonPath("$.creationDate").exists())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId));


    }

    @Test
    public void addPistolScore() throws Exception {

        String json = new JSONObject()
                .put("competitionName", competitionNameId)
                .put("competitionType", TestUtils.pistolCompetitionType)
                .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.type").value(TestUtils.pistolCompetitionType))
                .andExpect(jsonPath("$.displayName").value(competitionDisplayName))
                .andExpect(jsonPath("$.startDate").exists())
                .andExpect(jsonPath("$.endDate").exists())
                .andExpect(jsonPath("$.creationDate").exists())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId));
    }

    @Test
    public void getAll() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(getAllUrl))
                .andExpect(status().isOk());

    }

    @Test
    public void searchCompetitions() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(searchUrl))
                .andExpect(status().isOk());

    }

    @Test
    public void getByID() throws Exception {

        String json = new JSONObject()
                .put("competitionName", competitionNameId)
                .put("competitionType", TestUtils.rifleCompetitionType)
                .toString();

        // adds competition
        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId));

        // gets competition
        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "/" + competitionNameId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId));

    }

}