package com.omas.webapp.service;

import com.omas.webapp.repository.TeamMemberScoreRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamMemberScoreService {

    @Autowired
    private TeamMemberScoreRepository teamMemberScoreRepository;

    /**
     * Note: this method does not perform any validation to check if the provided TeamId is valid
     * @return saved TeamMemberScore
     */ 
    public TeamMemberScore addUsersScore(TeamMemberId teamMemberId, List<Double> score) {

        TeamMemberScore teamMemberScore = new TeamMemberScore(teamMemberId, score);
        return teamMemberScoreRepository.save(teamMemberScore);
    }

    public List<TeamMemberScore> getAllScores() {
        return teamMemberScoreRepository.findAll();
    }

    public List<TeamMemberScore> getTeamScores(TeamId teamId) {
        return teamMemberScoreRepository.findByTeamId(teamId);
    }

    public TeamMemberScore getUsersScore(long id, String competitionName) {
        return teamMemberScoreRepository.findByUserIdAndCompetitionId(id, competitionName);
    }

}
