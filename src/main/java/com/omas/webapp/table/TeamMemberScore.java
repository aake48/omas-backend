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

    private @Id Long userId;
    private @Id String clubId;
    private @Id String competitionId;

    @UuidGenerator(style = UuidGenerator.Style.TIME)
    private UUID uuid;

    private double sum;
    private int bullsEyeCount;
    @Column(length = 1200)
    private String scorePerShot;
    private Date creationDate;

    public TeamMemberScore(TeamMemberId teamMemberId, List<Double> list) {

        this.sum = 0;
        this.bullsEyeCount = 0;

        if (list != null) {
            for (double score : list) {

                this.sum += score;

                if (score == 10.9D) {
                    this.bullsEyeCount++;
                }
            }
            this.scorePerShot = list.toString();

        } else {
            this.scorePerShot = "";

        }


        this.userId = teamMemberId.getUserId();
        this.clubId = teamMemberId.getClubId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.creationDate = new Date(Instant.now().toEpochMilli());
    }

}