package com.omas.webapp.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.Competition;

public interface CompetitionRepository extends JpaRepository<Competition, String> { 
    
    Page<Competition> findByCompetitionIdContaining(String name, PageRequest pageRequest);
}
