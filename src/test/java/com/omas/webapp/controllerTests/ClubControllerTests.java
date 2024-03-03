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
public class ClubControllerTests {

    @Autowired
    private MockMvc mockMvc;

    private static final String baseUrl = "/api/club";
    private static final String authUrl = "/api/auth/club";

    private static final String addNewUrl = authUrl + "/new";
    private static final String getAllUrl = baseUrl + "/all";
    private static final String searchUrl = baseUrl + "/query?search=&page=0&size=10";

    @Test
    public void addClub() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content("{" + "\"clubName\":\"Seuran nimi\"" + "}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Seuran_nimi"));

    }

    @Test
    public void getAll() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(getAllUrl))
                .andExpect(status().isFound());

    }

    @Test
    public void searchClubs() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(searchUrl))
                .andExpect(status().isOk());

    }

    @Test
    public void getByID() throws Exception {

        final String clubName = "SeuraajienSeura";

        // adds club
        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "jondoe"))
                .content("{" + "\"clubName\":\"" + clubName + "\"" + "}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value(clubName));

        // gets club
        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "/" + clubName))
                .andExpect(status().isFound())
                .andExpect(jsonPath("$.name").value(clubName));

    }

    @Test
    public void joinClub() throws Exception {

        final String clubName = "SeuraajienSeura";

        // adds club
        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content("{" + "\"clubName\":\"" + clubName + "\"" + "}"))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value(clubName));

        // join club
        mockMvc.perform(MockMvcRequestBuilders.post(authUrl + "/" + "join")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content("{" + "\"clubName\":\"" + clubName + "\"" + "}"))
                .andExpect(status().isOk());
    }

}