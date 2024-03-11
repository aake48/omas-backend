package com.omas.webapp.table;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TeamId implements Serializable {

    private String competitionId;
    private String teamName;

}