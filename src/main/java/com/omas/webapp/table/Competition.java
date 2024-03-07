package com.omas.webapp.table;

import java.sql.Date;
import java.time.Instant;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table
@NoArgsConstructor
public class Competition {

	public Competition(String competitionName, String nonIdName, String competitionType) {
		this.name = competitionName;
		this.nameNonId = competitionName;
		this.creationDate = new Date(Instant.now().toEpochMilli());
		this.type = competitionType;
	}

	@Id
	private String name;

	private String nameNonId;

	private String type;

	@Column(nullable = false)
	private Date creationDate;

}