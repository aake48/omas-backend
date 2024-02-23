package com.omas.webapp;

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

}
