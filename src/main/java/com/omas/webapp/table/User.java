package com.omas.webapp.table;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity; 
import jakarta.persistence.GeneratedValue; 
import jakarta.persistence.GenerationType; 
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor; 

@Entity
@Data
@Table(name = "user_")
public class User { 

	public User updateLastLogin(){
		lastLogin = new Timestamp(Instant.now().toEpochMilli());
		return this;
	}

	public User() {
		this.creationDate=new Timestamp(Instant.now().toEpochMilli());
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private long id; 
	@Column(unique = true)
	private String username;
	private String legalName;
	@Column(unique = true)
	private String email;
	@JsonIgnore
	private String password;
	@Column(updatable = false)
	private Timestamp creationDate;
	private Timestamp lastLogin;
	private String partOfClub;

    @OneToMany(mappedBy = "userId", cascade = CascadeType.ALL)
    @Getter
    private List<Role> roles = new ArrayList<>();

} 
