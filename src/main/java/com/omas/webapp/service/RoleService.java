package com.omas.webapp.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.omas.webapp.repository.RoleRepository;
import com.omas.webapp.table.Role;

@Service
public class RoleService {

    @Autowired
    RoleRepository repository;

    public List<String> FindUsersRoles(Long userId){
        List<Role> roles = repository.findDistinctByuserId(userId);
        return roles.stream().map(role -> String.valueOf(role.getRole())).toList();
    }

    public Role addUserRole(long id) {
        Role userRole = new Role(id, "ROLE_USER");
        return repository.save(userRole);
    }

    public Role addAdminRole(long id) {
        Role userRole = new Role(id, "ROLE_ADMIN");
        return repository.save(userRole);
    }

    //not implemented yet
    public Boolean removeRoles(long id) {
        return null;
    }

}
