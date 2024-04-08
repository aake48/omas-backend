package com.omas.webapp.entity.requests;

import com.omas.webapp.table.TeamMemberId;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileDownloadRequest {

    @NotNull(message = "userId cannot be empty")
    private Long userId;

    @NotEmpty(message = "competitionId cannot be empty")
    private String competitionId;

    @NotEmpty(message = "teamName cannot be empty")
    private String teamName;

    private String fileName = null;

    public TeamMemberId getTeamMemberId() {
        return new TeamMemberId(userId, competitionId, teamName);
    }

}
