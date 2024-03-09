package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table
@IdClass(TeamId.class)
@AllArgsConstructor
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

    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "clubId", referencedColumnName = "name")
    private void setUserId(Club club) {
        this.clubId = club.getName();
    };

    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "clubId", referencedColumnName = "name")
    private void setUserId(Competition competition) {
        this.competitionId = competition.getName();
    };
}
