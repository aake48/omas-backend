package com.omas.webapp.controllerTests;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import com.omas.webapp.Constants;
import com.omas.webapp.TestUtils;
import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.service.RoleService;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.User;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.MediaType;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class AdminControllerTests {

    @Autowired
    private MockMvc mockMvc;

    private String adminToken;
    private JSONObject adminUser;

    private final String baseUrl = "/api/admin/";
    private final String queryUrl = "/api/admin/user/query?search=&page=0&size=5";

    private final String deletionUrl = "/api/admin/delete";
    private final String adminAddScoresUrl = "/api/admin/addScores";
    private final String adminRemoveScoresUrl = "/api/admin/removeScores";

    private final String clubName = "testiseura";
    private final String competitionId = "testikilpailu";
    private final String teamName = "testitiimi";

    @Autowired
    RoleService roleService;

    @Autowired
    UserService userService;

    private final String adminPassword = "adminPassword";
    private final String admin = "admin";



    private void addAdminUser() throws Exception {

        RegistrationRequest registrationRequest = new RegistrationRequest();
        registrationRequest.setEmail(admin);
        registrationRequest.setName(admin);
        registrationRequest.setUsername(admin);
        registrationRequest.setPassword(adminPassword);

        userService.registerUser(registrationRequest);

        try {
            User createdUser = userService.getUserByUsername("admin").get();
            roleService.addAdminRole(createdUser.getId());
        } catch (Exception e) {
            System.out.println("ex : " + e);
        }

    }

    @BeforeEach
    private void registerUser() throws Exception {

        addAdminUser();

        // login admin
        JSONObject response = new JSONObject(TestUtils.loginUser(mockMvc, Constants.ADMIN_USERNAME, Constants.ADMIN_PASSWORD));

        adminToken = response.getString("token");
        adminUser = response.getJSONObject("user");
    }

    @Test
    void registerAndDeleteUser() throws Exception {

        String user = "johndoe";
        String password = "password123";

        TestUtils.registerUser(mockMvc, user, password);
        String loginResponse = TestUtils.loginUser(mockMvc, user, password);
        JSONObject userObject = new JSONObject(loginResponse).getJSONObject("user");
        Long userId = userObject.getLong("userId");

        String deleteRequest = new JSONObject()
            .put("userId", userId)
            .toString();

        String deletionResponse = mockMvc.perform(MockMvcRequestBuilders.delete(deletionUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(deleteRequest))
            .andExpect(status().isOk())
            .andReturn()
            .getResponse()
            .getContentAsString();

        System.out.println("deletionResponse: " + deletionResponse);
    }

    @Test
    void searchUsers() throws Exception {

        String response = mockMvc.perform(MockMvcRequestBuilders.get(queryUrl)
                .header("Authorization", "Bearer " + adminToken))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.totalElements").exists())
            .andExpect(jsonPath("$.content").exists())
            .andExpect(jsonPath("$.numberOfElements").exists())
            .andExpect(jsonPath("$.numberOfElements").value(1))
            .andReturn()
            .getResponse()
            .getContentAsString();

        JSONArray array = new JSONObject(response).getJSONArray("content");
        JSONObject user = array.getJSONObject(0);

        JSONArray ar = user.getJSONArray("roles");
        assertTrue(ar.length() == 2);

        System.out.println("role: " + ar);

    }

    @Test
    void removeNonExistentRole() throws Exception {

        TestUtils.registerUser(mockMvc, "johanDoey", "johanDoey");
        String resp = TestUtils.loginUser(mockMvc, "johanDoey", "johanDoey");
        JSONObject userObject = new JSONObject(resp).getJSONObject("user");
        long userId = userObject.getLong("userId");

        String url = baseUrl + "demote";

        String json = new JSONObject()
            .put("userId", userId)
            .put("role", "kuvaseura/admin")
            .toString();

        String response = mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(json))
            .andExpect(status().isBadRequest())
            .andReturn().getResponse().getContentAsString();

        System.out.println("deleteResponse: " + response);
    }

    @Test
    void demoteUser() throws Exception {

        TestUtils.registerUser(mockMvc, "johanDoey", "johanDoey");
        String resp = TestUtils.loginUser(mockMvc, "johanDoey", "johanDoey");
        JSONObject userObject = new JSONObject(resp).getJSONObject("user");
        long userId = userObject.getInt("userId");

        String url = baseUrl + "demote";

        String json = new JSONObject()
            .put("userId", userId)
            .put("role", "ROLE_USER")
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(json))
            .andExpect(status().isOk());

        String queryUrl = "/api/admin/user/query?search=johan&page=0&size=5";

        String response = mockMvc.perform(MockMvcRequestBuilders.get(queryUrl)
                .header("Authorization", "Bearer " + adminToken))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.totalElements").exists())
            .andExpect(jsonPath("$.content").exists())
            .andExpect(jsonPath("$.numberOfElements").exists())
            .andReturn()
            .getResponse()
            .getContentAsString();

        JSONArray array = new JSONObject(response).getJSONArray("content");
        JSONObject user = array.getJSONObject(0);

        JSONArray rolesArray = user.getJSONArray("roles");
        System.out.println("roles: " + rolesArray);
        assertTrue(rolesArray.length() == 0);

    }

    @Test
    void promote() throws Exception {

        String url = baseUrl + "promote";

        TestUtils.registerUser(mockMvc, "johanDoey", "johanDoey");
        String resp = TestUtils.loginUser(mockMvc, "johanDoey", "johanDoey");
        JSONObject userObject = new JSONObject(resp).getJSONObject("user");
        long userId = userObject.getInt("userId");

        String role = "ROLE_KALASTAJA";

        String json = new JSONObject()
            .put("userId", userId)
            .put("role", role)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(json))
            .andExpect(status().isOk());

        String queryUrl = "/api/admin/user/query?search=johan&page=0&size=5";

        String response = mockMvc.perform(MockMvcRequestBuilders.get(queryUrl)
                .header("Authorization", "Bearer " + adminToken))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.totalElements").exists())
            .andExpect(jsonPath("$.content").exists())
            .andExpect(jsonPath("$.numberOfElements").exists())
            .andReturn()
            .getResponse()
            .getContentAsString();

        JSONArray array = new JSONObject(response).getJSONArray("content");
        System.out.println("array: " + array);

        JSONObject user = array.getJSONObject(0);
        System.out.println("user: " + user);

        JSONArray rolesArray = user.getJSONArray("roles");
        System.out.println("rolesArray: " + rolesArray);
        assertTrue(rolesArray.length() == 2);
        boolean found = false;

        for (int i = 0; i < rolesArray.length(); i++) {
            if (rolesArray.getJSONObject(i).getString("role").equals(role)) {
                found = true;
                break;
            }
        }

        assertTrue(found);
    }

    @Test
    public void setTeamMemberScoreAsSumAsAdmin() throws Exception {

        TestUtils.addClub(mockMvc, clubName, adminToken);
        TestUtils.joinClub(mockMvc, clubName, adminToken);
        TestUtils.addRifleCompetition(mockMvc, competitionId, adminToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, adminToken);

        // Submit some sum
        String submitSumJson = new JSONObject()
            .put("userId", adminUser.getLong("userId"))
            .put("clubName", clubName)
            .put("competitionName", competitionId)
            .put("teamName", teamName)
            .put("bullsEyeCount", 3)
            .put("score", 240D)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(adminAddScoresUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(submitSumJson))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.sum").isNotEmpty())
            .andExpect(jsonPath("$.sum").value(240D))
            .andExpect(jsonPath("$.bullsEyeCount").value(3));

        // Now set it to something else
        String setSumJson = new JSONObject()
            .put("userId", adminUser.getLong("userId"))
            .put("clubName", clubName)
            .put("competitionName", competitionId)
            .put("teamName", teamName)
            .put("bullsEyeCount", 5)
            .put("score", 300D)
            .put("requestType", Constants.ADD_METHOD_SET)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(adminAddScoresUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(setSumJson))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.sum").isNotEmpty())
            .andExpect(jsonPath("$.sum").value(300D))
            .andExpect(jsonPath("$.bullsEyeCount").value(5));
    }

    @Test
    public void updateTeamMemberScoreSumAsAdmin() throws Exception {

        TestUtils.addClub(mockMvc, clubName, adminToken);
        TestUtils.joinClub(mockMvc, clubName, adminToken);
        TestUtils.addRifleCompetition(mockMvc, competitionId, adminToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, adminToken);

        // Submit some sum
        String submitSumJson = new JSONObject()
            .put("userId", adminUser.getLong("userId"))
            .put("clubName", clubName)
            .put("competitionName", competitionId)
            .put("teamName", teamName)
            .put("bullsEyeCount", 3)
            .put("score", 240D)
            .put("requestType", Constants.ADD_METHOD_UPDATE)
            .toString();

        mockMvc.perform(MockMvcRequestBuilders.post(adminAddScoresUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(submitSumJson))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.sum").isNotEmpty())
            .andExpect(jsonPath("$.sum").value(240D));

        // Submit the same thing again
        mockMvc.perform(MockMvcRequestBuilders.post(adminAddScoresUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(submitSumJson))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.sum").isNotEmpty())
            .andExpect(jsonPath("$.bullsEyeCount").value(6))
            .andExpect(jsonPath("$.sum").value(480D));

    }

    @Test
    public void removeTeamMemberScore() throws Exception {

        TestUtils.registerUser(mockMvc, "testuser", "testpassword");
        JSONObject response = new JSONObject(TestUtils.loginUser(mockMvc, "testuser", "testpassword"));

        JSONObject user = response.getJSONObject("user");
        String userToken = response.getString("token");

        TestUtils.addClub(mockMvc, clubName, adminToken);
        TestUtils.joinClub(mockMvc, clubName, adminToken);
        TestUtils.addRifleCompetition(mockMvc, competitionId, adminToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, userToken);
        TestUtils.addScores(mockMvc, competitionId, teamName, userToken);

        String teamMemberIdJson = new JSONObject()
            .put("userId", user.getLong("userId"))
            .put("competitionId", competitionId)
            .put("teamName", teamName)
            .toString();

        // Remove the score
        mockMvc.perform(MockMvcRequestBuilders.post(adminRemoveScoresUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + adminToken)
                .content(teamMemberIdJson))
            .andExpect(status().isOk());
    }

}
