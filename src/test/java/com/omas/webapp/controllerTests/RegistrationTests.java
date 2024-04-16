package com.omas.webapp.controllerTests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.springframework.http.MediaType;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class RegistrationTests {

    @Autowired
    private MockMvc mockMvc;

    private static final String url = "/api/reg";

    @Test
    void testRegistration() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"password123\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"johndoe\""
                    + "}"));
    }

    @Test
    void missingUsername() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"password123\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.username").exists());

    }

    @Test
    void missingPassword() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"johndoe\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.password").exists());

    }

    @Test
    void missingEmail() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"\","
                    + "\"password\":\"password\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"johndoe\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.email").exists());

    }

    @Test
    void missingName() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"password\","
                    + "\"name\":\"\","
                    + "\"username\":\"johndoe\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.name").exists());

    }

    @Test
    void shortUsername() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"password\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"jo\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.username").exists());

    }

    @Test
    void shortPassword() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user@example.com\","
                    + "\"password\":\"pa\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"johndoe\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.password").exists());

    }

    @Test
    void badEmail() throws Exception {

        mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{"
                    + "\"email\":\"user.com\","
                    + "\"password\":\"pa\","
                    + "\"name\":\"johndoe\","
                    + "\"username\":\"johndoe\""
                    + "}"))
            .andExpect(status().isBadRequest()).andExpect(jsonPath("$.email").exists());

    }

}