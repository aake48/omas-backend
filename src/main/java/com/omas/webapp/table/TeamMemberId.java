package com.omas.webapp.table;

import java.io.Serializable;
import java.util.Objects;

import lombok.Data;
@Data
public class TeamMemberId implements Serializable {

    private Long userId;
    private String competitionId;
    private String clubId;

    public TeamMemberId() {
    }

    public TeamMemberId(Long userId, String competitionId, String clubId) {
        this.userId = userId;
        this.competitionId = competitionId;
        this.clubId = clubId;
    }

    // getters and setters

    public TeamMemberId(Long id, TeamId teamId) {
        this.userId = id;
        this.competitionId = teamId.getCompetitionId();
        this.clubId = teamId.getClubId();
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeamMemberId that = (TeamMemberId) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(competitionId, that.competitionId) &&
                Objects.equals(clubId, that.clubId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, competitionId, clubId);
    }
}