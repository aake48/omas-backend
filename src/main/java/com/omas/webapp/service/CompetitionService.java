package com.omas.webapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import com.omas.webapp.repository.CompetitionRepository;
import com.omas.webapp.table.Competition;

@Service
public class CompetitionService {

    @Autowired
    private CompetitionRepository repository;

    public Competition addCompetition(Competition competition) {

        if (repository.findById(competition.getName()).isPresent()) {
            return null;
        }
        return repository.save(competition);

    }

    public List<Competition> getAllCompetitions() {
        return repository.findAll();
    }

    public Optional<Competition> getCompetition(String name) {

        return repository.findById(name);

    }

    public Page<Competition> findWithPaginatedSearch(int page, int size, String search) {
        return repository.findByNameContaining(search, PageRequest.of(page, size));
    }

    public Page<Competition> firstPaginated(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }

}
