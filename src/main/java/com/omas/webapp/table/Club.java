package com.omas.webapp.table;

import java.sql.Timestamp;
import java.time.Instant;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
public class Club { 

	@Id
	private String name; 
	
	private String nameNonId;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Timestamp creationDate;
	private long idCreator;

	@JsonIgnore
	private String passkey;

	public Club(String clubName, String clubId, long creatorId) {
		this.name = clubId.toLowerCase();
		this.nameNonId = clubName;
		this.idCreator = creatorId;
		this.creationDate = new Timestamp(Instant.now().toEpochMilli());
		this.passkey=null;
	}
} 