package com.omas.webapp.table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;
import java.time.Instant;

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

    @Getter
    private int round;

    @Getter
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Timestamp creationDate;

    public TeamMemberScore(TeamMemberId teamMemberId, double score, int bullsEyeCount, int round) {
        this.bullsEyeCount = bullsEyeCount;
        this.round = round;
        this.sum = Math.floor(score * 10.0) / 10.0;
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
        this.creationDate = new Timestamp(Instant.now().toEpochMilli());
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
    @JsonIgnore
    @Getter
    @JoinColumns({
        @JoinColumn(name = "userId", referencedColumnName = "userId", insertable = false, updatable = false),
        @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false),
        @JoinColumn(name = "teamName", referencedColumnName = "teamName", insertable = false, updatable = false)

    })
    private TeamMember teamMember;

}