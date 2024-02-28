package com.omas.webapp.table;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor; 

@Entity
@Data
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    private @Id Long userId;
    private @Id String competitionId;
    private @Id String clubId;

    public TeamMember(TeamMemberId teamMemberId) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.clubId = teamMemberId.getClubId();
    }

    public TeamId getTeamId() {
        return new TeamId(competitionId, clubId);
    }
} 

