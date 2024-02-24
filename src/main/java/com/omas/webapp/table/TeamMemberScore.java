package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UuidGenerator;

import java.sql.Date;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table
@IdClass(TeamMemberId.class)
public class TeamMemberScore {

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

    private double sum;
    private int bullsEyeCount;
    private String scorePerShot;

    @Column(nullable = false)
    private Date creationDate = new Date(Instant.now().toEpochMilli());

    public TeamMemberScore(TeamMemberId teamMemberId, List<Double> scores) {

        this.sum = 0;
        this.bullsEyeCount = 0;

        for (double score : scores) {

            this.sum += score;

            if (score == 10.9D) {
                this.bullsEyeCount++;
            }
        }

        this.scorePerShot = scores.toString();

        this.userId = teamMemberId.getUserId();
        this.clubId = teamMemberId.getClubId();
        this.competitionId = teamMemberId.getCompetitionId();
    }

}