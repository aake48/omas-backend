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
    private String clubId;

    @Id
    @Getter
    @Column(nullable = false)
    private String competitionId;

    public Team(TeamId teamId) {
        this.clubId = teamId.getClubId();
        this.competitionId = teamId.getCompetitionId();
    }
    
    @ManyToOne
    @JoinColumn(name = "clubId", referencedColumnName = "name", insertable = false, updatable = false)
    private Club club;

    @ManyToOne
    @JoinColumn(name = "competitionId", referencedColumnName = "name", insertable = false, updatable = false)
    private Competition competition;

    @OneToMany(mappedBy =  "team", cascade = CascadeType.ALL)
    @Getter private List<TeamMember> teamMembers = new ArrayList<>();
}
