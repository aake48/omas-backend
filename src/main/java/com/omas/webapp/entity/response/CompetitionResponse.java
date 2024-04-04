package com.omas.webapp.entity.response;

import com.omas.webapp.table.Competition;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompetitionResponse {

    String competitionId;
    String displayName;
    String competitionType;
    String creationDate;
    String startDate;
    String endDate;
    String type;

    List<CompetitionTeamResponse> teams = new ArrayList<>();

    public CompetitionResponse(Competition competition) {
        this.competitionId = competition.getCompetitionId();
        this.displayName = competition.getDisplayName();
        this.competitionType = competition.getType();
        this.creationDate = competition.getCreationDate().toString();
        this.startDate = competition.getStartDate().toString();
        this.endDate = competition.getEndDate().toString();
        this.type = competition.getType();
    }

    public void addTeam(CompetitionTeamResponse teamResponse) {
        this.teams.add(teamResponse);
    }

}
