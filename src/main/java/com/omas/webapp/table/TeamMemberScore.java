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

    private String scorePerShot;

    @Column(nullable = false)
    private Date creationDate = new Date(Instant.now().toEpochMilli());

    public TeamMemberScore(TeamMemberId teamMemberId, double sum, List<Double> scorePerShot) {

        if (scorePerShot != null) {
            sum = 0;
            for (Double double1 : scorePerShot) {
                sum += double1;
            }
            this.scorePerShot = scorePerShot.toString();
        } else {
            scorePerShot = null;
        }
        this.userId = teamMemberId.getUserId();
        this.clubId = teamMemberId.getClubId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.sum = sum;

    }

}