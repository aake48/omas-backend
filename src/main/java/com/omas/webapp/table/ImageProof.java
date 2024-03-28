package com.omas.webapp.table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;

@Entity
@Table
@Data
@AllArgsConstructor
@NoArgsConstructor
@IdClass(TeamMemberId.class)
public class ImageProof {

    private @Id Long userId;
    private @Id String competitionId;
    private @Id String teamName;

    private long timeStamp;

    @Lob
    private byte[] image;

    public ImageProof(TeamMemberId teamMemberId, byte[] image) {
        this.userId = teamMemberId.getUserId();
        this.competitionId = teamMemberId.getCompetitionId();
        this.teamName = teamMemberId.getTeamName();
        this.image = image;
        this.timeStamp = System.currentTimeMillis();
    }

    @JsonIgnore
    public Resource getImageResource() {
        return new ByteArrayResource(image);
    }
}
