package com.omas.webapp.service;

import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.repository.ScoreRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScoreService {

    @Autowired
    private ScoreRepository repository;

    public void addScoresFromPayload(TeamScorePayload request) {

        List<Double> scoreList = request.getScoreList();

        repository.save(new TeamMemberScore(request.getTeamMemberId(), scoreList));
    }

    public TeamMemberScore addScore(TeamMemberScore teamScore) {
        return repository.save(teamScore);
    }

    public List<TeamMemberScore> getAllScores() {
        return repository.findAll();
    }

    public List<TeamMemberScore> getTeamScores(TeamId teamId) {
        return repository.findByTeamId(teamId);
    }

}
