package com.omas.webapp.service;

import com.omas.webapp.config.FileStorageProperties;
import com.omas.webapp.repository.FileRepository;
import com.omas.webapp.repository.TeamMemberScoreRepository;
import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.TeamMemberId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class FileService {

    @Autowired
    private FileRepository fileRepository;

    @Autowired
    private TeamMemberScoreRepository teamMemberScoreRepository;

    private final Path fileDirectory;

    public FileService(FileStorageProperties properties) throws IOException {
        this.fileDirectory = Paths.get(properties.getPath()).toAbsolutePath().normalize();
        Files.createDirectories(this.fileDirectory);
    }

    /**
     * Receive and write a file to the file folder
     * @throws IOException if something goes wrong while processing the file
     */
    public void receiveAndWriteFileFully(TeamMemberId teamMemberId, MultipartFile file) throws IOException {
        this.fileRepository.save(new ImageProof(teamMemberId, file.getBytes()));
    }

    /**
     * Get the file associated with the provided team member
     * @param teamMemberId the id name of the file
     * @return the file bytes to be sent or null if no file was found at the location
     */
    public Optional<Resource> getFile(TeamMemberId teamMemberId) {
        return this.fileRepository.findById(teamMemberId).map(ImageProof::getImageResource);
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
