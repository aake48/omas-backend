package com.omas.webapp.entity.response;

import com.omas.webapp.table.TeamMemberScore;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CompetitionTeamResponse implements Comparable<CompetitionTeamResponse> {

    final String clubId;
    double totalScore;
    List<TeamMemberScore> scores = new ArrayList<>();

    public CompetitionTeamResponse(String clubId) {
        this.clubId = clubId;
    }

    public void setScores(List<TeamMemberScore> scores) {

        this.scores = scores;
        this.totalScore = 0.0;

        for (TeamMemberScore score : scores) {
            this.totalScore += score.getSum();
        }
    }

    @Override
    public int compareTo(CompetitionTeamResponse o) {
        return Double.compare(totalScore, o.totalScore);
    }

}
