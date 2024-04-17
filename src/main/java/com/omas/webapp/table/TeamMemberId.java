package com.omas.webapp.table;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TeamMemberId implements Serializable {

    private Long userId;
    private String competitionId;    
    private String teamName;

    public TeamMemberId(Long userId, String competitionId, String teamName) {
        this.userId = userId;
        this.competitionId = competitionId.toLowerCase();
        this.teamName = teamName.toLowerCase();
    }

    public TeamMemberId(Long id, TeamId teamId) {
        this.userId = id;
        this.competitionId = teamId.getCompetitionId();
        this.teamName = teamId.getTeamName();
    }

}