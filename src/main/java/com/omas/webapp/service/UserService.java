package com.omas.webapp.service;

import com.omas.webapp.repository.UserRepository;
import com.omas.webapp.table.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private PasswordEncoder encoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Optional<User> user = repository.findByName(username);

        // Converting user to UserDetails
        return user.map(UserInfoDetails::new)
                .orElseThrow(() -> new UsernameNotFoundException("User not found " + username));
    }

    public boolean registerUser(User user) {

        // checks whether a user with this username already exists in the db
        if (repository.findByName(user.getName()).isPresent()) {
            return false;
        }
        // hash and salt password before saving it to db
        user.setPassword(encoder.encode(user.getPassword()));
        try {
            repository.save(user);
        } catch (Exception e) {
            return false;
        }
        return true;
    }
}