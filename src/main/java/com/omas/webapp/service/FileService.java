package com.omas.webapp.service;

import com.omas.webapp.repository.FileRepository;
import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.TeamMemberId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class FileService {

    @Autowired
    private FileRepository fileRepository;

    /**
     * Receive and write a file to the file folder
     * @throws IOException if something goes wrong while processing the file
     */
    public void receiveAndWriteFileFully(TeamMemberId teamMemberId, MultipartFile file) throws IOException {

        String fileName = file.getOriginalFilename();

        if (fileName != null) {

            int index = fileName.lastIndexOf('/');

            if (index > 0) {
                fileName = fileName.substring(index);
            }

        } else {
            fileName = UUID.randomUUID().toString();
        }

        this.fileRepository.save(new ImageProof(teamMemberId, fileName, file.getBytes()));
    }

    /**
     * Get the file associated with the provided {@link TeamMemberId}
     * @param teamMemberId the id name of the file
     * @return the file bytes to be sent or null if no file was found at the location
     */
    @Transactional
    public List<ImageProof> getFiles(TeamMemberId teamMemberId) {
        return this.fileRepository.findByTeamMemberId(teamMemberId);
    }

    /**
     * Get a single file associated with the provided {@link TeamMemberId} by its file name.
     * @param teamMemberId the id of the team member the image is associated with
     * @param fileName the file name
     * @return one image
     */
    @Transactional
    public Optional<ImageProof> getFile(TeamMemberId teamMemberId, String fileName) {
        return this.fileRepository.findByTeamMemberIdAndFileName(teamMemberId, fileName);
    }

    /**
     * Get all file names associated with the provided {@link TeamMemberId}.
     * @param teamMemberId the id of the team member
     * @return a list of strings
     */
    public List<String> getFileNames(TeamMemberId teamMemberId) {
        return this.fileRepository.findByTeamMemberId(teamMemberId).stream().map(ImageProof::getFileName).collect(Collectors.toList());
    }

}
