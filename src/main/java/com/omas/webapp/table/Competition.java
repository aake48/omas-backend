package com.omas.webapp.table;

import java.sql.Timestamp;
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

	public Competition(String competitionId, String displayName, String competitionType, Long startDate, Long endDate) {
		this.competitionId = competitionId.toLowerCase();
		this.displayName = displayName;
		this.creationDate = new Timestamp(Instant.now().toEpochMilli());
		this.type = competitionType;
		this.startDate = new Timestamp(startDate);
		this.endDate = new Timestamp(endDate);
	}

	@Id
	private String competitionId;

	private String displayName;

	private String type;

	private Timestamp startDate;

	private Timestamp endDate;

	@Column(nullable = false)
	private Timestamp creationDate;

	public boolean hasEnded() {
		return Instant.ofEpochMilli(endDate.getTime()).isBefore(Instant.now());
	}

	public boolean hasStarted() {
		return Instant.now().isBefore(Instant.ofEpochMilli(startDate.getTime()));
	}

	public boolean isActive() {

		long currentTime = System.currentTimeMillis();

		return startDate.getTime() <= currentTime && endDate.getTime() > currentTime;
	}
}