package com.omas.webapp.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

import com.omas.webapp.table.User;

public interface UserRepository extends JpaRepository<User, Integer> { 
    Optional<User> findByName(String username); 
}
