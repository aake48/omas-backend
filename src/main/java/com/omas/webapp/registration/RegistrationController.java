package com.omas.webapp.registration;

import java.rmi.ServerException;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.omas.webapp.user.User;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.omas.webapp.user.UserService;

@RestController
@RequestMapping(path = "/api/reg")
public class RegistrationController {

	private final UserService userService;

	public RegistrationController(UserService userService) {
		this.userService = userService;
	}

	@PostMapping(path = "/new", consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<User> create(@RequestBody User newUser) throws ServerException {
		User user = userService.registerUser(newUser);
		if (user == null) {
			return new ResponseEntity<>(user, HttpStatus.BAD_REQUEST);
		} else {
			return new ResponseEntity<>(user, HttpStatus.CREATED);
		}
	}

}
