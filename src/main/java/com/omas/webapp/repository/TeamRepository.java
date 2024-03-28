package com.omas.webapp.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;

public interface TeamRepository extends JpaRepository<Team, TeamId> {


    List<Team> findByCompetitionId(String competitionId);

    Page<Team> findByClubNameContaining(String search, PageRequest of);

    Page<Team> findByCompetitionIdContaining(String search, PageRequest of);

}