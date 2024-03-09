package com.omas.webapp.table;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    public TeamMember(String clubId, String competitionId, Long userId) {
        this.clubId = clubId;
        this.competitionId = competitionId;
        this.userId = userId;
    }

    public TeamMember(TeamMemberId teamMemberId) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.clubId = teamMemberId.getClubId();
    }

    @Getter
    @Id
    Long userId;

    @Getter
    @Id
    String clubId;
    
    @Getter
    @Id
    String competitionId;

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        TeamMember that = (TeamMember) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(clubId, that.clubId) &&
                Objects.equals(competitionId, that.competitionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, clubId, competitionId);
    }

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", referencedColumnName = "id")
    private User user;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumns(value = {
            @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false),
            @JoinColumn(name = "clubId", referencedColumnName = "clubId", insertable = false)
    })
    private Team team;
}