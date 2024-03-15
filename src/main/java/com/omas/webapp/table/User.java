package com.omas.webapp.table;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity; 
import jakarta.persistence.GeneratedValue; 
import jakarta.persistence.GenerationType; 
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data; 
import lombok.NoArgsConstructor; 

@Entity
@Data
@NoArgsConstructor
@Table(name = "user_")
public class User { 

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private long id; 
	@Column(unique = true)
	private String username; 
	private String legalname; 
	@Column(unique = true)
	private String email;
	private String password;
	private Date CreationDate;
	private String partOfClub;

} 
