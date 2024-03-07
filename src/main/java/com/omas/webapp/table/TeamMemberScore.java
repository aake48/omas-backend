package com.omas.webapp.table;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UuidGenerator;
import java.sql.Date;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * The `TeamMemberScore` class represents the score of a team member in a
 * competition.
 * It contains information such as the user ID, club ID, competition ID, sum of
 * scores,
 * number of bullseyes, score per shot, and creation date.
 * 
 * This class also provides a constructor that accepts a `TeamMemberId` object,
 * a list of scores,
 * and a boolean value indicating whether decimal points should be accepted. The
 * constructor adds creationDate,
 * calculates the sum of scores, counts the number of bullseyes, and formats the
 * score per shot according to acceptDecimals variable.
 * 
 */
@Getter
@Entity
@Table
@IdClass(TeamMemberId.class)
@NoArgsConstructor
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

    /**
     * use acceptDecimals=true for rifle-like competitions
     * and false for competitions like pistol competitions which do not record
     * decimal points.
     * This constructor checks for bullseys and removes excess decimal points
     */
    public TeamMemberScore(TeamMemberId teamMemberId, List<Double> list, Boolean acceptDecimals) {

        // rifle like competitions
        if (acceptDecimals) {
            list = list.subList(0, Math.min(list.size(), 60))
                    .stream()
                    .map(score -> Math.floor(score * 10.0) / 10.0)
                    .collect(Collectors.toList());
            this.bullsEyeCount = (int) list.stream().filter(score -> score == 10.9D).count();

        } else {
            list = list.subList(0, Math.min(list.size(), 60))
                    .stream()
                    .map(score -> Math.floor(score))
                    .collect(Collectors.toList());
            this.bullsEyeCount = (int) list.stream().filter(score -> score == 10).count();

        }

        this.sum = Math.floor(list.stream().reduce(0.0, Double::sum) * 10.0) / 10.0;
        this.scorePerShot = list.toString();
        this.userId = teamMemberId.getUserId();
        this.clubId = teamMemberId.getClubId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.creationDate = new Date(Instant.now().toEpochMilli());
    }

}