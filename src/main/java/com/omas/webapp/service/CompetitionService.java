package com.omas.webapp.service;

import com.omas.webapp.repository.CompetitionRepository;
import com.omas.webapp.table.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

@Service
public class CompetitionService {

    @Autowired
    private CompetitionRepository competitionRepository;


    public Competition addCompetition(Competition competition) {

        if (competitionRepository.findById(competition.getCompetitionId()).isPresent()) {
            return null;
        }

        return competitionRepository.save(competition);
    }

    /**
     * Check if the given competition is a valid competition
     * @param competitionName the name (or id) of the competition
     * @return true if the competition exists in the database and has not ended
     */
    public boolean isValidCompetition(String competitionName) {

        Optional<Competition> competition = competitionRepository.findById(competitionName);

        if (competition.isEmpty()) {
            return false;
        }

        return competition.get().getEndDate().toInstant().isBefore(Instant.now());
    }

    public boolean thisCompetitionExists(String competitionName) {
        return competitionRepository.existsById(competitionName);
    }


    public List<Competition> getAllCompetitions() {
        return competitionRepository.findAll();
    }

    public Optional<Competition> getCompetition(String name) {

        return competitionRepository.findById(name);

    }

    public Page<Competition> findWithPaginatedSearch(int page, int size, String search) {
        return competitionRepository.findByCompetitionIdContaining(search, PageRequest.of(page, size));
    }

    public Page<Competition> firstPaginated(int page, int size) {
        return competitionRepository.findAll(PageRequest.of(page, size));
    }

    public Page<Competition> findByYear(int page, int size, int year) {
        return competitionRepository.findByYear(year, PageRequest.of(page, size));
    }

    public Page<Competition> findActiveCompetitions(int page, int size) {
        return competitionRepository.findActiveCompetitions(new java.sql.Date(System.currentTimeMillis()), PageRequest.of(page, size));
    }

    public Page<Competition> findInactiveCompetitions(int page, int size) {
        return competitionRepository.findInactiveCompetitions(new java.sql.Date(System.currentTimeMillis()), PageRequest.of(page, size));
    }
}
