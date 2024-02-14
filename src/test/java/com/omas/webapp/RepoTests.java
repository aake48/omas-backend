package com.omas.webapp;

import static org.assertj.core.api.Assertions.assertThat;

import java.sql.Date;
import java.time.Instant;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

import com.omas.webapp.repository.ClubRepository;
import com.omas.webapp.repository.CompetitionRepository;
import com.omas.webapp.repository.TeamRepository;
import com.omas.webapp.table.Club;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.Team;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class RepoTests {

	@Autowired
	private TeamRepository teamRepository;
	@Autowired
	private ClubRepository clubRepository;
	@Autowired
	private CompetitionRepository competitionRepository;



	@Test
	public void noClubs() {
		List<Club> clubs = clubRepository.findAll();

		assertThat(clubs).isEmpty();
	}

	@Test
	public void testAddTeam() {
		Club club = new Club("seura1", new Date(Instant.now().toEpochMilli()));

		club = clubRepository.save(club);

		Competition comp = new Competition("kilpailu1", new Date(Instant.now().toEpochMilli()));

		comp = competitionRepository.save(comp);

		Team team = new Team();
		team.setClubId(club.getName());
		team.setCompetitionId(comp.getName());

		team = teamRepository.save(team);
		assertThat(team).isNotNull();
	}

	@Test
	public void addteam() {

		Team team = new Team();
		team.setClubId("club");
		team.setCompetitionId("comp");


		
		try {
			Team res = teamRepository.save(team);
			assertThat(res).isNotNull();
		} catch (Exception e) {
			return;
		} 
	}


}
