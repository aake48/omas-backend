package com.omas.webapp;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import org.springframework.test.web.servlet.MockMvc;

public class TestUtils {

    // The 10 most common male names and 10 most common female names as of 1.4.2024
    // additionally the names of people involved in this project
    public static final List<String> FINNISH_FIRST_NAMES = List.of(
        "Juhani", "Johannes", "Olavi", "Antero",
        "Tapani", "Kalevi", "Tapio", "Matti", "Mikael", "Ilmari",
        "Maria", "Helena", "Johanna", "Anneli", "Kaarina",
        "Marjatta", "Anna", "Liisa", "Sofia", "Annikki",
        "Lauri", "Ville", "Ari", "Janne", "Lassi", "Antti",
        "Markus", "Teemu", "Walter"
    );

    // The 10 most common Finnish last names as of 1.4.2024
    // and the last names of people involved with this project
    public static final List<String> FINNISH_LAST_NAMES = List.of(
        "Korhonen", "Virtanen", "Mäkinen",
        "Nieminen", "Mäkelä", "Hämäläinen",
        "Laine", "Heikkinen", "Koskinen",
        "Järvinen", "Lehtinen", "Holappa",
        "Komulainen", "Ollakka", "Juustila",
        "Kumpulainen", "Kelanti", "Määttä"
    );

    public static String generateRandomName() {

        ThreadLocalRandom random = ThreadLocalRandom.current();

        String firstName = FINNISH_FIRST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));
        String lastName = FINNISH_LAST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));

        return firstName + " " + lastName;
    }

    public static String getToken(MockMvc mockMvc, String username) throws Exception {

        registerUser(mockMvc, username, "password123");
        return new JSONObject(loginUser(mockMvc, username, "password123")).getString("token");
    }

    public static String registerUser(MockMvc mockMvc, String username, String password) throws Exception {

        String json = new JSONObject()
            .put("password", password)
            .put("username", username)
            .put("name", username)
            .put("email", "email@" + username + ".com")
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
            .put("competitionType", Constants.RIFLE_TYPE)
            .put("startDate", System.currentTimeMillis() - 8 * 60 * 60 * 1000)
            .toString();

        return mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc, "johndoe"))
                .content(json))
            .andReturn()
            .getResponse().getContentAsString();
    }

    public static double give60shots() {

        double sum = 0.0;

        for (int i = 0; i < 60; i++) {
            sum += ThreadLocalRandom.current().nextDouble() * 10.9;
        }

        return sum;
    }

    public static String addScores(MockMvc mockMvc, String competitionName, String teamName, String userToken) throws Exception {

        final String url = "/api/competition/team/member/score/add/sum";

        double score = give60shots();

        String postScoreJson = new JSONObject()
            .put("competitionName", competitionName)
            .put("teamName", teamName)
            .put("score", score)
            .put("bullsEyeCount", 10)
            .toString();

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

    public static void setUserToTeam(MockMvc mockMvc, String token, String club, String competition, String team) throws Exception {
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