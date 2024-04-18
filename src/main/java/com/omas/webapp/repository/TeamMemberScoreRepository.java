package com.omas.webapp.repository;

import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TeamMemberScoreRepository extends JpaRepository<TeamMemberScore, TeamMemberId> {

    /**
    * Retrieves the scores of team members of the team specified by the teamId and returns these scores in a list, sorted by the user's score.
    */
    default List<TeamMemberScore> findByTeamId(TeamId teamId) {
        return findByTeamNameIgnoreCaseAndCompetitionIdIgnoreCaseOrderBySumDesc(teamId.getTeamName(), teamId.getCompetitionId());
    }

    // find score of all club's participants in the competition
    List<TeamMemberScore> findByTeamNameIgnoreCaseAndCompetitionIdIgnoreCaseOrderBySumDesc(String teamName, String competitionId);


    TeamMemberScore findByUserIdAndCompetitionIdIgnoreCase(long id, String competitionName);

}
