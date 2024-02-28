package com.omas.webapp.service;

import com.omas.webapp.entity.RegistrationRequest;
import com.omas.webapp.repository.UserRepository;
import com.omas.webapp.table.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.Instant;
import java.util.Optional;
import java.util.List;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private RoleService roleService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Optional<User> user = repository.findByUsername(username);

        if (user.isPresent()) {
            User foundUser = user.get();
            List<String> roles = roleService.FindUsersRoles(foundUser.getId());
            return new UserInfoDetails(foundUser, roles);
        }
        throw new UsernameNotFoundException("User not found " + username);
    }

    public boolean registerUser(RegistrationRequest request) {

        User user = new User();
        user.setUsername(request.getUsername());
        user.setLegalname(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());
        user.setCreationDate(new Date(Instant.now().toEpochMilli()));

        // checks whether a user with this username already exists in the db
        if (repository.findByUsername(user.getUsername()).isPresent()) {
            return false;
        }
        // hash and salt password before saving it to db
        user.setPassword(encoder.encode(user.getPassword()));
        try {
            User createdUser = repository.save(user);
            roleService.addUserRole(createdUser.getId());
        } catch (Exception e) {
            System.out.println("ex : " + e);
            return false;
        }
        return true;
    }

    public void joinClub(Long id, String club) {
        Optional<User> userToJoin = repository.findById(id);

        User user = userToJoin.get();
        user.setPartOfClub(club);
        repository.save(user);

    }
}