package com.omas.webapp.controllerTests;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.json.JSONObject;
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

    private static final String queryTeamsByClubUrl = baseUrl + "/query?search=johan&page=0&size=5";
    private static final String addNewUrl = baseUrl + "/new";
    private static final String getScoreUrl = baseUrl + "/score";

    final String clubName = "Seuraajat1";
    final String competitionName = "2040 kesäampujaiset";
    final String competitionNameId = "2040_kesaampujaiset";
    final String teamNameId = "team_nameId";


    @Test
    void GetNonExistingTeam() throws Exception {

        String getTeamUrl = "/api/competition/team?team=" + "team1" + "&competition=" + competitionNameId;

        mockMvc.perform(MockMvcRequestBuilders.get(getTeamUrl)
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isBadRequest());
    }

    @Test
    void getTeam() throws Exception {
        String token = TestUtils.getToken(mockMvc, "user112233");

        TestUtils.addRifleCompetition(mockMvc, competitionName, token);
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addTeam(mockMvc, competitionNameId, teamNameId, token);

        String getTeamUrl = "/api/competition/team?team=" + teamNameId + "&competition=" + competitionNameId;

        mockMvc.perform(MockMvcRequestBuilders.get(getTeamUrl)
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.competitionId").value(competitionNameId.toLowerCase()))
            .andExpect(jsonPath("$.teamDisplayName").value(teamNameId))
            .andExpect(jsonPath("$.teamName").value(teamNameId.toLowerCase()))
            .andExpect(jsonPath("$.clubName").value(clubName.toLowerCase()))
            .andExpect(jsonPath("$.teamMembers").exists());
    }

    @Test
    void addTeamWithSameNameAgain() throws Exception {

        String token = TestUtils.getToken(mockMvc, "johndoe");

        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addRifleCompetition(mockMvc, competitionName, token);

        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();


        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.competitionId").value(competitionNameId));

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isBadRequest());
    }

    @Test
    void queryTeamsByClub() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get(queryTeamsByClubUrl))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.totalElements").exists())
            .andExpect(jsonPath("$.content").exists())
            .andExpect(jsonPath("$.numberOfElements").exists());
    }

    @Test
    void addTeam() throws Exception {

        String token = TestUtils.getToken(mockMvc, "johndoe");

        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addRifleCompetition(mockMvc, competitionName, token);

        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();


        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.competitionId").value(competitionNameId));
    }


    @Test
    public void addTeamIntoNonExistingCompetition() throws Exception {

        String token = TestUtils.getToken(mockMvc, "johndoe");
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);

        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isBadRequest());

    }

    //
    // @Test
    // public void addTeamWithNonExistingClub() throws Exception {
    //         String token = TestUtils.getToken(mockMvc, "johndoe");
    //         TestUtils.addRifleCompetition(mockMvc, competitionName, token);

    //         String json = new JSONObject()
    //                         .put("teamName", teamNameId)
    //                         .put("competitionName", competitionNameId)
    //                         .toString();

    //         mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
    //                         .contentType(MediaType.APPLICATION_JSON)
    //                         .header("Authorization", "Bearer " + token)
    //                         .content(json))
    //                         .andExpect(status().isBadRequest())
    //                         .andExpect(jsonPath("$.error").exists());
    // }


    @Test
    public void getTeamScore() throws Exception {

        String token = TestUtils.getToken(mockMvc, "johndoe");
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addRifleCompetition(mockMvc, competitionName, token);

        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.competitionId").value(competitionNameId));

        mockMvc.perform(MockMvcRequestBuilders.get(getScoreUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk());
    }

    @Test
    public void teamExists() throws Exception {

        String url = baseUrl + "teamExists";


        String token = TestUtils.getToken(mockMvc, "johndoe");
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addRifleCompetition(mockMvc, competitionNameId, token);
        TestUtils.addTeam(mockMvc, competitionNameId, teamNameId, token);


        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.get(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk())
            .andExpect(content().string("true"));
    }


    @Test
    public void teamExistsWithoutTeam() throws Exception {

        String url = baseUrl + "teamExists";


        String token = TestUtils.getToken(mockMvc, "johndoe");
        TestUtils.addClub(mockMvc, clubName, token);
        TestUtils.joinClub(mockMvc, clubName, token);
        TestUtils.addRifleCompetition(mockMvc, competitionNameId, token);
        //Club has not enlisted any team for this competition //TestUtils.addTeam(mockMvc, competitionNameId, teamNameId, token);


        String json = new JSONObject()
            .put("teamName", teamNameId)
            .put("competitionName", competitionNameId)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.get(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + token)
                .content(json))
            .andExpect(status().isOk())
            .andExpect(content().string("false"));
    }
}
