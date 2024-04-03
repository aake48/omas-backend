package com.omas.webapp.controllerTests;

import com.omas.webapp.Constants;
import com.omas.webapp.TestUtils;
import org.apache.tomcat.util.http.fileupload.MultipartStream;
import org.json.JSONObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.concurrent.ThreadLocalRandom;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
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
    private static JSONObject user;
    private static String userToken;

    @BeforeEach
    private void registerUser() throws Exception {

        JSONObject loginResponse = new JSONObject(TestUtils.loginUser(mockMvc, Constants.adminUsername, Constants.adminPassword));

        adminUser = loginResponse.getJSONObject("user");
        adminToken = loginResponse.getString("token");

        TestUtils.registerUser(mockMvc, "sometestuser", "password123");

        JSONObject userLoginResponse = new JSONObject(TestUtils.loginUser(mockMvc, "sometestuser", "password123"));

        user = userLoginResponse.getJSONObject("user");
        userToken = userLoginResponse.getString("token");
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
        TestUtils.joinClub(mockMvc, "kuvaseura", userToken);
        TestUtils.addTeam(mockMvc, competitionId, teamName, adminToken);
        TestUtils.joinTeam(mockMvc, competitionId, teamName, userToken);
        TestUtils.addScores(mockMvc, competitionId, teamName, userToken);

        HashMap<String, byte[]> fileMap = new HashMap<>();

        int fileSize = 1_000_000;

        for (int i = 0; i < 6; i++) {

            // Generate 1000000 random bytes to send to the server
            byte[] randomBytes = new byte[fileSize];

            ThreadLocalRandom.current().nextBytes(randomBytes);

            String fileName = "myimage_" + i + ".png";

            MockMultipartFile file = new MockMultipartFile("file", fileName, "application/octet-stream", randomBytes);
            fileMap.put(fileName, randomBytes);

            String uploadResponse = mockMvc.perform(MockMvcRequestBuilders.multipart(uploadUrl)
                    .file(file)
                    // Upload as user
                    .header("Authorization", "Bearer " + userToken)
                    .param("competitionId", competitionId))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();

            System.out.println("uploadResponse: " + uploadResponse);
        }

        String teamMemberId = new JSONObject()
            .put("userId", user.getLong("userId"))
            .put("competitionId", competitionId)
            .put("teamName", teamName)
            .toString();

        // Download the first file in the list, it should match the file we just uploaded
        MockHttpServletResponse downloadResponse = mockMvc.perform(MockMvcRequestBuilders.get(downloadUrl)
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(teamMemberId))
                .andReturn()
                .getResponse();

        // Get the boundary from the Content-Type headers
        String contentType = downloadResponse.getHeader("Content-Type");
        // the Content-Type header should contain something like
        // multipart/form-data;boundary=34aP8kfR4FcO1eRV-v-eFgSeHJLYsmnJWVUpiihM
        // the boundary value is not always the same, so we need to parse it here
        String boundary = contentType.substring(contentType.indexOf("boundary=") + 9);

        System.out.println("contentType: " + contentType);
        System.out.println("boundary: " + boundary);

        byte[] bytes = downloadResponse.getContentAsByteArray();

        MultipartStream stream = new MultipartStream(new ByteArrayInputStream(bytes), boundary.getBytes(StandardCharsets.UTF_8), null);

        boolean nextPart = stream.skipPreamble();

        int index = 1;

        while (nextPart) {

            ByteArrayOutputStream output = new ByteArrayOutputStream();
            String partHeaders = stream.readHeaders();

            int nameIndex = partHeaders.indexOf("name=\"") + 6;
            String fileName = partHeaders.substring(nameIndex, partHeaders.indexOf("\"", nameIndex));

            System.out.println("\n\nHeaders " + index + ":\n" + partHeaders);

            stream.readBodyData(output);

            System.out.println("Body " + index + ":\nBytes: " + output.size());
            assertEquals(fileSize, output.size(), "Sent data and received data should be the same length");
            assertArrayEquals(fileMap.get(fileName), output.toByteArray(), "Array content should remain the same");

            nextPart = stream.readBoundary();
            index++;
        }
    }



}
