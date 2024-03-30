package com.omas.webapp.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.omas.webapp.repository.RoleRepository;
import com.omas.webapp.table.Role;
import com.omas.webapp.table.RoleId;

@Service
public class RoleService {

    @Autowired
    RoleRepository repository;

    public List<String> FindUsersRoles(Long userId) {
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

    public Role addRole(long id, String role) {
        Role newRole = new Role(id, role);
        return repository.save(newRole);
    }

    public void removeRole(long id, String role) {
        Role roleToBeRemoved = new Role(id, role);
        repository.delete(roleToBeRemoved);
    }

    public void removeRoles(long id) {
            List<Role> roles = repository.findDistinctByuserId(id);
            repository.deleteAll(roles);
    }

    public Optional<Role> findRole(RoleId roleId) {
        return repository.findById(roleId);
    }

}
