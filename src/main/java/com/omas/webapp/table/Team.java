package com.omas.webapp.table;

import java.util.ArrayList;
import java.util.List;

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
    private String competitionId;

    @Id
    @Getter
    @Column(nullable = false)
    private String teamName;

    public Team(TeamId teamId) {
        this.competitionId = teamId.getCompetitionId();
        this.teamName = teamId.getTeamName();
    }


    @Getter
    @Column(nullable = false)
    private String teamDisplayName;
    

    @ManyToOne
    @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false)
    private Competition competition;

    @OneToMany(mappedBy =  "team", cascade = CascadeType.ALL)
    @Getter private List<TeamMember> teamMembers = new ArrayList<>();

    public Team(TeamId teamId, String teamDisplayName) {
        competitionId=teamId.getCompetitionId();
        teamName=teamId.getTeamName();
        this.teamDisplayName=teamDisplayName;
    }


}
