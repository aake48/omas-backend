package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;
import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;

public interface TeamMemberRepository extends JpaRepository<TeamMember, TeamMemberId> { 

    default TeamMember findByTeamId(TeamId teamId) {
        return findByClubIdAndCompetitionId(teamId.getClubId(), teamId.getCompetitionId());
    }

    TeamMember findByClubIdAndCompetitionId(String clubId, String competitionId);

}
