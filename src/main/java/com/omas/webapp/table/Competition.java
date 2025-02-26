package com.omas.webapp.table;

import java.sql.Timestamp;
import java.time.Instant;
import com.fasterxml.jackson.annotation.JsonFormat;
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

	public Competition(String competitionId, String displayName, String competitionType, String competitionSeries, Long startDate, Long endDate) {
		this.competitionId = competitionId.toLowerCase();
		this.displayName = displayName;
		this.creationDate = new Timestamp(Instant.now().toEpochMilli());
		this.type = competitionType;
		this.competitionSeries = competitionSeries;
		this.startDate = new Timestamp(startDate);
		this.endDate = new Timestamp(endDate);
	}

	@Id
	private String competitionId;

	private String displayName;

	private String type;

	private String competitionSeries;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Timestamp startDate;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Timestamp endDate;

	@Column(nullable = false)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
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