package com.omas.webapp.table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImageProofId {

    private Long userId;
    private String competitionId;
    private String teamName;
    private String fileName;

    public ImageProofId(TeamMemberId id, String fileName) {
        this.userId = id.getUserId();
        this.competitionId = id.getCompetitionId();
        this.teamName = id.getTeamName();
        this.fileName = fileName;
    }

}
