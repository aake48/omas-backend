package com.omas.webapp.service;

import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.repository.PasswordResetTokenRepository;
import com.omas.webapp.repository.UserRepository;
import com.omas.webapp.table.PasswordResetToken;
import com.omas.webapp.table.User;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.sql.Date;
import java.time.Instant;
import java.util.Optional;
import java.util.List;

@Service
@Log4j2
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PasswordResetTokenRepository passwordResetTokenRepository;


        public Page<User> findWithPaginatedSearch(int page, int size, String search) {
        return repository.findByLegalNameContaining(search, PageRequest.of(page, size));
    }

    @Override
    public UserInfoDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Optional<User> user = repository.findByUsername(username);

        if (user.isPresent()) {
            User foundUser = user.get();
            List<String> roles = roleService.FindUsersRoles(foundUser.getId());
            return new UserInfoDetails(foundUser, roles);
        }
        throw new UsernameNotFoundException("User not found " + username);
    }

    public void updateResetPasswordToken(String token, String email) throws Exception {
        User user = repository.findByEmail(email);
        if (user != null) {
            PasswordResetToken passwordResetToken = new PasswordResetToken(token, user.getId());
            passwordResetTokenRepository.save(passwordResetToken);
        } else {
            throw new Exception("Could not find any user with the email " + email);
        }
    }

    /**
     * Retrieves a user by their reset password token. If token was retrieved, it will be deleted.
     *
     * @param token The reset password token to search for.
     * @return The user associated with the reset password token, or null if the token has expired or no user is found.
     */
    public User getByResetPasswordToken(String token) throws Exception {

        PasswordResetToken passwordResetToken = passwordResetTokenRepository.findByResetPasswordToken(token);
        if (passwordResetToken == null) {
            return null;
        }
        passwordResetTokenRepository.delete(passwordResetToken);

        if (passwordResetToken.hasExpired()) {
            return null;
        }

        return repository.findById(passwordResetToken.getId()).get();
    }

    public void updatePassword(User user, String newPassword) {
        user.setPassword(encoder.encode(newPassword));
        repository.save(user);
    }

    public boolean registerUser(RegistrationRequest request) {

        User user = new User();
        user.setUsername(request.getUsername());
        user.setLegalName(request.getName());
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

    public boolean userExists(long id) {
        Optional<User> userOptional = repository.findById(id);

        if (userOptional.isEmpty()) {
            return false;
        }
        return true;
    }

    /**
     * "Deletes" a user by setting all their information to null.
     * @param userId the numeric id of the user to delete
     * @return the user with the cleared fields or null if no user was found
     */
    public User deleteUser(Long userId) {

        Optional<User> userOptional = repository.findById(userId);

        if (userOptional.isEmpty()) {
            return null;
        }

        User user = userOptional.get();

        user.setLegalName(user.getPartOfClub());
        user.setUsername(null);
        user.setPartOfClub(null);
        user.setPassword(null);
        user.setEmail(null);
        user.setCreationDate(null);

        return repository.save(user);
    }

    /**
     * Joins a user to a club.
     * This method does not perform any validation on 'club' String
     *
     * @param id   the ID of the user
     * @param club the name of the club to join
     * @return true if the user was successfully joined to the club, false otherwise
     */
    public boolean joinClub(Long id, String club) {
        Optional<User> userToJoin = repository.findById(id);

        if (userToJoin.isPresent()) {
            User user = userToJoin.get();
            user.setPartOfClub(club);
            repository.save(user);
            return true;
        }
        return false;
    }

    public String getName(Long userId) {
        try {
            User user = repository.findById(userId).get();
            return user.getLegalName();
        } catch (Exception e) {
            log.info("getName(): " + e);
            return "user name not found";
        }

    }

    public Optional<User> getUserByUsername(String username) {
        return repository.findByUsername(username);
    }

    public void changePassword(Long userId, String password) {
        Optional<User> userOptional = repository.findById(userId);
        User user = userOptional.get();
        updatePassword(user, password);
    }

    public void changeEmail(Long userId, String email) {
        Optional<User> userOptional = repository.findById(userId);
        User user = userOptional.get();
        user.setEmail(email);
        repository.save(user);
    }

    public Optional<User> getUserByUserId(Long userId) {
        return repository.findById(userId);
    }

}