package com.omas.webapp.service;

import com.omas.webapp.repository.ClubRepository;
import com.omas.webapp.table.Club;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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

    public List<Club> getall() {
        return repository.findAll();
    }

    public Page<Club> findWithPaginatedSearch(int page, int size, String search) {
        return repository.findByNameContaining(search, PageRequest.of(page, size));
    }

    public Page<Club> firstPaginated(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }

}
