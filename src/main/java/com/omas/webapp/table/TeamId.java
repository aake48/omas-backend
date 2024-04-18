package com.omas.webapp.table;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TeamId implements Serializable {

    private String competitionId;
    private String teamName;

    public TeamId(String competitionId, String teamName) {
        this.competitionId = competitionId.toLowerCase();
        this.teamName = teamName.toLowerCase();
    }

}