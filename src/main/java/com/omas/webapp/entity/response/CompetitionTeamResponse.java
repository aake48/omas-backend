package com.omas.webapp.entity.response;

import lombok.Data;

import java.util.List;

@Data
public class CompetitionTeamResponse implements Comparable<CompetitionTeamResponse> {

    final String teamName;
    final String teamDisplayName;
    double totalScore;
    List<TeamMemberScoreResponse> scores;

    public CompetitionTeamResponse(String teamName, String teamDisplayName, List<TeamMemberScoreResponse> scores) {
        this.teamName = teamName;
        this.teamDisplayName = teamDisplayName;
        this.scores = scores;
        this.totalScore = 0.0;

        for (TeamMemberScoreResponse score : scores) {
            this.totalScore += score.getSum();
        }

        this.totalScore = Math.floor(this.totalScore * 10.0) / 10.0;
    }

    @Override
    public int compareTo(CompetitionTeamResponse o) {
        return Double.compare(o.totalScore, totalScore);
    }

}
