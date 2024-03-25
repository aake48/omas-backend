package com.omas.webapp.controllerTests;

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

import org.json.JSONObject;
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

    private static final String nameNonId = "Öhrem täyrys -Seura";
    private static final String name = Constants.createIdString(nameNonId);



    @Test
    public void addClub() throws Exception {

            String user = "johndoe";
            String password = "password123";

            TestUtils.registerUser(mockMvc, user, password);
            String loginResponse = TestUtils.loginUser(mockMvc, user, password);
            JSONObject userObject = new JSONObject(loginResponse).getJSONObject("user");
            long userId = userObject.getInt("userId");

            String json = new JSONObject()
                            .put("clubName", nameNonId)
                            .toString();

            mockMvc.perform(MockMvcRequestBuilders.post(addNewUrl)
                            .contentType(MediaType.APPLICATION_JSON)
                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                            .content(json))
                            .andExpect(status().isOk())
                            .andExpect(jsonPath("$.name").value(name))
                            .andExpect(jsonPath("$.nameNonId").value(nameNonId))
                            .andExpect(jsonPath("$.creationDate").exists())
                            .andExpect(jsonPath("$.idCreator").value(userId));

    }

    @Test
    public void setPassKey() throws Exception {

            String url = baseUrl + "/setPasskey";
            String clubName = "clubName";
            String passKey = "pass";

            String token = TestUtils.getToken(mockMvc, "johndoe");
            TestUtils.addClub(mockMvc, clubName, token);
            TestUtils.joinClub(mockMvc, clubName, token);

            String json = new JSONObject()
                            .put("clubName", clubName)
                            .put("passkey", passKey)
                            .toString();

            mockMvc.perform(MockMvcRequestBuilders.post(url)
                            .contentType(MediaType.APPLICATION_JSON)
                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                            .content(json))
                            .andExpect(status().isOk());


                            String joinWithPasskey = new JSONObject()
                            .put("clubName", clubName)
                            .put("passkey", passKey)
                            .toString();

                            mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club/join")
                                            .contentType(MediaType.APPLICATION_JSON)
                                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "JohanDoey"))
                                            .content(joinWithPasskey))
                                            .andExpect(status().isOk())
                                            .andExpect(jsonPath("$.message").exists());

    }


    @Test
    public void joinWithInvalidPasskey() throws Exception {

            String url = baseUrl + "/setPasskey";
            String clubName = "clubName";
            String passKey = "pass";

            String token = TestUtils.getToken(mockMvc, "johndoe");
            TestUtils.addClub(mockMvc, clubName, token);
            TestUtils.joinClub(mockMvc, clubName, token);

            String json = new JSONObject()
                            .put("clubName", clubName)
                            .put("passkey", passKey)
                            .toString();

            mockMvc.perform(MockMvcRequestBuilders.post(url)
                            .contentType(MediaType.APPLICATION_JSON)
                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                            .content(json))
                            .andExpect(status().isOk());


                            String joinWithPasskey = new JSONObject()
                            .put("clubName", clubName)
                            .put("passkey", "passKey")
                            .toString();

                            mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club/join")
                                            .contentType(MediaType.APPLICATION_JSON)
                                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "JohanDoey"))
                                            .content(joinWithPasskey))
                                            .andExpect(status().isBadRequest());

    }


    @Test
    public void tryToChangePasskeyWithoutClubAdminRole() throws Exception {

            String url = baseUrl + "/setPasskey";
            String clubName = "clubName";
            String passKey = "pass";

            String token = TestUtils.getToken(mockMvc, "johndoe");
            TestUtils.addClub(mockMvc, clubName, token);
            TestUtils.joinClub(mockMvc, clubName, token);

            String json = new JSONObject()
                            .put("clubName", clubName)
                            .put("passkey", passKey)
                            .toString();

            mockMvc.perform(MockMvcRequestBuilders.post(url)
                            .contentType(MediaType.APPLICATION_JSON)
                            .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "NotClubAdmin"))
                            .content(json))
                            .andExpect(status().isForbidden());

    }

    @Test
    public void getAll() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.get(getAllUrl))
                .andExpect(status().isOk());

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
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value(clubName));

        // gets club
        mockMvc.perform(MockMvcRequestBuilders.get(baseUrl + "/" + clubName))
                .andExpect(status().isOk())
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
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value(clubName));

        // join club
        mockMvc.perform(MockMvcRequestBuilders.post(authUrl + "/" + "join")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content("{" + "\"clubName\":\"" + clubName + "\"" + "}"))
                .andExpect(status().isOk());
    }

}