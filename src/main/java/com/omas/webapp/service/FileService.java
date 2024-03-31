package com.omas.webapp.service;

import com.omas.webapp.repository.FileRepository;
import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.TeamMemberId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

@Service
public class FileService {

    @Autowired
    private FileRepository fileRepository;

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

}
