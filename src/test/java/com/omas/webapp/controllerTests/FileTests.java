package com.omas.webapp.controllerTests;

import com.omas.webapp.Constants;
import com.omas.webapp.TestUtils;
import org.json.JSONObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import java.util.concurrent.ThreadLocalRandom;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
public class FileTests {

    @Autowired
    private MockMvc mockMvc;

    private static final String baseUrl = "/api/file";

    private static JSONObject adminUser;
    private static String adminToken;

    @BeforeEach
    private void registerUser() throws Exception {

        JSONObject loginResponse = new JSONObject(TestUtils.loginUser(mockMvc, Constants.adminUsername, Constants.adminPassword));

        adminUser = loginResponse.getJSONObject("user");
        adminToken = loginResponse.getString("token");
    }

    @Test
    public void uploadAndDownloadFile() throws Exception {

        String uploadUrl = baseUrl + "/upload";
        String downloadUrl = baseUrl + "/download";

        String competitionId = "kuvanlatauskilpailu";
        String teamName = "kuvajoukkue";

        TestUtils.addRifleCompetition(mockMvc, competitionId, adminToken);
        TestUtils.addClub(mockMvc, "kuvaseura", adminToken);
        TestUtils.joinClub(mockMvc, "kuvaseura", adminToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.addScores(mockMvc, competitionId, teamName, adminToken);

        // Generate 1000 random bytes to send to the server
        byte[] randomBytes = new byte[1000];

        ThreadLocalRandom.current().nextBytes(randomBytes);

        MockMultipartFile file = new MockMultipartFile("file", "myimage.png", "application/octet-stream", randomBytes);

        String uploadResponse = mockMvc.perform(MockMvcRequestBuilders.multipart(uploadUrl)
                .file(file)
                // Admin is also a user
                .header("Authorization", "Bearer " + adminToken)
                // Currently there is no validation for the competition
                // It will be added soon
                .param("competitionId", competitionId))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();

        System.out.println("uploadResponse: " + uploadResponse);

        String teamMemberId = new JSONObject()
            .put("userId", adminUser.getLong("userId"))
            .put("competitionId", competitionId)
            .put("teamName", teamName)
            .toString();

        // Download the first file in the list, it should match the file we just uploaded
        byte[] downloadResponse = mockMvc.perform(MockMvcRequestBuilders.get(downloadUrl)
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(teamMemberId))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsByteArray();

        assertEquals(downloadResponse.length, randomBytes.length, "Sent data and received data should be the same length");
    }

}
