package com.omas.webapp.repository;

import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.ImageProofId;
import com.omas.webapp.table.TeamMemberId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FileRepository extends JpaRepository<ImageProof, ImageProofId> {

    default List<ImageProof> findByTeamMemberId(TeamMemberId id) {
        return findByUserIdAndCompetitionIdIgnoreCaseAndTeamNameIgnoreCase(id.getUserId(), id.getCompetitionId(), id.getTeamName());
    }

    List<ImageProof> findByUserIdAndCompetitionIdIgnoreCaseAndTeamNameIgnoreCase(Long userId, String competitionId, String teamName);

    default Optional<ImageProof> findByTeamMemberIdAndFileName(TeamMemberId id, String fileName) {
        return findById(new ImageProofId(id, fileName));
    }

}
