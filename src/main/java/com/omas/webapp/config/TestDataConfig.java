package com.omas.webapp.config;

import java.sql.Date;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import com.omas.webapp.service.ClubService;
import com.omas.webapp.service.CompetitionService;
import com.omas.webapp.service.TeamMemberScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.Club;
import com.omas.webapp.table.Competition;
import com.omas.webapp.table.TeamMemberId;

@Component
public class TestDataConfig implements CommandLineRunner {

    @Autowired
    UserService userService;

    @Autowired
    ClubService clubService;

    @Autowired
    TeamMemberScoreService teamMemberScoreService;

    @Autowired
    CompetitionService competitionService;

    @Autowired
    TeamService teamService;

    @Override
    public void run(String... args) throws Exception {

        List<String> competitionList = Arrays.asList("kesan_ampujaiset", "talvi_pistooli", "lasten_ammunta",
                "seniori-ammunta");
        for (String competition : competitionList) {
            competitionService
                    .addCompetition(new Competition(competition, competition, new Date(Instant.now().toEpochMilli())));

        }

        List<String> clubList = Arrays.asList("Poliisi_seura", "Koira_seura", "Hammaspeikko_seura", "dog", "SavuSeura",
                "OMAS", "Pelle_seura", "young_tallent_-seura");
        for (String club : clubList) {
            clubService.registerClub(new Club(club, club, new Date(Instant.now().toEpochMilli()), 1));
        }

        for (String competition : competitionList) {
            for (String club : clubList) {
                teamService.addTeam(competition, club);
                for (int i = 0; i < 5; i++) {
                    addTeamMemberWithScores(club, competition);

                }
            }
        }
    }

    private void addTeamMemberWithScores(String club, String competition) throws Exception {
        Long userId = getRandomNumber();
        teamService.addTeamMember(new TeamMemberId(userId, club, competition));
        teamMemberScoreService.addUsersScore(new TeamMemberId(userId, club, competition), give60shots());

    }

    private Long getRandomNumber() {
        Random random = new Random();
        return random.nextLong(1000);
    }

    private static List<Double> give60shots() {
        Random rand = new Random();
        List<Double> shots = new ArrayList<>();

        for (int i = 0; i < 60; i++) {
            double shot = rand.nextDouble() * 10.9;
            shot = Math.round(shot * 10.0) / 10.0;
            shots.add(shot);
        }
        return shots;

    }

}
