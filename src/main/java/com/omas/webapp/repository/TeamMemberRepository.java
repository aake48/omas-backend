package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;

public interface TeamMemberRepository extends JpaRepository<TeamMember, TeamMemberId> { 

    default Optional<List<TeamMember>> findByTeamId(TeamId teamId) {
        return findByteamNameAndCompetitionId(teamId.getTeamName(), teamId.getCompetitionId());
    }

    Optional<List<TeamMember>> findByteamNameAndCompetitionId(String teamName, String competitionId);

    List<TeamMember> findByUserId(Long userId);

    TeamMember findByUserIdAndCompetitionId(Long userId, String competitionId);

}
