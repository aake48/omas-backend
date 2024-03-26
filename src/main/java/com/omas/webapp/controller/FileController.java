package com.omas.webapp.controller;

import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.service.FileService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.FileAlreadyExistsException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/file")
public class FileController {

    @Autowired
    private FileService fileService;

    @Autowired
    private TeamMemberScoreService scoreService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/upload")
    public ResponseEntity<?> uploadFiles(
        @RequestParam("competitionId") String competitionId,
        @RequestParam("file") MultipartFile file
    ) {

        Long userId = UserInfoDetails.getDetails().getId();
        TeamMemberScore score = this.scoreService.getUsersScore(userId, competitionId);

        if (score == null) {
            return new MessageResponse("Could not find a score to associate this image with", HttpStatus.BAD_REQUEST);
        }

        try {
            // This naming may be confusing but the idea is that here the server is downloading the image uploaded by the user
            this.fileService.receiveAndWriteFileFully(score.getTeamMemberId(), file);
        } catch (FileAlreadyExistsException ex) {
            return new MessageResponse("Could not upload an image with that file name: The file already exists.", HttpStatus.BAD_REQUEST);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new MessageResponse("Something went wrong with uploading the image: " + ex.getMessage(), HttpStatus.BAD_REQUEST);
        }

        return new MessageResponse("File uploaded successfully", HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping("/download")
    public ResponseEntity<?> downloadFile(@RequestBody TeamMemberId teamMemberId) {

        Optional<Resource> file = this.fileService.getFile(teamMemberId);

        if (file.isEmpty()) {
            return new MessageResponse("The requested file could not be found", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(file.get(), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping("/files")
    public List<String> getFileNames() {
        return this.fileService.getFiles();
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public String handleValidationExceptions(
        HttpMessageNotReadableException ex) {

        ex.printStackTrace();

        return ex.getMessage();
    }

}
