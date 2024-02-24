package com.omas.webapp.entity.data;

import com.omas.webapp.table.TeamMemberId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public final class TeamScorePayload {

    private TeamMemberId teamMemberId;
    private List<Double> scoreList;

}
