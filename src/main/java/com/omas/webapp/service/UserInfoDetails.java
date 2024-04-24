package com.omas.webapp.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.omas.webapp.table.User;

import lombok.Getter;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class UserInfoDetails implements UserDetails {

	public static UserInfoDetails getDetails() {
		return (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}

	private String username;
	private @Getter String legalName;
	private String password;
	private @Getter String email;
	private @Getter Long id;
	private @Getter Timestamp creationDate;
	private @Getter String partOfClub;
	private List<GrantedAuthority> authorities;

	public UserInfoDetails(User user, List<String> roles) {

		username = user.getUsername();
		legalName = user.getLegalName();
		password = user.getPassword();
		email = user.getEmail();
		id = user.getId();
		partOfClub = user.getPartOfClub();
		creationDate = user.getCreationDate();
		authorities = roles.stream()
				.map(SimpleGrantedAuthority::new)
				.collect(Collectors.toList());
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
}
