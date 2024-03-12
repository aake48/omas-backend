package com.omas.webapp.entity.response;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class CompetitionTeamListResponse {

    String competitionId;
    List<TeamInformation> teams;

}
