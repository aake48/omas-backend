package com.omas.webapp.table;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table
@IdClass(TeamId.class)
public class Team {

    @Id
    @Column(nullable = false)
    private String clubId;

    @Id
    @Column(nullable = false)
    private String competitionId;

}
