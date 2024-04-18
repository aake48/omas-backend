package com.omas.webapp.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.Club;
import org.springframework.data.jpa.repository.Query;

public interface ClubRepository extends JpaRepository<Club, String> {

    Page<Club> findByNameContainingIgnoreCase(String name, PageRequest pageRequest);

}
