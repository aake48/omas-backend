package com.omas.webapp.controllerTests;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

        final String clubName = "Seuraajat1";
        final String competitionName = "2040 kesäampujaiset";
        final String competitionNameId = "2040_kesaampujaiset";




        @Test
        void addTeam() throws Exception {

                String token = TestUtils.getToken(mockMvc, "johndoe");

                TestUtils.addClub(mockMvc, clubName, token);
                TestUtils.joinClub(mockMvc, clubName, token);
                TestUtils.addCompetition(mockMvc, competitionName, token);

                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionNameId + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionNameId));
        }


        @Test
        public void addTeamIntoNonExistingCompetition() throws Exception {

                String token = TestUtils.getToken(mockMvc, "johndoe");
                TestUtils.addClub(mockMvc, clubName, token);
                TestUtils.joinClub(mockMvc, clubName, token);

                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionNameId + "\"" + "}"))
                                .andExpect(status().isBadRequest())
                                .andExpect(jsonPath("$.error").exists());


        }

        @Test
        public void addTeamWithNonExistingClub() throws Exception {
                String token = TestUtils.getToken(mockMvc, "johndoe");
                TestUtils.addCompetition(mockMvc, competitionName, token);

                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionNameId + "\"" + "}"))
                                .andExpect(status().isBadRequest())
                                .andExpect(jsonPath("$.error").exists());
        }



        @Test
        public void getTeamScore() throws Exception {

                String token = TestUtils.getToken(mockMvc, "johndoe");
                TestUtils.addClub(mockMvc, clubName, token);
                TestUtils.joinClub(mockMvc, clubName, token);
                TestUtils.addCompetition(mockMvc, competitionName, token);

                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionNameId + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionNameId));

                mockMvc.perform(MockMvcRequestBuilders.get(getScoreUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{"
                                + "\"competitionName\":\""+competitionName+"\","
                                + "\"clubName\":\""+clubName+"\"" + "}"))
                                .andExpect(status().isOk());
        }
}
