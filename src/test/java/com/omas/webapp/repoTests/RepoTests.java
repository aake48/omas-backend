package com.omas.webapp.repoTests;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.Date;
import java.time.Instant;
import java.util.List;

import com.omas.webapp.repository.TeamRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
import com.omas.webapp.repository.ClubRepository;
import com.omas.webapp.repository.CompetitionRepository;
import com.omas.webapp.table.Club;
import com.omas.webapp.table.Competition;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class RepoTests {

	// @Autowired
	// private TeamRepository teamRepository;
	@Autowired
	private ClubRepository clubRepository;
	@Autowired
	private CompetitionRepository competitionRepository;

	@Test
	public void testFindClubByName() {
		Club club = new Club("seura2", new Date(Instant.now().toEpochMilli()), 1);
		club = clubRepository.save(club);

		Club foundClub = clubRepository.findByName("seura2").orElse(null);

		assertEquals(club.getName(), foundClub.getName());
	}

	@Test
	public void testFindCompetitionByName() {
		Competition comp = new Competition("kilpailu2", new Date(Instant.now().toEpochMilli()));
		comp = competitionRepository.save(comp);

		Competition foundComp = competitionRepository.findById("kilpailu2").orElse(null);

		assertEquals(comp.getName(), foundComp.getName());
	}

	@Test
	public void testAddTeamClubAndComp() {
		Club club = new Club("seura1", new Date(Instant.now().toEpochMilli()), 1);

		club = clubRepository.save(club);

		Competition comp = new Competition("kilpailu1", new Date(Instant.now().toEpochMilli()));

		comp = competitionRepository.save(comp);

		// Team team = new Team();
		// team.setClubId(club.getName());
		// team.setCompetitionId(comp.getName());

		// team = teamRepository.save(team);
		// assertThat(team).isNotNull();
		assertThat(club).isNotNull();
		assertThat(comp).isNotNull();
	}

}
