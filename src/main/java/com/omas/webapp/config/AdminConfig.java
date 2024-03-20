package com.omas.webapp.config;

import com.omas.webapp.Constants;
import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.service.*;
import com.omas.webapp.table.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
@Component
public class AdminConfig implements CommandLineRunner {

    @Autowired
    RoleService roleService;

    @Autowired
    UserService userService;

    // TODO: Implement this properly with master password/username configured
    // somewhere?
    public void addAdminUser() {

        RegistrationRequest registrationRequest = new RegistrationRequest();
        registrationRequest.setEmail(Constants.adminUsername);
        registrationRequest.setName(Constants.adminUsername);
        registrationRequest.setUsername(Constants.adminUsername);
        registrationRequest.setPassword(Constants.adminPassword);

        userService.registerUser(registrationRequest);

        try {
            User createdUser = userService.getUserByUsername("admin").get();
            roleService.addAdminRole(createdUser.getId());
        } catch (Exception e) {
            System.out.println("ex : " + e);
        }

    }

    @Override
    public void run(String... args) throws Exception {

        // Create administrator to be used in tests
        addAdminUser();
    }
}