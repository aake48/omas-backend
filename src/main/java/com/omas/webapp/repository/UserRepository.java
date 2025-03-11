package com.omas.webapp.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.omas.webapp.table.Role;
import com.omas.webapp.table.User;

public interface UserRepository extends JpaRepository<User, Long> { 
    public Optional<User> findByUsername(String username); 

    public Optional<User> getUser(String role); 
    
    public User findByEmail(String email);

    public Page<User> findByLegalNameContaining(String search, PageRequest pageRequest);

    @Query(value = "SELECT * FROM Role r WHERE r.user_id = :userid", nativeQuery = true)
    public List<Role> getRoles(Long userid);
        
}
