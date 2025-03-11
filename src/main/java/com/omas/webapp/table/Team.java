package com.omas.webapp.table;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

    @Column(nullable = false)
    private @Getter @Id String competitionId;

    @Column(nullable = false, updatable = false)
    private @Getter @Id String teamName;

    @Getter
    @Column(nullable = false)
    private String clubName;

    @Getter
    @Column(nullable = false)
    private String teamDisplayName;

    @Getter
    @Column(nullable = false)
    private String teamDisplayShort;

    @Getter
    @Column(nullable = false)
    private String teamSeries;

    public Team(String competitionId, String teamName, String teamDisplayName, String clubName, String teamDisplayShort, String teamSeries) {
        this.competitionId = competitionId.toLowerCase();
        this.teamName = teamName.toLowerCase();
        this.teamDisplayName = teamDisplayName;
        this.clubName = clubName.toLowerCase();
        this.teamDisplayShort = teamDisplayShort;
        this.teamSeries = teamSeries;
    }

    public Team(TeamId teamId, String teamDisplayName, String club, String teamDisplayShort, String teamSeries) {
        this.competitionId = teamId.getCompetitionId();
        this.teamName = teamId.getTeamName();
        this.teamDisplayName = teamDisplayName;
        this.clubName = club;
        this.teamDisplayShort = teamDisplayShort;
        this.teamSeries = teamSeries;
    }

    @JsonIgnore
    public TeamId getTeamId() {
        return new TeamId(competitionId, teamName);
    }

    @ManyToOne
    @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false)
    private Competition competition;

    @ManyToOne
    @JoinColumn(name = "clubName", referencedColumnName = "name", insertable = false, updatable = false)
    private Club club;

    @OneToMany(mappedBy = "team", cascade = CascadeType.ALL)
    @Getter
    private List<TeamMember> teamMembers = new ArrayList<>();

}
