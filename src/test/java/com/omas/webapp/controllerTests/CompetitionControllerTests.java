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

    @Test
    public void addCompetition() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content("{" + "\"competitionName\":\"kilpa\"" + "}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("kilpa"));

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

        final String competitionName = "Kilpa";

        // adds competition
        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value(competitionName));

        // gets competition
        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "/" + competitionName))
                .andExpect(status().isFound())
                .andExpect(jsonPath("$.name").value(competitionName));

    }

}