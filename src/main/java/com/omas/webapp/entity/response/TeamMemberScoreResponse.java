package com.omas.webapp.entity.response;

import lombok.Data;

@Data
public class TeamMemberScoreResponse implements Comparable<TeamMemberScoreResponse> {

    final int bullsEyeCount;
    final double sum;
    final long userId;
    final String name;
    final String scorePerShot;

    @Override
    public int compareTo(TeamMemberScoreResponse o) {
        return Double.compare(sum, o.sum);
    }

}
