package com.omas.webapp.table;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeamMemberId implements Serializable {

    
    private Long userId;
    private String clubId;
    private String competitionId;

    public TeamMemberId(Long userId, TeamId teamId) {
        this.userId = userId;
        this.clubId = teamId.getClubId();
        this.competitionId = teamId.getCompetitionId();
    }

}
