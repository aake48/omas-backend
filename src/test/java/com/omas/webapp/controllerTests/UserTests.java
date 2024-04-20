package com.omas.webapp.controllerTests;

import com.omas.webapp.Constants;
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

    private static String token;

    private static final String compeitionName = "kuvanlatauskilpailu";
    private static final String competitionId = Constants.createIdString(compeitionName);
    private static final String teamName = "kuvajoukkue";
    private static final String clubName = "kuvaseura";

    @BeforeEach
    private void registerUser() throws Exception {

        token = TestUtils.getToken(mockMvc, "user123");

        TestUtils.addRifleCompetition(mockMvc, competitionId, token);
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addTeam(mockMvc, competitionId, teamName, token);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, token);
        TestUtils.addScores(mockMvc, competitionId, teamName, token);
    }

    @Test
    public void getUserTeam() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "team?competitionId=" + competitionId)
                .header("Authorization", "Bearer " + token))
            .andExpect(status().isOk())
            .andReturn()
            .getResponse()
            .getContentAsString();

    }
}
