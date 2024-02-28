package com.omas.webapp.controllerTests;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import java.util.Map;
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
public class TeamMemberControllerTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String baseUrl = "/api/competition/team/member";

        private static final String addNewUrl = baseUrl + "/add";
        private static final String ScoreUrl = baseUrl + "/score";

        private String token;
        private final String clubName = "Seuraajat1";
        private final String competitionName = "2024-kevät_60_laukauksen_kilpailu";


        @BeforeEach
        private void test() throws Exception {
                token = TestUtils.getToken(mockMvc);
                TestUtils.addClub(mockMvc, clubName, token);
                TestUtils.joinClub(mockMvc, clubName, token);
                TestUtils.addCompetition(mockMvc, competitionName, token);
                TestUtils.addTeam(mockMvc, competitionName, token);
        }

        @Test
        public void addTeamMember() throws Exception {

                //add user to team
                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionName));

        }

        @Test
        public void getTeamMemberScore() throws Exception {

                //add user to team
                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionName));



                //getUserScore
                mockMvc.perform(MockMvcRequestBuilders.get(ScoreUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content("{"
                                + "\"competitionName\":\""+competitionName+"\","
                                + "\"id\":\""+Long.valueOf(0)+"\"" + "}"))
                                .andExpect(status().isOk());
        }

        @Test
        public void PostTeamMemberScore() throws Exception {

                // add user to team
                mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content(new ObjectMapper()
                                                .writeValueAsString(Map.of("competitionName", competitionName))))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.competitionId").value(competitionName));

                List<Double> shots = TestUtils.give60shots();
                ObjectMapper mapper = new ObjectMapper();
                String json = mapper.writeValueAsString(Map.of(
                                "competitionName", competitionName,
                                "scoreList", shots));

                // Post user score
                mockMvc.perform(MockMvcRequestBuilders.post(ScoreUrl + "/add")
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content(json))
                                .andExpect(status().isCreated())
                                .andExpect(jsonPath("$.sum").isNotEmpty());
        }
}
