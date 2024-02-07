package com.omas.webapp.user;

import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User registerUser(User user) {

        User resultUser = userRepository.findByUsername(user.getUsername());

        if (resultUser == null) {
            return userRepository.save(user);
        } else
            return null;

    }

    public User logginUser(User user) {

        User resultUser = userRepository.findByUsername(user.getUsername());

        if (resultUser != null) {
            if (resultUser.getPassword().equals(user.getPassword())) {
                return resultUser;
            }
        }

        return null;
    }
}
