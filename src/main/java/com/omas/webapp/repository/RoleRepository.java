package com.omas.webapp.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.Role;
import com.omas.webapp.table.RoleId;



public interface RoleRepository extends JpaRepository<Role, RoleId> { 
    
    List<Role>findDistinctByuserId(Long userId);
}
