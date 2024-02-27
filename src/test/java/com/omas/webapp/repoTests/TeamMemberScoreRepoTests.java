package com.omas.webapp.repoTests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.ArrayList;
import java.util.List;

import com.omas.webapp.repository.TeamMemberScoreRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
import java.util.Random;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class TeamMemberScoreRepoTests {

    @Autowired
    private TeamMemberScoreRepository repo;

    private List<Double> give60shots() {

        Random rand = new Random();

        List<Double> shots = new ArrayList<>();
        
        for(int i=0; i<60;i++){
            shots.add(rand.nextDouble()* 10.9);
        }
        return shots;
    }

    @Test
        public void findByClubIdAndCompetitionId() {


                TeamMemberScore score1 = new TeamMemberScore(new TeamMemberId(1l, "Clubi1", "kilpa1"),give60shots());
                TeamMemberScore score2 = new TeamMemberScore(new TeamMemberId(2l, "Clubi1", "kilpa1"),give60shots());
                TeamMemberScore score3 = new TeamMemberScore(new TeamMemberId(3l, "Clubi1", "kilpa1"),give60shots());
                TeamMemberScore score4 = new TeamMemberScore(new TeamMemberId(4l, "Clubi1", "kilpa1"),give60shots());
                TeamMemberScore score5 = new TeamMemberScore(new TeamMemberId(5l, "Clubi1", "kilpa1"),give60shots());

                TeamMemberScore otherScore1 = new TeamMemberScore(new TeamMemberId(11l, "Clubi11", "kilpa1"),give60shots());
                TeamMemberScore otherScore2 = new TeamMemberScore(new TeamMemberId(111l, "club2", "kilpa1"),give60shots());


                repo.save(score1);
                repo.save(score2);
                repo.save(score3);
                repo.save(score4);
                repo.save(score5);

                repo.save(otherScore1);
                repo.save(otherScore2);


                List<TeamMemberScore> scores = repo.findByTeamId(new TeamId("Clubi1", "kilpa1"));

                assertEquals(5, scores.size(), "Scores list should have 5 elements");
        }

}
