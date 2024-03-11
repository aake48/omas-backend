// package com.omas.webapp.repoTests;

// import com.omas.webapp.repository.TeamRepository;
// import com.omas.webapp.table.Team;
// import com.omas.webapp.table.TeamId;
// import static org.junit.jupiter.api.Assertions.assertFalse;
// import static org.junit.jupiter.api.Assertions.assertTrue;
// import java.util.Optional;
// import org.junit.jupiter.api.Test;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
// import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
// import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
// import org.springframework.test.annotation.Rollback;

// @DataJpaTest
// @AutoConfigureTestDatabase(replace = Replace.NONE)
// @Rollback(true)
// public class TeamRepoTests {

// 	@Autowired
// 	TeamRepository repository;

// 	@Test
// 	public void addAndFindById() {

// 		TeamId id = new TeamId("club", "comp", "team");
		
// 		Team team = new Team(id);
// 		Team team2 = new Team(new TeamId("club2", "comp","team"));
// 		Team team3 = new Team(new TeamId("club3", "comp","team"));

// 		repository.save(team);
// 		repository.save(team2);
// 		repository.save(team3);

// 		Optional<Team> result1 = repository.findById(id);
// 		Optional<Team> result2 = repository.findById(new TeamId("3523", "45gfr","team"));



// 		System.out.println(result1.get().getClubId());
// 		System.out.println(team.getClubId());

// 		System.out.println(result1.get().getCompetitionId());
// 		System.out.println(team.getCompetitionId());


// 		assertTrue(result1.isPresent());
// 		// assertEquals(result1.get(), team);
// 		// assertEquals(result3.get(), team3);
// 		assertFalse(result2.isPresent());

		
		
// 	}

// }
