package com.omas.webapp.controllerTests;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.omas.webapp.TestUtils;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class TeamControllerTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String baseUrl = "/api/competition/team/";

        private static final String addNewUrl = baseUrl + "/new";
        private static final String getScoreUrl = baseUrl + "/score";

        String token;
        final String clubName = "Seuraajat1";

        // gets token for johndoe, adds first club and joins johndoe to it.
        @BeforeEach
        private void test() throws Exception {
                token = TestUtils.getToken(mockMvc);
                TestUtils.addClub(mockMvc, clubName, token);
                TestUtils.joinClub(mockMvc, clubName, token);
        }

        @Test
        public void addTeam() throws Exception {

                String competitionName = "2024-kevät_60_laukauksen_kilpailu";
                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionName));

        }

        @Test
        public void getTeamScore() throws Exception {

                String competitionName = "2024-kevät_60_laukauksen_kilpailu";
                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionName));

                mockMvc.perform(MockMvcRequestBuilders.get(getScoreUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{"
                                + "\"competitionName\":\""+competitionName+"\","
                                + "\"clubName\":\""+clubName+"\"" + "}"))
                                .andExpect(status().isOk());
        }
}
