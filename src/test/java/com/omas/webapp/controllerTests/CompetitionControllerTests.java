package com.omas.webapp.controllerTests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.omas.webapp.TestUtils;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.json.JSONObject;
import org.springframework.http.MediaType;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

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

    private static final String competitionNameId = "kilpa";


    
    @Test
    public void getResults() throws Exception {

        String  url = getResultsUrl + competitionNameId;

        String club1 = "talo";
        String club2 = "club2";
        String club3 = "club3";
        String club4 = "club4";
        String club5 = "club5";

        //sets up 5 clubs with scores to same competition 
        TestUtils.setupScores(mockMvc, club1, competitionNameId);
        TestUtils.setupScores(mockMvc, club2, competitionNameId);
        TestUtils.setupScores(mockMvc, club3, competitionNameId);
        TestUtils.setupScores(mockMvc, club4, competitionNameId);
        TestUtils.setupScores(mockMvc, club5, competitionNameId);

        String response = mockMvc.perform(MockMvcRequestBuilders.get(url))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.name").value("kilpa"))
        .andReturn()
        .getResponse()
        .getContentAsString();
        
        System.out.println(response);
    }
    

    @Test
    public void addRifleCompetition() throws Exception {

        String json = new JSONObject()
        .put("competitionName", competitionNameId)
        .put("competitionType", TestUtils.rifleCompetitionType)
        .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.type").value(TestUtils.rifleCompetitionType));

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
                .andExpect(jsonPath("$.type").value(TestUtils.pistolCompetitionType));

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
                .andExpect(jsonPath("$.name").value(competitionNameId));

        // gets competition
        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "/" + competitionNameId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value(competitionNameId));

    }

}