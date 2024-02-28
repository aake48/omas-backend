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

        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                        + "\"password\":\"password123\","
                        + "\"username\":\"johndoe\""
                        + "}"))
                .andReturn();

        String token = new JSONObject(mvcResult.getResponse().getContentAsString()).getString("token");

        return token;
    }

    public static String registerJohnDoe_password123(MockMvc mockMvc) throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                        + "\"email\":\"user@example.com\","
                        + "\"password\":\"password123\","
                        + "\"name\":\"John Doe\","
                        + "\"username\":\"johndoe\""
                        + "}"))
                .andReturn();

        return mvcResult.getResponse().getContentAsString();
    }

    public static String addClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club/new").header("Authorization", "Bearer "+ userToken)
                .contentType(MediaType.APPLICATION_JSON)
                        .content("{"
                                + "\"clubName\":\""+clubName+"\""
                                + "}"))
                        .andReturn();

        return mvcResult.getResponse().getContentAsString();
    }

        public static void joinClub(MockMvc mockMvc, String clubName, String userToken) throws Exception {
                mockMvc.perform(MockMvcRequestBuilders.post("/api/auth/club" + "/" + "join")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content("{" + "\"clubName\":\"" + clubName + "\"" + "}"))
                .andExpect(status().isOk());
        
    }

    public static void addTeam(MockMvc mockMvc, String competitionName, String userToken) throws Exception {

         final String url = "/api/competition/team/new";


         mockMvc.perform(MockMvcRequestBuilders.post(url)
         .contentType(MediaType.APPLICATION_JSON)
         .header("Authorization", "Bearer " + userToken)
         .content("{" + "\"competitionName\":\"" + competitionName + "\"" + "}"))
         .andExpect(status().isOk());
}

public static void addCompetition(MockMvc mockMvc, String competitionName, String userToken) throws Exception {

        final String url = "/api/auth/competition/new";

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + TestUtils.getToken(mockMvc))
                .content("{" + "\"competitionName\":\""+competitionName+"\"" + "}"))
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