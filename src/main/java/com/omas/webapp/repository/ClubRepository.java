package com.omas.webapp.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.Club;

public interface ClubRepository extends JpaRepository<Club, String> { 
    Optional<Club> findByName(String name); 
}
