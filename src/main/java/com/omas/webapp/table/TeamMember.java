package com.omas.webapp.table;

import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    public TeamMember(String competitionId, Long userId, String teamName) {
        this.competitionId = competitionId;
        this.userId = userId;
        this.teamName = teamName;

    }

    public TeamMember(TeamMemberId teamMemberId) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
    }

    @Getter
    @Id
    Long userId;

    public String getLegalname() {
        if(user!=null){
            return user.getLegalname();
        }
        return null;
    }



    @Getter
    @Id
    String competitionId;

    @Getter
    @Id
    String teamName;

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        TeamMember that = (TeamMember) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(competitionId, that.competitionId);
    }

    @JsonIgnore
    public TeamMemberId getId() {
        return new TeamMemberId(userId, competitionId, teamName);
    }

    @JsonIgnore
    public TeamId getTeamId() {
        return new TeamId(competitionId, teamName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, competitionId);
    }

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "id", insertable = false, updatable = false)
    private User user;

    @ManyToOne
    @JoinColumns(value = {
            @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false),
            @JoinColumn(name = "teamName", referencedColumnName = "teamName", insertable = false, updatable = false)
    })
    private Team team;
}