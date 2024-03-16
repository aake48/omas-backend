package com.omas.webapp.entity.response;

import com.omas.webapp.table.Team;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class CompetitionTeamsResponse {

    final List<Team> teams;

}
