package com.omas.webapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;


public interface TeamRepository extends JpaRepository<Team, TeamId> {

}