package com.omas.webapp;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.MockMvc;


public class TestUtils {

    public static String getToken(MockMvc mockMvc) throws Exception {

        registerJohnDoe_password123(mockMvc);

        String json = new JSONObject()
        .put("password", "password123")
        .put("username","johndoe")
        .toString();

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(json))
                .andReturn();

        String token = new JSONObject(mvcResult.getResponse().getContentAsString()).getString("token");

        return token;
    }

    public static String registerJohnDoe_password123(MockMvc mockMvc) throws Exception {
        String json = new JSONObject()
        .put("password", "password123")
        .put("username","johndoe")
        .put("name","John Doe")
        .put("email","user@example.com")
        .toString();

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                .contentType(MediaType.APPLICATION_JSON)
                .content(json))
                .andReturn();

        return mvcResult.getResponse().getContentAsString();
    }

    public static String registerUser(MockMvc mockMvc, String username) throws Exception {

        String json = new JSONObject()
        .put("password", "password123")
        .put("username",username)
        .put("name","John Doe")
        .put("email","user@example.com")
        .toString();

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                .contentType(MediaType.APPLICATION_JSON)
                .content(json))
                .andReturn();

        return mvcResult.getResponse().getContentAsString();
    }

    public static String loginUser(MockMvc mockMvc, String username) throws Exception {

        String json = new JSONObject().put("password", "password123").put("username",username).toString();

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(json))
                .andReturn();

        String token = new JSONObject(mvcResult.getResponse().getContentAsString()).getString("token");
        return token;
    }

    public static String addClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {
        
        String json = new JSONObject().put("clubName", clubName).toString();

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club/new").header("Authorization", "Bearer "+ userToken)
                .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                        .andReturn();

        return mvcResult.getResponse().getContentAsString();
    }

        public static void joinClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {
                String json = new JSONObject().put("clubName", clubName).toString();

                mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club" + "/" + "join")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content(json))
                .andExpect(status().isOk());
        
    }

    public static void addTeam(MockMvc mockMvc, String competitionName, String userToken) throws Exception {

         final String url = "/api/competition/team/new";
         String json = new JSONObject().put("competitionName", competitionName).toString();


         mockMvc.perform(MockMvcRequestBuilders.post(url)
         .contentType(MediaType.APPLICATION_JSON)
         .header("Authorization", "Bearer " + userToken)
         .content(json))
         .andExpect(status().isOk());
}

public static void addTeamMember(MockMvc mockMvc, String competitionName, String userToken) throws Exception {

        final String url = "/api/competition/team/member/add";
        String json = new JSONObject().put("competitionName", competitionName).toString();

        mockMvc.perform(MockMvcRequestBuilders.post(url)
        .contentType(MediaType.APPLICATION_JSON)
        .header("Authorization", "Bearer " + userToken)
        .content(json))
        .andExpect(status().isOk());
}

public static void addCompetition(MockMvc mockMvc, String competitionName, String userToken) throws Exception {

        final String url = "/api/auth/competition/new";

        String json = new JSONObject().put("competitionName", competitionName).toString();


        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content(json))
                .andExpect(status().isCreated());
}

public static List<Double> give60shots() {
        Random rand = new Random();
        List<Double> shots = new ArrayList<>();

        for (int i = 0; i < 60; i++) {
                shots.add(rand.nextDouble() * 10.9);
        }
        return shots;

}

}