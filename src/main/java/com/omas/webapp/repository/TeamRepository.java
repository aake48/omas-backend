package com.omas.webapp.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;

public interface TeamRepository extends JpaRepository<Team, TeamId> {


    List<Team> findByCompetitionId(String competitionId);

    Page<Team> findByClubNameContaining(String search, PageRequest of);

    Page<Team> findByCompetitionIdContaining(String search, PageRequest of);

    @Query(value = "SELECT t.* FROM Team t JOIN Competition c ON t.competition_id = c.competition_id WHERE c.start_date <= :now AND c.end_date >= :now AND t.club_name = :club", nativeQuery = true)
    Page<Team> findThisClubsTeamsWhichAreInActiveCompetitions(PageRequest of, String club, Date now);

}