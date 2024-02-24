package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UuidGenerator;

import java.sql.Date;
import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table
@IdClass(TeamMemberId.class)
public class TeamScore {

    @Id
    @Column(nullable = false)
    private Long userId;

    @Id
    @Column(nullable = false)
    private String clubId;

    @Id
    @Column(nullable = false)
    private String competitionId;

    @UuidGenerator(style = UuidGenerator.Style.TIME)
    private UUID uuid;

    private double score;

    @Column(nullable = false)
    private Date creationDate = new Date(Instant.now().toEpochMilli());

    public TeamScore(TeamId teamId, double score) {
        this.clubId = teamId.getClubId();
        this.competitionId = teamId.getCompetitionId();
        this.score = score;
    }

}