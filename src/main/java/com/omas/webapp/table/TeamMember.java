package com.omas.webapp.table;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    @Getter
    private @Id Long userId;
    @Getter
    private @Id String competitionId;
    @Getter
    private @Id String clubId;

    public TeamMember(TeamMemberId teamMemberId) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.clubId = teamMemberId.getClubId();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        TeamMember that = (TeamMember) o;
        return Objects.equals(userId, that.userId) &&
                Objects.equals(competitionId, that.competitionId) &&
                Objects.equals(clubId, that.clubId);
    }

    @OneToOne
    @JoinColumns({
            @JoinColumn(name = "userId", referencedColumnName = "userId", insertable = false, updatable = false),
            @JoinColumn(name = "clubId", referencedColumnName = "clubId", insertable = false, updatable = false),
            @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false)
    })
    TeamMember teamMember;

}
