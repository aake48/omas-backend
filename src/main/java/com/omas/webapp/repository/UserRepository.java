package com.omas.webapp.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.User;

public interface UserRepository extends JpaRepository<User, Long> { 
    public Optional<User> findByUsername(String username); 
    
    public User findByEmail(String email);

    public Page<User> findByLegalNameContaining(String search, PageRequest pageRequest);

}
