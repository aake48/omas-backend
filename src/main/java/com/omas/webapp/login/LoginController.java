package com.omas.webapp.login;

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
@RequestMapping(path = "/api/login")
public class LoginController {

	private final UserService userService;

	public LoginController(UserService userService) {
		this.userService = userService;
	}

	@PostMapping(consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<User> login(@RequestBody User user) throws ServerException {
		User logginUser = userService.logginUser(user);
		if (logginUser == null) {
			return new ResponseEntity<>(logginUser, HttpStatus.FORBIDDEN);
		} else {
			return new ResponseEntity<>(logginUser, HttpStatus.ACCEPTED);
		}
	}
}
