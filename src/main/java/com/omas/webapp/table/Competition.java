package com.omas.webapp.table;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity; 
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor; 

@Entity
@Data
@AllArgsConstructor
@Table
@NoArgsConstructor
public class Competition { 

	@Id
	private String name;

	@Column(nullable = false)
	private Date creationDate;
 
} 