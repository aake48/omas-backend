package com.omas.webapp.controllerTests;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import com.omas.webapp.TestUtils;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.springframework.http.MediaType;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class LoginTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String url = "/api/login";

        @BeforeEach
        private void registerUser() throws Exception {
                TestUtils.registerJohnDoe_password123(mockMvc);
        }

        void login() throws Exception {
                mockMvc.perform(MockMvcRequestBuilders.post(url)
                                .contentType(MediaType.APPLICATION_JSON)
                                .content("{"
                                                + "\"password\":\"password123\","
                                                + "\"username\":\"johndoe\""
                                                + "}"))
                                .andExpect(status().isOk()).andExpect(jsonPath("$.token").exists());
                ;
        }

        @Test
        void IncorrectCapitalizedLetterInPassword() throws Exception {

                TestUtils.registerJohnDoe_password123(mockMvc);

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

                TestUtils.registerJohnDoe_password123(mockMvc);

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

                TestUtils.registerJohnDoe_password123(mockMvc);

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

                TestUtils.registerJohnDoe_password123(mockMvc);

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

                TestUtils.registerJohnDoe_password123(mockMvc);

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

                TestUtils.registerJohnDoe_password123(mockMvc);

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
