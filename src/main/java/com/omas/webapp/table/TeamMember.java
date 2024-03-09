package com.omas.webapp.table;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    public TeamMember(TeamMemberId teamMemberId) {
        this.userId=(teamMemberId.getUserId());
        TeamId teamId = new TeamId();
        teamId.setClubId(teamMemberId.getClubId());
        teamId.setClubId(teamMemberId.getCompetitionId());
        clubId=teamMemberId.getClubId();
        competitionId=teamMemberId.getCompetitionId();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        TeamMember that = (TeamMember) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(competitionId, that.competitionId) &&
                Objects.equals(clubId, that.clubId);
    }

    // @OneToOne(fetch = FetchType.EAGER)
    // @JoinColumn(name = "userId")
    // private User user;

    @Id
    Long userId;

    @Id
    String clubId;

    @Id
    String competitionId;

    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumns({
        
            @JoinColumn(name = "competitionId", referencedColumnName = "competitionId"),
            @JoinColumn(name = "clubId", referencedColumnName = "clubId")
    })
    public void setTeamIDs(Team team) {
        this.clubId=team.getClubId();
        this.competitionId=team.getCompetitionId();
    };

}