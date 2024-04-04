package com.omas.webapp.controllerTests;

import com.fasterxml.jackson.databind.JsonNode;
import com.omas.webapp.Constants;
import com.omas.webapp.Json;
import com.omas.webapp.TestUtils;
import org.json.JSONObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class UserTests {

    @Autowired
    private MockMvc mockMvc;

    private static final String baseUrl = "/api/user/";

    private static String adminToken;

    private static final String competitionId = "kuvanlatauskilpailu";
    private static final String teamName = "kuvajoukkue";
    private static final String clubName = "kuvaseura";

    @BeforeEach
    private void registerUser() throws Exception {

        JSONObject loginResponse = new JSONObject(TestUtils.loginUser(mockMvc, Constants.ADMIN_USERNAME, Constants.ADMIN_PASSWORD));

        loginResponse.getJSONObject("user");
        adminToken = loginResponse.getString("token");

        TestUtils.addRifleCompetition(mockMvc, competitionId, adminToken);
        TestUtils.addClub(mockMvc, clubName, adminToken);
        TestUtils.joinClub(mockMvc, clubName, adminToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.addScores(mockMvc, competitionId, teamName, adminToken);
    }

    @Test
    public void getUserTeam() throws Exception {

        String response = mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "team?competitionId=" + competitionId)
                .header("Authorization", "Bearer " + adminToken))
            .andExpect(status().isOk())
            .andReturn()
            .getResponse()
            .getContentAsString();

        JsonNode node = Json.parse(response);

        System.out.println(Json.stringify(node, true));
    }

    @Test
    public void getUserTeams() throws Exception {

        String response = mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "teams")
                .header("Authorization", "Bearer " + adminToken))
            .andExpect(status().isOk())
            .andReturn()
            .getResponse()
            .getContentAsString();

        JsonNode node = Json.parse(response);

        System.out.println(Json.stringify(node, true));

    }

}
