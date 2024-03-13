package com.omas.webapp.entity.response;

import com.omas.webapp.table.TeamMemberScore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeamMemberScoreResponse implements Comparable<TeamMemberScoreResponse> {

    int bullsEyeCount;
    double sum;
    long userId;
    String name;
    String scorePerShot;
    String creationDate;

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
