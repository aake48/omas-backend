package com.omas.webapp.repository;

import java.sql.Date;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.omas.webapp.table.Competition;

public interface CompetitionRepository extends JpaRepository<Competition, String> {

    Page<Competition> findByCompetitionIdContaining(String name, PageRequest pageRequest);

    @Query(value = "SELECT * FROM Competition c WHERE EXTRACT(YEAR FROM c.start_date) = :year", nativeQuery = true)
    Page<Competition> findByYear(@Param("year") int year, PageRequest pageRequest);

    @Query(value = "SELECT * FROM Competition c WHERE c.start_date <= :now AND c.end_date >= :now ORDER BY c.start_date DESC", nativeQuery = true)
    Page<Competition> findActiveCompetitions(Date now, PageRequest of);

    @Query(value = "SELECT * FROM Competition c WHERE c.end_date <= :now ORDER BY c.start_date DESC", nativeQuery = true)
    Page<Competition> findInactiveCompetitions(Date now, PageRequest of);
}
