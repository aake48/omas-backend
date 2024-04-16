package com.omas.webapp.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.omas.webapp.Constants;
import com.omas.webapp.repository.*;
import com.omas.webapp.service.*;
import com.omas.webapp.table.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

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

    // The 10 most common male names and 10 most common female names as of 1.4.2024
    // additionally the names of people involved in this project
    private final List<String> FINNISH_FIRST_NAMES = List.of(
        "Juhani", "Johannes", "Olavi", "Antero",
        "Tapani", "Kalevi", "Tapio", "Matti", "Mikael", "Ilmari",
        "Maria", "Helena", "Johanna", "Anneli", "Kaarina",
        "Marjatta", "Anna", "Liisa", "Sofia", "Annikki",
        "Lauri", "Ville", "Ari", "Janne", "Lassi", "Antti",
        "Markus", "Teemu", "Walter"
    );

    // The 10 most common Finnish last names as of 1.4.2024
    // and the last names of people involved with this project
    private final List<String> FINNISH_LAST_NAMES = List.of(
        "Korhonen", "Virtanen", "Mäkinen",
        "Nieminen", "Mäkelä", "Hämäläinen",
        "Laine", "Heikkinen", "Koskinen",
        "Järvinen", "Lehtinen", "Holappa",
        "Komulainen", "Ollakka", "Juustila",
        "Kumpulainen", "Kelanti", "Määttä"
    );

    @Override
    public void run(String... args) throws Exception {

        final String pistolCompetitionTypeName = Constants.PISTOL_TYPE;
        final String rifleCompetitionTypeName = Constants.RIFLE_TYPE;

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

        for (String clubName : clubList) {

            int memberCount = ThreadLocalRandom.current().nextInt(3, 6);

            Club club = new Club(clubName, clubName, 0);
            clubRepository.save(club);

            users.addAll(generateUsersForClub(memberCount, clubName));
        }

        userRepository.saveAll(users);

        List<Competition> rifleComps = saveCompetitions(rifleCompetitionList, rifleCompetitionTypeName);
        List<Competition> pistolComps = saveCompetitions(pistolCompetitionList, pistolCompetitionTypeName);

        saveTeamsToComps(rifleComps, clubList);
        saveTeamsToComps(pistolComps, clubList);

        addMemberWithScores(users, pistolComps, pistolCompetitionTypeName);
        addMemberWithScores(users, rifleComps, rifleCompetitionTypeName);

    }

    private List<User> generateUsersForClub(int x, String clubName) {

        List<User> users = new ArrayList<>(x);

        for (int i = 0; i < x; i++) {

            User user = new User();

            user.setUsername(generateRandomString(10));
            user.setLegalName(generateRandomName());
            user.setPartOfClub(clubName);

            users.add(user);
        }

        return users;
    }

    private String generateRandomName() {

        ThreadLocalRandom random = ThreadLocalRandom.current();

        String firstName = FINNISH_FIRST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));
        String lastName = FINNISH_LAST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));

        return firstName + " " + lastName;
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

    public static double give60shots() {

        double sum = 0.0;

        for (int i = 0; i < 60; i++) {
            sum += ThreadLocalRandom.current().nextDouble() * 10.9;
        }

        return sum;
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
            user.setLegalName(generateRandomName());
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

            long currentTime = System.currentTimeMillis();

            long day = 24 * 60 * 60 * 1000;

            // Generate random number of days
            int minusDays = ThreadLocalRandom.current().nextInt(0, 730);
            int plusDays = ThreadLocalRandom.current().nextInt(0, 730);

            long startDate = currentTime + (day * minusDays);
            long endDate = currentTime + (day * plusDays);

            Competition competition = new Competition(competitionName, competitionName, type, startDate, endDate);

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

    private void addMemberWithScores(List<User> users, List<Competition> competitions, String compType) throws JsonProcessingException {
        log.info("adding member and scores");

        for (User user : users) {
            for (Competition comp : competitions) {
                TeamMember teamMember = new TeamMember(comp.getCompetitionId(), user.getId(),
                        user.getPartOfClub());
                teamMember = teamMemberRepository.save(teamMember);
                log.info(" club: " + user.getPartOfClub());

                TeamMemberId teamMemberId = new TeamMemberId(user.getId(), comp.getCompetitionId(), user.getPartOfClub());
                TeamMemberScore teamMemberScore = new TeamMemberScore(teamMemberId, give60shots(), 10);

                TeamMemberScore score = teamMemberScoreRepository.save(teamMemberScore);
                log.info(" userId: " + score.getUserId());

            }
        }
    }

}
