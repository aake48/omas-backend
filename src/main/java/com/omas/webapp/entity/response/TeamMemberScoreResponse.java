package com.omas.webapp.entity.response;

import com.omas.webapp.table.TeamMemberScore;
import lombok.Data;

@Data
public class TeamMemberScoreResponse implements Comparable<TeamMemberScoreResponse> {

    final int bullsEyeCount;
    final double sum;
    final long userId;
    final String name;
    final String scorePerShot;
    final String creationDate;

    public TeamMemberScoreResponse(TeamMemberScore score, String name) {
        this.bullsEyeCount = score.getBullsEyeCount();
        this.sum = score.getSum();
        this.userId = score.getUserId();
        this.name = name;
        this.scorePerShot = score.getScorePerShot();
        this.creationDate = score.getCreationDate().toString();
    }

    @Override
    public int compareTo(TeamMemberScoreResponse o) {
        return Double.compare(o.sum, sum);
    }

}
