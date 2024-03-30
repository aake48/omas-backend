package com.omas.webapp.controllerTests;

import com.omas.webapp.TestUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.json.JSONObject;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class LoginTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String url = "/api/login";

        private String username = "johndoe";

        @BeforeEach
        private void registerUser() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");
        }

        @Test
        void login() throws Exception {

                String json = new JSONObject()
                                .put("password", "password123")
                                .put("username", username)
                                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(json))
                                .andExpect(status().isOk())
                                .andExpect(jsonPath("$.token").exists())
                                .andExpect(jsonPath("$.user").exists())
                                .andExpect(jsonPath("$.user.username").value(username))
                                .andExpect(jsonPath("$.user.legalName").value(username))
                                .andExpect(jsonPath("$.user.club").isEmpty())
                                .andExpect(jsonPath("$.user.userId").exists())
                                .andExpect(jsonPath("$.user.roles").exists())
                                .andExpect(jsonPath("$.user.email").exists())
                                .andExpect(jsonPath("$.user.creationDate").exists());

        }



        @Test
        void IncorrectCapitalizedLetterInPassword() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // Incorrectly Capitalized first letter of password
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"Password123\","
                                                + "\"username\":\"johndoe\""
                                                + "}"))
                                .andExpect(status().isForbidden())
                                .andExpect(jsonPath("$.message").value("Bad credentials"));

        }

        @Test
        void IncorrectWhitespaceInPassword() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // Incorrect whitespace before password
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\" password123\","
                                                + "\"username\":\"johndoe\""
                                                + "}"))
                                .andExpect(status().isForbidden())
                                .andExpect(jsonPath("$.message").value("Bad credentials"));

        }

        @Test
        void IncorrectWhitespaceInUsername() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // Incorrect whitespace in Username
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"password123\","
                                                + "\"username\":\"Johndoe \""
                                                + "}"))
                                .andExpect(status().isForbidden())
                                .andExpect(jsonPath("$.message").value("Bad credentials"));
        }

        @Test
        void IncorrectCapitalizedLetterInUsername() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // Incorrectly Capitalized Username
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"password123\","
                                                + "\"username\":\"JohndoE\""
                                                + "}"))
                                .andExpect(status().isForbidden())
                                .andExpect(jsonPath("$.message").value("Bad credentials"));
        }

        @Test
        void missingPassword() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // missingPassword
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"\","
                                                + "\"username\":\"Johndoe\""
                                                + "}"))
                                .andExpect(status().isBadRequest()).andExpect(jsonPath("$.password").exists());
        }

        @Test
        void missingUsername() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                // missingUsername
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"password123\","
                                                + "\"username\":\"\""
                                                + "}"))
                                .andExpect(status().isBadRequest()).andExpect(jsonPath("$.username").exists());
        }
}
