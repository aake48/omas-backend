package com.omas.webapp.controllerTests;

import com.omas.webapp.Constants;
import com.omas.webapp.TestUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import java.util.Arrays;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertTrue;
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
    private static final String searchUrl = baseUrl + "/query?search=&page=0&size=5";
    private static final String getResultsUrl = "/api/competition/result/";

    private static final String competitionDisplayName = "köyräs ensimmäinen sarja -kilpailu";
    private static final String competitionNameId = Constants.createIdString(competitionDisplayName);

    @Test
    public void getResults() throws Exception {

        String url = getResultsUrl + competitionNameId;

        List<String> clubs = Arrays.asList("club1", "club2", "club3", "club4", "club5");

        TestUtils.setupScores(mockMvc, clubs, competitionNameId, 5);

        String response = mockMvc.perform(MockMvcRequestBuilders.get(url))
                .andExpect(status().isOk())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.type").value(Constants.RIFLE_TYPE))
                .andExpect(jsonPath("$.displayName").value(competitionNameId))
                .andExpect(jsonPath("$.startDate").exists())
                .andExpect(jsonPath("$.endDate").exists())
                .andExpect(jsonPath("$.creationDate").exists())
                .andExpect(jsonPath("$.competitionId").value(competitionNameId))
                .andExpect(jsonPath("$.teams").exists())
                .andReturn()
                .getResponse()
                .getContentAsString();

        JSONObject jsonObject = new JSONObject(response);

        JSONArray teams = jsonObject.getJSONArray("teams");

        Boolean isDescending = true;

        int previousScore = Integer.MAX_VALUE;

        for (int i = 0; i < teams.length(); i++) {
            JSONObject team = teams.getJSONObject(i);
            int totalScore = team.getInt("totalScore");

            if (totalScore > previousScore) {
                isDescending = false;
                break;
            }

            previousScore = totalScore;

            JSONArray scores = team.getJSONArray("scores");
            int previousSum = Integer.MAX_VALUE;

            for (int j = 0; j < scores.length(); j++) {
                JSONObject score = scores.getJSONObject(j);
                int sum = score.getInt("sum");

                if (sum > previousSum) {
                    isDescending = false;
                    break;
                }

                previousSum = sum;
            }

            if (!isDescending) {
                break;
            }
        }

        assertTrue(isDescending);
    }


    @Test
    public void addRifleCompetition() throws Exception {

        String json = new JSONObject()
            .put("competitionName", competitionDisplayName)
            .put("competitionType", Constants.RIFLE_TYPE)
            .toString();


        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.type").value(Constants.RIFLE_TYPE))
            .andExpect(jsonPath("$.displayName").value(competitionDisplayName))
            .andExpect(jsonPath("$.startDate").exists())
            .andExpect(jsonPath("$.endDate").exists())
            .andExpect(jsonPath("$.creationDate").exists())
            .andExpect(jsonPath("$.competitionId").value(competitionNameId));


    }

    @Test
    public void addPistolScore() throws Exception {

        String json = new JSONObject()
            .put("competitionName", competitionDisplayName)
            .put("competitionType", Constants.PISTOL_TYPE)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.type").value(Constants.PISTOL_TYPE))
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

    /**
     * Checks that correct number of elements if found
     */
    @Test
    public void searchCompetitions() throws Exception {

        int size = 6;
        for (int i = 0; i < size; i++) {
            TestUtils.addRifleCompetition(
                mockMvc, TestUtils.getRandomString(),
                TestUtils.getToken(mockMvc, TestUtils.getRandomString()));
        }

        mockMvc.perform(MockMvcRequestBuilders.get(searchUrl))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.totalElements").value(size))
            .andExpect(jsonPath("$.content").exists())
            .andExpect(jsonPath("$.numberOfElements").value(5));

    }

    @Test
    public void searchCompetitionsById() throws Exception {

        String firstToken = TestUtils.getToken(mockMvc, TestUtils.getRandomString());
        String secondToken = TestUtils.getToken(mockMvc, TestUtils.getRandomString());

        TestUtils.addRifleCompetition(mockMvc, "testname", firstToken);
        TestUtils.addRifleCompetition(mockMvc, "testname2", secondToken);

        TestUtils.addClub(mockMvc, "Seura 1", firstToken);
        TestUtils.joinClub(mockMvc, "Seura 1", firstToken);
        TestUtils.joinClub(mockMvc, "Seura 1", secondToken);

        TestUtils.addTeam(mockMvc, "testname", "Joukkue 1", firstToken);
        TestUtils.addTeam(mockMvc, "testname", "Joukkue 2", secondToken);
        TestUtils.addTeam(mockMvc, "testname2", "Joukkue 3", firstToken);
        TestUtils.addTeam(mockMvc, "testname2", "Joukkue 4", secondToken);

        String searchUrl = "/api/competition/teams?search=testname&page=0&size=10";

        mockMvc.perform(MockMvcRequestBuilders.get(searchUrl))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.numberOfElements").value(4))
            .andReturn()
            .getResponse()
            .getContentAsString();

    }

    @Test
    public void getByID() throws Exception {

        String json = new JSONObject()
            .put("competitionName", competitionNameId)
            .put("competitionType", Constants.RIFLE_TYPE)
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