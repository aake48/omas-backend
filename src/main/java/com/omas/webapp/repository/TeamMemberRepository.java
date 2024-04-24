package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;

public interface TeamMemberRepository extends JpaRepository<TeamMember, TeamMemberId> { 

    default List<TeamMember> findByTeamId(TeamId teamId) {
        return findByteamNameIgnoreCaseAndCompetitionIdIgnoreCase(teamId.getTeamName(), teamId.getCompetitionId());
    }

    List<TeamMember> findByteamNameIgnoreCaseAndCompetitionIdIgnoreCase(String teamName, String competitionId);

    List<TeamMember> findByUserId(Long userId);

    @Query(value = "SELECT tm.* FROM Team_member tm JOIN Competition c ON tm.competition_id = c.competition_id WHERE tm.user_id = :userId AND c.end_date > :now", nativeQuery = true)
    List<TeamMember> findThisUsersTeamMembershipsForActiveCompetitions(Long userId,  Date now);

    TeamMember findByUserIdAndCompetitionIdIgnoreCase(Long userId, String competitionId);

}
