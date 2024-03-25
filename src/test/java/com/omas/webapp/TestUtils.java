package com.omas.webapp;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
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

                registerUser(mockMvc, username, "password123");
                return new JSONObject(loginUser(mockMvc, username, "password123")).getString("token");
        }

        public static String registerUser(MockMvc mockMvc, String username, String password) throws Exception {

                String json = new JSONObject()
                                .put("password", password)
                                .put("username", username)
                                .put("name", username)
                                .put("email", "email@"+username+".com")
                                .toString();

                MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(json))
                                .andReturn();

                return mvcResult.getResponse().getContentAsString();
        }





        public static String loginUser(MockMvc mockMvc, String username, String password) throws Exception {

                String json = new JSONObject().put("password", password).put("username", username).toString();

                String result = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(json))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();

                return result;
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
                                .andReturn()
                                .getResponse().getContentAsString();
        }

        public static void joinTeam(MockMvc mockMvc, String competitionName, String teamName, String userToken) throws Exception {

                final String url = "/api/competition/team/member/add";
                String json = new JSONObject()
                .put("competitionName", competitionName)
                .put("teamName", teamName)
                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + userToken)
                                .content(json))
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

            private static List<String> getUserTokens(MockMvc mockMvc, int ammountOfTokens) throws Exception {

                    List<String> userTokens = new ArrayList<>();

                    for (int i = 0; i < ammountOfTokens; i++) {
                            String random1 = getRandomString();
                            String user1 = getToken(mockMvc, random1);
                            userTokens.add(user1);
                    }
                    return userTokens;
            }

            public static void setUserToTeam(MockMvc mockMvc, String token,  String club, String competition, String team) throws Exception{
                addClub(mockMvc, club, token);
                joinClub(mockMvc, club, token);
                addRifleCompetition(mockMvc, competition, token);
                addTeam(mockMvc, competition, team, token);
            }

            /**
             * Sets up a competition and adds a club, team, teamMembers, and
             * teamMemberScores for every club.
             * Each club is assigned a team that inherits its name from the club's name.
             * Each team is assigned as many team members as specified by teamSize.
             * If a competition with the given name does not exist, it will be created.
             * If it does exist, this method will continue to add the given clubs to this
             * competition with their respective teams.
             */
        public static void setupScores(MockMvc mockMvc, List<String> clubs, String competitionName, int teamSize)
                        throws Exception {

                // create competition
                addRifleCompetition(mockMvc, competitionName, getToken(mockMvc, "johnDoe"));

                for (String clubName : clubs) {
                        List<String> userTokens = getUserTokens(mockMvc, teamSize);
                        addClub(mockMvc, clubName, userTokens.get(0));

                        // join users to club
                        for (String token : userTokens) {
                                joinClub(mockMvc, clubName, token);
                        }

                        // add team for club
                        addTeam(mockMvc, competitionName, clubName, userTokens.get(0));

                        // add team members
                        for (String token : userTokens) {
                                addTeamMember(mockMvc, competitionName, clubName, token);
                        }

                        // add scores
                        for (String token : userTokens) {
                                addScores(mockMvc, competitionName, clubName, token);
                        }
                }

        }

}