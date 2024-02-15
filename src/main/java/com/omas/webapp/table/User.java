package com.omas.webapp.table;

import java.sql.Date;

import org.hibernate.validator.constraints.UniqueElements;

import jakarta.persistence.Entity; 
import jakarta.persistence.GeneratedValue; 
import jakarta.persistence.GenerationType; 
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor; 
import lombok.Data; 
import lombok.NoArgsConstructor; 

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user_")
public class User { 

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private long id; 
	private String username; 
	private String legalname; 
	private String email;
	private String password;
	private Date CreationDate;
	private String roles; 

} 
