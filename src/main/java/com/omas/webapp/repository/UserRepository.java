package com.omas.webapp.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.omas.webapp.table.User;

public interface UserRepository extends JpaRepository<User, Long> { 
    public Optional<User> findByUsername(String username); 
    
    public User findByEmail(String email);

    public Page<User> findByLegalNameContaining(String search, PageRequest pageRequest);

    @Query(value = "SELECT role FROM role r WHERE r.user_id = :user_id", nativeQuery = true)
    public List<String> getRoles(@Param("user_id") Long userId);
        
}
