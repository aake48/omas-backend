package com.omas.webapp;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import com.fasterxml.jackson.databind.JsonNode;
import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.test.web.servlet.MockMvc;

public class TestUtils {

        public static final String ADMIN_USERNAME = Constants.adminUsername;
        public static final String ADMIN_PASSWORD = Constants.adminPassword;


        public static final String rifleCompetitionType = Constants.rifleType;
        public static final String pistolCompetitionType = Constants.pistolType;

        public static String getToken(MockMvc mockMvc, String username) throws Exception {

                registerUser(mockMvc, username);
                return loginUser(mockMvc, username);
        }

        public static String registerUser(MockMvc mockMvc, String username) throws Exception {

                String json = new JSONObject()
                                .put("password", "password123")
                                .put("username", username)
                                .put("name", "name")
                                .put("email", "email@"+username+".com")
                                .toString();

                MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(json))
                                .andReturn();

                return mvcResult.getResponse().getContentAsString();
        }


        /**
         * Shorthand method to login as admin
         * @return the admin authorization token
         */
        public static String loginAdmin(MockMvc mvc) throws Exception {
                return login(mvc, ADMIN_USERNAME, ADMIN_PASSWORD);
        }

        public static String login(MockMvc mockMvc, String username, String password) throws Exception {

                String json = Json.objectNode()
                    .put("username", username)
                    .put("password", password)
                    .toString();

                String response = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                        .andExpect(status().isOk())
                        .andReturn()
                        .getResponse()
                        .getContentAsString();

                JsonNode node = Json.parse(response);

                String token = node.get("token").asText();

                System.out.println("Logging in " + username + ":" + password + " with token " + token);

                return token;
        }

        public static String loginUser(MockMvc mockMvc, String username) throws Exception {

                String json = new JSONObject().put("password", "password123").put("username", username).toString();

                MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(json))
                                .andExpect(status().isOk())
                                .andReturn();

                String token = new JSONObject(mvcResult.getResponse().getContentAsString()).getString("token");
                return token;
        }

        public static String addClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {

                String json = new JSONObject().put("clubName", clubName).toString();

                return mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club/new")
                                .header("Authorization", "Bearer " + userToken)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(json))
                                .andReturn()
                                .getResponse().getContentAsString();
        }

        public static String joinClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {
                String json = new JSONObject().put("clubName", clubName).toString();

                return mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club" + "/" + "join")
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + userToken)
                                .content(json))
                                .andExpect(status().isOk())
                                .andReturn()
                                .getResponse().getContentAsString();

        }

        public static void addTeam(MockMvc mockMvc, String competitionName, String teamName, String userToken) throws Exception {

                final String url = "/api/competition/team/new";
                String json = new JSONObject()
                .put("competitionName", competitionName)
                .put("teamName", teamName)
                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + userToken)
                                .content(json))
                                .andExpect(status().isOk())
                                .andReturn()
                                .getResponse().getContentAsString();
        }

        public static void addTeamMember(MockMvc mockMvc, String competitionName, String teamName, String userToken)
                        throws Exception {

                final String url = "/api/competition/team/member/add";
                String json = new JSONObject()
                                .put("competitionName", competitionName)
                                .put("teamName", teamName)
                                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + userToken)
                                .content(json))
                                .andExpect(status().isOk())
                                .andReturn()
                                .getResponse().getContentAsString();
        }

        public static String addRifleCompetition(MockMvc mockMvc, String competitionName, String userToken)
                        throws Exception {

                final String url = "/api/auth/competition/new";

                String json = new JSONObject()
                .put("competitionName", competitionName)
                .put("competitionType", rifleCompetitionType)
                .toString();
                

                return mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                                .content(json))
                                .andReturn()
                                .getResponse().getContentAsString();
        }

        public static List<Double> give60shots() {
                Random rand = new Random();
                List<Double> shots = new ArrayList<>();

                for (int i = 0; i < 60; i++) {
                        shots.add(rand.nextDouble() * 10.9);
                }
                return shots;

        }

        public static String addScores(MockMvc mockMvc, String competitionName, String teamName, String userToken) throws Exception {

                final String url = "/api/competition/team/member/score/add";

                List<Double> shots = give60shots();
                ObjectMapper mapper = new ObjectMapper();
                String postScoreJson = mapper.writeValueAsString(Map.of(
                                "competitionName", competitionName,
                                "teamName",teamName,
                                "scoreList", shots));

                return mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + userToken)
                                .content(postScoreJson))
                                .andExpect(status().isOk())
                                .andReturn()
                                .getResponse()
                                .getContentAsString();
        }

        public static String getRandomString() {
                int length = 10;
                String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
                Random rand = new Random();
                StringBuilder sb = new StringBuilder(length);
        
                for (int i = 0; i < length; i++) {
                    int randomIndex = rand.nextInt(characters.length());
                    sb.append(characters.charAt(randomIndex));
                }
        
                return sb.toString();
            }

        /**
         * Sets up users, club, competition, and adds scores with one method.
         */
        public static void setupScores(MockMvc mockMvc, String clubName, String teamName, String competitionName)
                        throws Exception {

                ArrayList<String> userTokens = new ArrayList<>();
                for (int i = 0; i < 5; i++) {
                        String random1 = getRandomString();
                        String user1 = getToken(mockMvc, random1);
                        userTokens.add(user1);
                }

                // create club
                addClub(mockMvc, clubName, userTokens.get(0));

                // join users to club
                for (String token : userTokens) {
                        joinClub(mockMvc, clubName, token);
                }

                // create competition
                addRifleCompetition(mockMvc, competitionName, userTokens.get(0));

                // add team for club
                addTeam(mockMvc, competitionName, teamName, userTokens.get(0));

                // add team members
                for (String token : userTokens) {
                        addTeamMember(mockMvc, competitionName, teamName, token);
                }

                // add scores
                for (String token : userTokens) {
                        addScores(mockMvc, competitionName, teamName, token);
                }

        }

}