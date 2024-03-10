package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table
@IdClass(TeamId.class)
@NoArgsConstructor
@EqualsAndHashCode
public class Team {

    @Id
    @Getter
    @Column(nullable = false)
    private String clubId;

    @Id
    @Getter
    @Column(nullable = false)
    private String competitionId;

    public Team(TeamId teamId) {
        this.clubId = teamId.getClubId();
        this.competitionId = teamId.getCompetitionId();
    }

    @MapsId
    @ManyToOne
    @JoinColumn(name = "clubId", referencedColumnName = "name", insertable = false)
    private Club club;

    @MapsId
    @ManyToOne
    @JoinColumn(name = "competitionId", referencedColumnName = "name", insertable = false)
    private Competition competition;
}
