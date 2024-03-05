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

    public TeamMemberScore(TeamMemberId teamMemberId, List<Double> list) {

        list = list.subList(0, Math.min(list.size(), 60))
                .stream()
                .map(score -> Math.floor(score * 10.0) / 10.0)
                .collect(Collectors.toList());

        this.sum = Math.floor(list.stream().reduce(0.0, Double::sum) * 10.0) / 10.0;
        this.bullsEyeCount = (int) list.stream().filter(score -> score == 10.9D).count();
        this.scorePerShot = list.toString();
        this.userId = teamMemberId.getUserId();
        this.clubId = teamMemberId.getClubId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.creationDate = new Date(Instant.now().toEpochMilli());
    }

}