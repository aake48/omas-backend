package com.omas.webapp.service;

import com.omas.webapp.repository.CompetitionRepository;
import com.omas.webapp.table.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

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

    public boolean thisCompetitionExists(String competitionName){
        return competitionRepository.existsById(competitionName);
    }


    public List<Competition> getAllCompetitions() {
        return competitionRepository.findAll();
    }

    public Optional<Competition> getCompetition(String name) {

        return competitionRepository.findById(name);

    }

    public Page<Competition> findWithPaginatedSearch(int page, int size, String search) {
        return competitionRepository.findByNameContaining(search, PageRequest.of(page, size));
    }

    public Page<Competition> firstPaginated(int page, int size) {
        return competitionRepository.findAll(PageRequest.of(page, size));
    }

}
