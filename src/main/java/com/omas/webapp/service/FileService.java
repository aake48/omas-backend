package com.omas.webapp.service;

import com.omas.webapp.config.FileStorageProperties;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class FileService {

    // SimpleDateFormat is not thread-safe
    private final ThreadLocal<SimpleDateFormat> dateFormat = ThreadLocal.withInitial(
        () -> new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss")
    );

    private final Path fileDirectory;

    public FileService(FileStorageProperties properties) throws IOException {
        this.fileDirectory = Paths.get(properties.getPath()).toAbsolutePath().normalize();
        Files.createDirectories(this.fileDirectory);
    }

    /**
     * Receive and write a file to the file folder
     * @throws IOException if something goes wrong while processing the file
     */
    public void receiveAndWriteFileFully(String competitionId, MultipartFile file) throws IOException {

        String userId = String.valueOf(UserInfoDetails.getDetails().getId());
        String timeStamp = this.dateFormat.get().format(new Date(System.currentTimeMillis()));
        String fileExtension = extractFileExtension(file);

        Path filePath = resolveFilePath(competitionId, userId, timeStamp, fileExtension);

        Files.copy(file.getInputStream(), filePath);
    }

    /**
     * Extract a file extension from the given {@link MultipartFile}
     * @return the extracted file extension
     */
    private String extractFileExtension(MultipartFile file) {

        // Assume whatever file extension to be the default and then attempt to parse it from the provided file name
        // TODO: See if it would be a better idea to just have no file extension when there is none
        String fileExtension = ".jpg";

        String originalName = file.getOriginalFilename();

        if (originalName != null) {

            int index = originalName.lastIndexOf('.');

            if (index > 0) {
                fileExtension = originalName.substring(index);
            }
        }

        return fileExtension;
    }

    /**
     * Build a file path out of the given information to reduce file name collisions
     * @return the built path
     */
    private Path resolveFilePath(String competitionId, String userId, String timeStamp, String fileExtension) {

        String fileName = String.join("_", timeStamp, competitionId, userId);

        Path path = this.fileDirectory.resolve(fileName + fileExtension);

        int number = 1;

        // This almost feels like overengineering
        while (path.toFile().exists()) {
            fileName = String.join("_", timeStamp, competitionId, userId, String.valueOf(number));
            path = this.fileDirectory.resolve(fileName + fileExtension);
        }

        return path;
    }

    /**
     * Get the file from the file folder
     * @param fileName the name of the file
     * @return the image bytes to be sent
     * @throws IOException if getting the file failed for some reason
     */
    public Resource getFile(String fileName) throws IOException {

        Path filePath = this.fileDirectory.resolve(fileName);

        if (!Files.exists(filePath)) {
            throw new FileNotFoundException("File named " + fileName + " could not be found");
        }

        return new ByteArrayResource(Files.readAllBytes(filePath));
    }

    /**
     * Get all the files in the directory sorted by time in descending order
     * @return the files sorted by time in descending order
     */
    public List<String> getFiles() {

        List<String> files = new ArrayList<>();

        // The Objects.requireNonNull is not 100% necessary here but
        // the editor complains about the potential NPE even though the directory will only be null
        // if it is not configured. This entire class will fail much earlier if that happens
        for (File file : Objects.requireNonNull(this.fileDirectory.toFile().listFiles())) {

            if (file.isFile()) {
                files.add(file.getName());
            }
        }

        files.sort(String.CASE_INSENSITIVE_ORDER);

        return files;
    }

}
