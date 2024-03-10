package com.omas.webapp.table;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TeamMemberId implements Serializable {

    private Long userId;
    private String competitionId;
    private String clubId;

    public TeamMemberId(Long userId, String competitionId, String clubId) {
        this.userId = userId;
        this.competitionId = competitionId;
        this.clubId = clubId;
    }

    public TeamMemberId(Long id, TeamId teamId) {
        this.userId = id;
        this.competitionId = teamId.getCompetitionId();
        this.clubId = teamId.getClubId();
    }

}