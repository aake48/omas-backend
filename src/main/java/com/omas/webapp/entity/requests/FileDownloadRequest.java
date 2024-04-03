package com.omas.webapp.entity.requests;

import com.omas.webapp.table.TeamMemberId;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileDownloadRequest {

    @NotEmpty(message = "userId cannot be empty")
    private Long userId;

    @NotEmpty(message = "competitionId cannot be empty")
    private String competitionId;

    @NotEmpty(message = "teamName cannot be empty")
    private String teamName;

    private String fileName;

    public TeamMemberId getTeamMemberId() {
        return new TeamMemberId(userId, competitionId, teamName);
    }

}
