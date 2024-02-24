package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamScore;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ScoreRepository extends JpaRepository<TeamScore, TeamId> {

    default List<TeamScore> findByTeamId(TeamId teamId) {
        return findByClubIdAndCompetitionId(teamId.getClubId(), teamId.getCompetitionId());
    }

    default List<TeamScore> findByTeamMemberId(TeamMemberId teamId) {
        return findByUserIdAndClubIdAndCompetitionId(teamId.getUserId(), teamId.getClubId(), teamId.getCompetitionId());
    }

    List<TeamScore> findByClubIdAndCompetitionId(String clubId, String competitionId);

    List<TeamScore> findByUserIdAndClubIdAndCompetitionId(Long userId, String clubId, String competitionId);

    TeamScore findByUuid(UUID uuid);

    void deleteByUuid(UUID uuid);

}
