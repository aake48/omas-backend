package com.omas.webapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;


public interface TeamMemberRepository extends JpaRepository<TeamMember, TeamMemberId> { 
    
}
