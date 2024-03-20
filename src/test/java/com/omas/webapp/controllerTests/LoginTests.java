package com.omas.webapp.controllerTests;

import com.omas.webapp.Json;
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

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class LoginTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String url = "/api/login";

        @BeforeEach
        private void registerUser() throws Exception {
                TestUtils.getToken(mockMvc, "johndoe");
        }

        void login() throws Exception {
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"password123\","
                                                + "\"username\":\"johndoe\""
                                                + "}"))
                                .andExpect(status().isOk()).andExpect(jsonPath("$.token").exists());

        }

        @Test
        void registerAndDeleteUser() throws Exception {

                String url = "/api/delete";

                String json = Json.objectNode()
                    .put("password", "password123")
                    .put("username", "testuser")
                    .put("name", "testname")
                    .put("email", "testuser@testmail.com")
                    .toString();

                String registrationResponse = mockMvc.perform(MockMvcRequestBuilders.post("/api/reg")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                        .andExpect(status().isOk())
                        .andReturn()
                        .getResponse()
                        .getContentAsString();

                System.out.println("registrationResponse: " + registrationResponse);

                String adminToken = TestUtils.loginAdmin(mockMvc);

                String deletionResponse = mockMvc.perform(MockMvcRequestBuilders.delete(url)
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + adminToken)
                        .content("testuser"))
                        .andExpect(status().isOk())
                        .andReturn()
                        .getResponse()
                        .getContentAsString();

                System.out.println("deletionResponse: " + deletionResponse);
        }

        @Test
        void IncorrectCapitalizedLetterInPassword() throws Exception {

                TestUtils.getToken(mockMvc, "johndoe");

                login();

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

                login();

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

                login();

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

                login();

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

                login();

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

                login();

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
