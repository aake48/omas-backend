package com.omas.webapp.entity.response;

import com.omas.webapp.table.Competition;
import lombok.Data;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Data
public class CompetitionResponse {

    final String competitionId;
    final String displayName;
    final String competitionType;
    final String creationDate;
    final String startDate;
    final String endDate;

    @Setter
    List<CompetitionTeamResponse> teams = new ArrayList<>();

    public CompetitionResponse(Competition competition) {
        this.competitionId = competition.getCompetitionId();
        this.displayName = competition.getDisplayName();
        this.competitionType = competition.getType();
        this.creationDate = competition.getCreationDate().toString();
        this.startDate = competition.getStartDate().toString();
        this.endDate = competition.getEndDate().toString();
    }

    public void addTeam(CompetitionTeamResponse teamResponse) {
        this.teams.add(teamResponse);
    }

}
