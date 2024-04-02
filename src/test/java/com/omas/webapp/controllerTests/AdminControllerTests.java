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

    private final String baseUrl = "/api/admin/";
    private final String queryUrl = "/api/admin/user/query?search=&page=0&size=5";

    private final String deletionUrl = "/api/admin/delete";

    @BeforeEach
    private void registerUser() throws Exception {

        // login admin
        adminToken = new JSONObject(TestUtils.loginUser(mockMvc, Constants.adminUsername, Constants.adminPassword))
                .getString("token");
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
                .andExpect(jsonPath("$.message").value("User deleted"))
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

}
