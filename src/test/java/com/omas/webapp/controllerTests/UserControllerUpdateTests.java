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
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.json.JSONObject;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class UserControllerUpdateTests {

        @Autowired
        private MockMvc mockMvc;

        private static final String baseUrl = "/api/";
        private static final String updateEmailUrl = baseUrl + "updateEmail";
        private static final String updatePasswordUrl = baseUrl + "updatePassword";

        String user = "johndoe";
        String initialPassword = "password123";
        String token;
        Long userId;
        String email;

        @BeforeEach
        private void registerUser() throws Exception {

                String user = "johndoe";
                String password = "password123";

                TestUtils.registerUser(mockMvc, user, password);
                String loginResponse = TestUtils.loginUser(mockMvc, user, password);
                token = new JSONObject(loginResponse).getString("token");
                JSONObject userObject = new JSONObject(loginResponse).getJSONObject("user");
                userId = userObject.getLong("userId");
                email = userObject.getString("email");

        }

        @Test
        void updateEmail() throws Exception {

                String newEmail = "newEmail@email.com";

                String json = new JSONObject()
                                .put("email", newEmail)
                                .put("password", initialPassword)
                                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(updateEmailUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content(json))
                                .andExpect(status().isOk());

                String loginResponse = TestUtils.loginUser(mockMvc, user, initialPassword);
                JSONObject userObject = new JSONObject(loginResponse).getJSONObject("user");
                Long userId2 = userObject.getLong("userId");
                String respEmail = userObject.getString("email");

                assertTrue(respEmail.equals(newEmail));

                assertTrue(userId.equals(userId2));

        }

        @Test
        void updatePassword() throws Exception {

                String newPassowrd = "salasana1";

                String json = new JSONObject()
                                .put("newPassword", newPassowrd)
                                .put("oldPassword", initialPassword)
                                .toString();

                mockMvc.perform(MockMvcRequestBuilders.post(updatePasswordUrl)
                                .contentType(MediaType.APPLICATION_JSON)
                                .header("Authorization", "Bearer " + token)
                                .content(json))
                                .andExpect(status().isOk());

                // loginUser() asserts that status().isOk()
                String resp = TestUtils.loginUser(mockMvc, user, newPassowrd);

                JSONObject userObject = new JSONObject(resp).getJSONObject("user");
                Long userId2 = userObject.getLong("userId");
                assertTrue(userId2.equals(userId));
        }
}
