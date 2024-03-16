// package com.omas.webapp.repoTests;

// import static org.junit.jupiter.api.Assertions.assertEquals;
// import static org.junit.jupiter.api.Assertions.fail;

// import java.util.ArrayList;
// import java.util.List;
// import java.util.Optional;

// import com.omas.webapp.TestUtils;
// import com.omas.webapp.repository.ClubRepository;
// import com.omas.webapp.repository.CompetitionRepository;
// import com.omas.webapp.repository.TeamMemberRepository;
// import com.omas.webapp.repository.TeamMemberScoreRepository;
// import com.omas.webapp.repository.TeamRepository;
// import com.omas.webapp.repository.UserRepository;
// import com.omas.webapp.table.Club;
// import com.omas.webapp.table.Competition;
// import com.omas.webapp.table.Team;
// import com.omas.webapp.table.TeamId;
// import com.omas.webapp.table.TeamMember;
// import com.omas.webapp.table.TeamMemberId;
// import com.omas.webapp.table.TeamMemberScore;
// import com.omas.webapp.table.User;
// import jakarta.validation.ConstraintViolationException;
// import org.junit.jupiter.api.Test;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
// import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
// import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
// import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
// import org.springframework.test.annotation.Rollback;
// @DataJpaTest
// @AutoConfigureTestDatabase(replace = Replace.NONE)
// @Rollback(true)

// public class SaveScoresTests {

//     @Autowired
//     private TeamMemberScoreRepository teamMemberScoreRepository;

//     @Autowired
//     private TeamRepository teamRepository;

//     @Autowired 
//     private TeamMemberRepository teamMemberRepository;

//     @Autowired 
//     private UserRepository userRepository;

//     @Autowired
//     private ClubRepository clubRepository;

//     @Autowired 
//     private CompetitionRepository competitionRepository;

//     @Autowired
//     private TestEntityManager entityManager;

//     @Test
//     public void SaveScores() {

//             String clubName = "clubi";

//             Club club = new Club();
//             club.setName(clubName);
//             clubRepository.save(club);

//             String compName = "competition";
//             Competition competition = new Competition(compName, compName, "rifle", System.currentTimeMillis(), System.currentTimeMillis());
//             competition.setName(compName);
//             competitionRepository.save(competition);

//             TeamId teamId = new TeamId(clubName, compName, "team");

//             Team team = new Team(teamId);

//             teamRepository.save(team);
//             teamRepository.findById(teamId);

//             List<User> users = new ArrayList<>();

//             for (int i = 0; i < 5; i++) {
//                     User user = new User();
//                     user.setUsername(String.valueOf(i));
//                     user.setPartOfClub(clubName);
//                     users.add(new User());
//             }
//             users = userRepository.saveAll(users);

//             for (User user : users) {
//                 TeamMember teamMember = new TeamMember( teamId.getClubId(), teamId.getCompetitionId(), user.getId(), teamId.getClubId());
//                 teamMemberRepository.save(teamMember);
//             }

//             List<TeamMemberScore> scores = new ArrayList<>();

//             for (int i = 0; i < users.size(); i++) {
//                 scores.add(new TeamMemberScore(new TeamMemberId(users.get(i).getId(), teamId),
//                                 TestUtils.give60shots(), true));
//             }

//             scores = teamMemberScoreRepository.saveAll(scores);
//             // ...

//             try {
//                 // Create a new TeamMemberScore with an invalid user ID
//                 teamMemberScoreRepository.save(new TeamMemberScore(new TeamMemberId(342234l, teamId),
//                         TestUtils.give60shots(), true));
//                 entityManager.flush();
//                 fail("Expected an exception to be thrown due to foreign key constraint violation");
//             } catch (Exception e) { 
//                 if (e instanceof ConstraintViolationException) {
//                     System.out.println("e: "+e);
//                     return;
//                 }
//             }

//             Optional<Team> palautus = teamRepository.findById(teamId);

//             if(!palautus.isPresent()){
//                 fail();
//             }

//             assertEquals(5, scores.size(), "Scores list should have 5 elements");
//     }


// }
