package com.omas.webapp.table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import java.sql.Timestamp;

@Entity
@Table
@Data
@AllArgsConstructor
@NoArgsConstructor
@IdClass(ImageProofId.class)
public class ImageProof {

    private @Id Long userId;
    private @Id String competitionId;
    private @Id String teamName;
    private @Id String fileName;

    private Timestamp timeStamp;

    @Lob
    private byte[] image;

    public ImageProof(TeamMemberId teamMemberId, String fileName, byte[] image) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
        this.fileName = fileName;
        this.image = image;
        this.timeStamp = new Timestamp(System.currentTimeMillis());
    }

    @ManyToOne
    @JoinColumns({
        @JoinColumn(name = "userId", referencedColumnName = "userId", insertable = false, updatable = false),
        @JoinColumn(name = "competitionId", referencedColumnName = "competitionId", insertable = false, updatable = false),
        @JoinColumn(name = "teamName", referencedColumnName = "teamName", insertable = false, updatable = false)
    })
    private TeamMemberScore teamMemberScore;

    @JsonIgnore
    public Resource getImageResource() {
        return new ByteArrayResource(image);
    }
}
