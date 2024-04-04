package com.omas.webapp.table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.omas.webapp.Constants;
import com.omas.webapp.Json;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.sql.Date;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

/**
 * The `TeamMemberScore` class represents the score of a team member in a
 * competition.
 * It contains information such as the user ID, club ID, competition ID, sum of
 * scores,
 * number of bullseyes, score per shot, and creation date.
 * <br><br>
 * This class also provides a constructor that accepts a `TeamMemberId` object,
 * a list of scores,
 * and a boolean value indicating whether decimal points should be accepted. The
 * constructor adds creationDate,
 * calculates the sum of scores, counts the number of bullseyes, and formats the
 * score per shot according to acceptDecimals variable.
 * 
 */

@Entity
@Table
@IdClass(TeamMemberId.class)
@NoArgsConstructor
public class TeamMemberScore implements Comparable<TeamMemberScore> {

    private @Getter @Id Long userId;
    private @Getter @Id String competitionId;
    private @Getter @Id String teamName;

    @Getter
    private double sum;

    @Getter
    private int bullsEyeCount;

    @Column(length = 1200)
    @Getter
    private String scorePerShot;

    @Getter
    private Date creationDate;

    /**
     * Use Constants.RIFLE_TYPE for rifle competitions and Constants.PISTOL_TYPE for pistol competitions
     * This constructor checks for bullseyes and removes excess decimal points
     */
    public TeamMemberScore(TeamMemberId teamMemberId, List<Double> list, String competitionType) throws JsonProcessingException {

        countBullsEyes(list, competitionType);

        this.sum = Math.floor(list.stream().reduce(0.0, Double::sum) * 10.0) / 10.0;
        this.scorePerShot = Json.stringify(list, false);
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
        this.creationDate = new Date(Instant.now().toEpochMilli());
    }

    public TeamMemberScore(TeamMemberId teamMemberId, double score, int bullsEyeCount) {
        this.bullsEyeCount = bullsEyeCount;
        this.sum = score;
        this.scorePerShot = "Not available";
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
        this.creationDate = new Date(Instant.now().toEpochMilli());
    }

    /**
     * Count bullseyes based on the competitionType.
     * <br>If it's a rifle competition, each score above 10.4 is counted as a bullseye
     * <br>If it's a pistol competition, each 10 is counted as a bullseye
     * @param list the score list
     * @param competitionType the competition type
     * @throws IllegalArgumentException if the competitionType is invalid
     */
    private List<Double> countBullsEyes(List<Double> list, String competitionType) throws IllegalArgumentException {

        list = roundScores(list, competitionType);

        switch (competitionType) {
            case Constants.RIFLE_TYPE -> this.bullsEyeCount = (int) list.stream().filter(score -> score >= 10.4D).count();
            case Constants.PISTOL_TYPE -> this.bullsEyeCount = (int) list.stream().filter(score -> score == 10).count();
            default -> throw new IllegalArgumentException("Invalid competition type");
        }

        return list;
    }

    /**
     * Round the scores to 0 or 1 decimal places according to the provided competitionType
     * @param list the score list
     * @param competitionType the competition type
     * @return a sublist of the first 60 scores with the rounded values
     * @throws IllegalArgumentException if the competitionType is invalid
     */
    private List<Double> roundScores(List<Double> list, String competitionType) {

        switch (competitionType) {
            // TODO: Is the 60 shot limit desirable?
            case Constants.RIFLE_TYPE -> {
                return list.subList(0, Math.min(list.size(), 60))
                    .stream()
                    .map(score -> Math.floor(score * 10.0) / 10.0)
                    .collect(Collectors.toList());
            }
            case Constants.PISTOL_TYPE -> {
                // TODO: Is the 60 shot limit desirable?
                return list.subList(0, Math.min(list.size(), 60))
                    .stream()
                    .map(Math::floor)
                    .collect(Collectors.toList());
            }
            default -> {
                throw new IllegalArgumentException("Invalid competition type");
            }
        }

    }

    /**
     * Append scores to the scorePerShot string
     * @param scores the scores to append
     * @throws JsonProcessingException if parsing scorePerShot failed for some reason.
     */
    public void appendScores(List<Double> scores, String competitionType) throws JsonProcessingException {

        // If the entry has no scores available we can replace it
        if (this.scorePerShot != null && !this.scorePerShot.startsWith("[")) {
            // Recalculate bullseyes and round the values
            this.scorePerShot = Json.stringify(countBullsEyes(scores, competitionType));
        } else {

            List<Double> oldScores = Json.fromString(this.scorePerShot, new TypeReference<>(){});

            oldScores.addAll(scores);

            // Recalculate bullseyes and round the values
            oldScores = countBullsEyes(oldScores, competitionType);

            this.scorePerShot = Json.stringify(oldScores, false);
        }

    }

    @JsonIgnore
    public TeamMemberId getTeamMemberId() {
        return new TeamMemberId(userId, competitionId, teamName);
    }

    @Override
    public int compareTo(TeamMemberScore o) {
        return Double.compare(sum, o.sum);
    }

    @ManyToOne
    @JoinColumns({
        @JoinColumn(name = "userId", referencedColumnName = "userId", insertable = false, updatable = false),
        @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false),
        @JoinColumn(name = "teamName", referencedColumnName = "teamName", insertable = false, updatable = false)

    })
    private TeamMember teamMember;

}