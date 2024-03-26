package com.omas.webapp.repository;

import com.omas.webapp.table.ImageProof;
import com.omas.webapp.table.TeamMemberId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FileRepository extends JpaRepository<ImageProof, TeamMemberId> {

}
