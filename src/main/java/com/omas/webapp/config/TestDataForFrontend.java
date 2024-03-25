package com.omas.webapp.config;

import com.omas.webapp.Constants;
import com.omas.webapp.repository.*;
import com.omas.webapp.service.*;
import com.omas.webapp.table.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

@Log4j2
@Component
public class TestDataForFrontend implements CommandLineRunner {

    @Autowired
    UserService userService;

    @Autowired
    ClubService clubService;

    @Autowired
    RoleService roleService;

    @Autowired
    TeamMemberScoreService teamMemberScoreService;

    @Autowired
    CompetitionService competitionService;

    @Autowired
    TeamService teamService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ClubRepository clubRepository;

    @Autowired
    TeamRepository teamRepository;

    @Autowired
    CompetitionRepository competitionRepository;

    @Autowired
    TeamMemberScoreRepository teamMemberScoreRepository;

    @Autowired
    TeamMemberRepository teamMemberRepository;

    @Override
    public void run(String... args) throws Exception {

        final String pistolCompetitionTypeName = Constants.pistolType;
        final String rifleCompetitionTypeName = Constants.rifleType;

        List<String> rifleCompetitionList = Arrays.asList(
                "kesan_ampujaiset",
                "talvi_pistooli",
                "lasten_ammunta",
                "seniori-ammunta",
                "tarkkuuslaukaus-festivaali",
                "kivaarikilpailujen-huipennus",
                "polaris-ampumaharjoitus",
                "aamunkoiton-tahtays",
                "nordic-sharpshooters-cup",
                "taivaanranta-tulitus",
                "lumivyory-ammunta");

        List<String> pistolCompetitionList = Arrays.asList(
                "tarkka-ammunta-cup",
                "nopean-laukauksen-mestaruus",
                "moniottelu-kilpailu",
                "kansallinen-tahtayskilpailu",
                "kaupunkiammunta-challenge",
                "laukausmaraton",
                "vapaa-asekilpailu",
                "taitoluodikko-turnaus",
                "precision-pistol-cup",
                "tulevaisuuden-ampuja",
                "pikakivaari-klassikko");

        List<String> clubList = Arrays.asList(
                "Poliisi_seura", "Koira_seura",
                "Hammaspeikko_seura",
                "dog",
                "SavuSeura",
                "OMAS",
                "Pelle_seura",
                "young_tallent_-seura",
                "aseharrastajien-yhtenaisyys",
                "tahtaysmestarit",
                "laukausryhma-aurora",
                "ampumataito");

        List<User> users = new ArrayList<>();
        for (int i = 0; i < clubList.size(); i++) {
            users.addAll((saveUserToDB(getXStrings(5), clubList.get(i))));
        }

        List<Competition> rifleComps = saveCompetitions(rifleCompetitionList,
                rifleCompetitionTypeName);
        List<Competition> pistolComps = saveCompetitions(pistolCompetitionList,
                pistolCompetitionTypeName);
        saveTeamsToComps(rifleComps, clubList);
        saveTeamsToComps(pistolComps, clubList);
        addMemberWithScores(users, pistolComps, pistolCompetitionTypeName);
        addMemberWithScores(users, rifleComps, rifleCompetitionTypeName);

    }

    private List<String> getXStrings(int x) {
        List<String> strings = new ArrayList<>();

        for (int i = 0; i < x; i++) {
            strings.add(generateRandomString(10));
        }
        return strings;
    }

    public String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random rand = new Random();
        StringBuilder sb = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int randomIndex = rand.nextInt(characters.length());
            sb.append(characters.charAt(randomIndex));
        }

        return sb.toString();
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

    /**
     * creates a club and saves list of users to db with the being part of the
     * just
     * created club.
     * Returns list of Users.
     */
    private List<User> saveUserToDB(List<String> usernames, String ClubName) {
        log.info("adding users to DB");

        Club club = new Club(ClubName, ClubName, 0);
        clubRepository.save(club);

        List<User> users = new ArrayList<>();

        for (String name : usernames) {
            User user = new User();
            user.setUsername(name);
            user.setLegalname(name);
            user.setPartOfClub(ClubName);
            users.add(user);
        }
        return userRepository.saveAll(users);
    }

    private List<Competition> saveCompetitions(List<String> competitionNames,
            String type) {
        log.info("adding competitions to DB");

        List<Competition> competitions = new ArrayList<>();

        for (String competitionName : competitionNames) {
            Competition competition = new Competition(competitionName, competitionName,
                    type,
                    System.currentTimeMillis(), System.currentTimeMillis() + 7L * 24 * 60 * 60 *
                            1000);
            competitions.add(competition);
        }
        return competitionRepository.saveAll(competitions);
    }

    private List<Team> saveTeamsToComps(List<Competition> competitions,
            List<String> ClubNames) {
        log.info("adding teams");

        List<Team> teams = new ArrayList<>();

        for (Competition comp : competitions) {
            for (String club : ClubNames) {
                Team team = new Team(new TeamId(comp.getCompetitionId(), club), club, club);
                teams.add(team);
            }
        }
        return teamRepository.saveAll(teams);
    }

    private void addMemberWithScores(List<User> users, List<Competition> competitions, String compType) {
        log.info("adding member and scores");

        Boolean acceptDecimals = false;
        if (compType.equals(Constants.rifleType)) {
            acceptDecimals = true;
        }

        for (User user : users) {
            for (Competition comp : competitions) {
                TeamMember teamMember = new TeamMember(comp.getCompetitionId(), user.getId(),
                        user.getPartOfClub());
                teamMember = teamMemberRepository.save(teamMember);
                log.info(" club: " + user.getPartOfClub());

                TeamMemberScore teamMemberScore = new TeamMemberScore(
                        new TeamMemberId(user.getId(), comp.getCompetitionId(), user.getPartOfClub()), give60shots(),
                        acceptDecimals);

                TeamMemberScore score = teamMemberScoreRepository.save(teamMemberScore);
                log.info(" userId: " + score.getUserId());

            }
        }
    }

}
