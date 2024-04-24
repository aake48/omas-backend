package com.omas.webapp.controller;

import com.omas.webapp.entity.requests.FileRequest;
import com.omas.webapp.service.FileService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.ImageProofId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.FileAlreadyExistsException;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/file")
public class FileController {

    @Autowired
    private FileService fileService;

    @Autowired
    private TeamMemberScoreService scoreService;

    @Autowired
    private TeamService teamService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/upload")
    public ResponseEntity<?> uploadFiles(
        @RequestParam("competitionId") String competitionId,
        @RequestParam("file") MultipartFile file
    ) {

        Long userId = UserInfoDetails.getDetails().getId();
        TeamMemberScore score = this.scoreService.getUsersScore(userId, competitionId);

        if (score == null) {
            return new ResponseEntity<>(Map.of("message","Could not find a score to associate this image with"), HttpStatus.BAD_REQUEST);
        }

        try {
            // This naming may be confusing but the idea is that here the server is downloading the image uploaded by the user
            this.fileService.receiveAndWriteFileFully(score.getTeamMemberId(), file);
        } catch (FileAlreadyExistsException ex) {
            return new ResponseEntity<>(Map.of("message","Could not upload an image with that file name: The file already exists."), HttpStatus.BAD_REQUEST);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(Map.of("message","Something went wrong with uploading the image: " + ex.getMessage()), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(Map.of("message","File uploaded successfully"), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/download")
    public ResponseEntity<?> downloadFile(@RequestBody FileRequest request) {

        final TeamMemberId id = request.getTeamMemberId();

        if (!this.teamService.thisUserIsTeamMember(id)) {
            return new ResponseEntity<>(Map.of("message","That team member does not exist"), HttpStatus.BAD_REQUEST);
        }

        if (this.fileService.hasNoFilesPostedByTeamMember(id)) {
            return new ResponseEntity<>(Map.of("message","That team member has not posted any files"), HttpStatus.BAD_REQUEST);
        }

        final String fileName = request.getFileName();

        final HttpHeaders headers = new HttpHeaders();
        // headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Old code commented out just in case it's still needed
        // Return all files associated with the TeamMemberId if no file name is provided
        if (fileName == null) {

            // MultiValueMap<String, Object> form = new LinkedMultiValueMap<>();

            // for (ImageProof proof : this.fileService.getFiles(id)) {
            //     form.add(proof.getFileName(), proof.getImageResource());
            // }

            // return new ResponseEntity<>(form, headers, HttpStatus.OK);
            return new ResponseEntity<>(this.fileService.getFiles(id), headers, HttpStatus.OK);

            // else statement for clarity
        } else {

            // Optional<ImageProof> file = this.fileService.getFile(id, fileName);

            // if (file.isEmpty()) {
            //     return new ResponseEntity<>("The requested file could not be found", HttpStatus.BAD_REQUEST);
            // }

            // ImageProof proof = file.get();

            // MultiValueMap<String, Object> form = new LinkedMultiValueMap<>();

            // form.add(proof.getFileName(), proof.getImageResource());

            // return new ResponseEntity<>(form, headers, HttpStatus.OK);

            Optional<ImageProof> file = this.fileService.getFile(id, fileName);

            if (file.isEmpty()) {
                return new ResponseEntity<>(Map.of("message","The requested file could not be found"), HttpStatus.BAD_REQUEST);
            }

            ImageProof proof = file.get();

            return new ResponseEntity<>(proof, headers, HttpStatus.OK);
        }

    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("/delete")
    public ResponseEntity<?> deleteFile(@RequestBody FileRequest request) {

        final TeamMemberId id = request.getTeamMemberId();

        if (!this.teamService.thisUserIsTeamMember(id)) {
            return new ResponseEntity<>(Map.of("message","That team member does not exist"), HttpStatus.BAD_REQUEST);
        }

        if (this.fileService.hasNoFilesPostedByTeamMember(id)) {
            return new ResponseEntity<>(Map.of("message","That team member has not posted any files"), HttpStatus.BAD_REQUEST);
        }

        final String fileName = request.getFileName();

        if (fileName == null) {
            return new ResponseEntity<>(Map.of("message","You must provide a file name"), HttpStatus.BAD_REQUEST);
        }

        this.fileService.deleteFileById(new ImageProofId(id, fileName));

        return new ResponseEntity<>(Map.of("message","File deleted"), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @PostMapping("files")
    public ResponseEntity<?> getFileNames(@RequestBody TeamMemberId teamMemberId) {
        return new ResponseEntity<>(this.fileService.getFileNames(teamMemberId), HttpStatus.OK);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public String handleValidationExceptions(HttpRequestMethodNotSupportedException ex) {
        ex.printStackTrace();
        return ex.getMessage();
    }

}
