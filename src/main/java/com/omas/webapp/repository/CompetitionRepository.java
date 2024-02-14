package com.omas.webapp.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.Club;
import com.omas.webapp.table.Competition;

public interface CompetitionRepository extends JpaRepository<Competition, String> { 
    Optional<Club> findByName(String name); 
}
