package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ScoreRepository extends JpaRepository<TeamMemberScore, TeamId> {

    default List<TeamMemberScore> findByTeamId(TeamId teamId) {
        return findByClubIdAndCompetitionId(teamId.getClubId(), teamId.getCompetitionId());
    }

    default List<TeamMemberScore> findByTeamMemberId(TeamMemberId teamId) {
        return findByUserIdAndClubIdAndCompetitionId(teamId.getUserId(), teamId.getClubId(), teamId.getCompetitionId());
    }

    List<TeamMemberScore> findByClubIdAndCompetitionId(String clubId, String competitionId);

    List<TeamMemberScore> findByUserIdAndClubIdAndCompetitionId(Long userId, String clubId, String competitionId);

}
