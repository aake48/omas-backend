package com.omas.webapp.service;

import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.repository.ScoreRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class ScoreService {

    @Autowired
    private ScoreRepository repository;

    public void addScoresFromPayload(TeamScorePayload request) {

        List<Double> scoreList = request.getScoreList();
        List<TeamScore> teamScores = new ArrayList<>(scoreList.size());

        TeamMemberId teamMemberId = request.getTeamMemberId();

        for (Double score : scoreList) {
            teamScores.add(new TeamScore(teamMemberId, score));
        }

        repository.saveAll(teamScores);
    }

    public TeamScore addScore(TeamScore teamScore) {
        return repository.save(teamScore);
    }

    public List<TeamScore> getAllScores() {
        return repository.findAll();
    }

    public List<TeamScore> getTeamScores(TeamId teamId) {
        return repository.findByTeamId(teamId);
    }

    public void deleteScore(UUID uuid) {
        repository.deleteByUuid(uuid);
    }

}
