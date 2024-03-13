package com.omas.webapp.entity.response;

import com.omas.webapp.table.Competition;
import lombok.Data;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
public class CompetitionResponse {

    final String competitionId;
    final String displayName;
    final String creationDate;

    @Setter
    List<CompetitionTeamResponse> teams = new ArrayList<>();

    public CompetitionResponse(String competitionId, String displayName, Date creationDate) {
        this.competitionId = competitionId;
        this.displayName = displayName;
        this.creationDate = creationDate.toString();
    }

    public CompetitionResponse(Competition competition) {
        this(competition.getCompetitionId(), competition.getDisplayName(), competition.getCreationDate());
    }

    public void addTeam(CompetitionTeamResponse teamResponse) {
        this.teams.add(teamResponse);
    }

}
