package com.omas.webapp.controller;

import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.nio.file.FileAlreadyExistsException;
import java.util.List;

@RestController
@RequestMapping("/api/file")
public class FileController {

    @Autowired
    private FileService service;

    // public static final int MEGABYTE = 1_000_000;
    // public static final int MAX_FILE_SIZE = 8 * MEGABYTE;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/upload")
    public ResponseEntity<?> uploadFiles(
        @RequestParam("competitionId") String competitionId,
        @RequestParam("file") MultipartFile file
    ) {

        // Most likely will be removed later once I know how Spring configurations fully work
        // Namely the following in application.properties:
        // spring.servlet.multipart.max-file-size=10MB
        // spring.servlet.multipart.max-request-size=10MB
        // server.tomcat.max-swallow-size=100MB
        /*if (file.getSize() > MAX_FILE_SIZE) {
            return new MessageResponse("The image you tried to upload is too large", HttpStatus.BAD_REQUEST);
        }*/

        try {
            // This naming may be confusing but the idea is that here the server is downloading the image uploaded by the user
            service.receiveAndWriteFileFully(competitionId, file);
        } catch (FileAlreadyExistsException ex) {
            return new MessageResponse("Could not upload an image with that file name: The file already exists.", HttpStatus.BAD_REQUEST);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new MessageResponse("Something went wrong with uploading the image: " + ex.getMessage(), HttpStatus.BAD_REQUEST);
        }

        return new MessageResponse("File uploaded successfully", HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping("/download/{fileName}")
    public ResponseEntity<?> downloadFile(@PathVariable String fileName) {

        try {
            return new ResponseEntity<>(service.getFile(fileName), HttpStatus.OK);
        } catch (FileNotFoundException ex) {
            return new MessageResponse("The requested file could not be found", HttpStatus.BAD_REQUEST);
        } catch (Exception ex) {
            return new MessageResponse("Downloading the file failed: " + ex.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping("/files")
    public List<String> getFileNames() {
        return service.getFiles();
    }

}
