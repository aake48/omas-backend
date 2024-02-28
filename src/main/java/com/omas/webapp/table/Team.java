package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table
@IdClass(TeamId.class)
@NoArgsConstructor
public class Team {

    @Id
    @Column(nullable = false)
    private String clubId;

    @Id
    @Column(nullable = false)
    private String competitionId;

    public Team(TeamId teamId) {
        this.clubId = teamId.getClubId();
        this.competitionId = teamId.getCompetitionId();
    }

    public TeamId getTeamId() {
        return new TeamId(clubId, competitionId);
    }

}
