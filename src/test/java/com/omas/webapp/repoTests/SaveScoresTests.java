package com.omas.webapp.repoTests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.omas.webapp.TestUtils;
import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.repository.TeamMemberScoreRepository;
import com.omas.webapp.repository.TeamRepository;
import com.omas.webapp.repository.UserRepository;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import com.omas.webapp.table.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)

public class SaveScoresTests {

    @Autowired
    private TeamMemberScoreRepository teamMemberScoreRepository;

    @Autowired
    private TeamRepository teamRepository;

    @Autowired 
    private TeamMemberRepository teamMemberRepository;

    @Autowired 
    private UserRepository userRepository;

    @Test
    public void SaveScores() {

            String clubName = "clubi";

            TeamId teamId = new TeamId("Clubi1", "kilpa1");

            Team team = new Team(teamId);

            teamRepository.save(team);

            List<User> users = new ArrayList<>();

            for (int i = 0; i < 5; i++) {
                    User user = new User();
                    user.setUsername(String.valueOf(i));
                    user.setPartOfClub(clubName);
                    users.add(new User());
            }
            users = userRepository.saveAll(users);

            for (User user : users) {
                    TeamMember teamMember = new TeamMember(new TeamMemberId(user.getId(), teamId));
                    teamMemberRepository.save(teamMember);
            }

            List<TeamMemberScore> scores = new ArrayList<>();

            for (int i = 0; i < users.size(); i++) {
                    scores.add(new TeamMemberScore(new TeamMemberId(users.get(i).getId(), teamId),
                                    TestUtils.give60shots(), true));
            }

            scores = teamMemberScoreRepository.saveAll(scores);

            scores = teamMemberScoreRepository.findByTeamId(teamId);
            for(int i = 0; i < scores.size(); i++){
                System.out.println(i+". score:"+ scores.get(i).toString()+
                " userId club comp :: " + scores.get(i).getUserId()+" "+scores.get(i).getClubId() +" "+ scores.get(i).getCompetitionId());

            }

            Optional<Team> palautus = teamRepository.findById(teamId);

            if(!palautus.isPresent()){
                fail();
            }

            assertEquals(5, scores.size(), "Scores list should have 5 elements");
    }


}
