package com.omas.webapp.service;

import com.omas.webapp.repository.ClubRepository;
import com.omas.webapp.table.Club;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubService {

    @Autowired
    private ClubRepository repository;

    public Club registerClub(Club club) {

        if (repository.findByName(club.getName()).isPresent()) {
            return null;
        }
        return repository.save(club);

    }

    public Club getClub(String name) {

        return repository.findByName(name).get();

    }

}
