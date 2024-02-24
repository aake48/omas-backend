package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamScore;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ScoreRepository extends JpaRepository<TeamScore, TeamId> {

    List<TeamScore> findByTeamId(TeamId teamId);

    TeamScore findByUuid(UUID uuid);

    void deleteByUuid(UUID uuid);

}
