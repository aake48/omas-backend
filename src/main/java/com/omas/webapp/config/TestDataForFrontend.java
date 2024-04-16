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
                "Kesän Ampujaiset",
                "Talvi Pistooli",
                "Tarkkuuslaukaus-festivaali",
                "Kiväärikilpailujen huipennus",
                "Polaris-ampumaharjoitus",
                "Aamunkoiton tähtäys",
                "Nordic Sharpshooters Cup",
                "Taivaanranta-tulitus",
                "Lumivyöry-ammunta");

        List<String> pistolCompetitionList = Arrays.asList(
                "Tarkka-ammunta Cup",
                "Nopean laukauksen mestaruus",
                "Moniottelu",
                "Kansallinen tähtäyskilpailu",
                "Kaupunkiammunta-challenge",
                "Laukausmaraton",
                "Vapaa-asekilpailu",
                "Taitoluodikko-turnaus",
                "Precision Pistol Cup",
                "Tulevaisuuden Ampuja",
                "Pikakivääri-klassikko");

        List<String> clubList = Arrays.asList(
                "Poliisiseura", "Koiraseura",
                "Hammaspeikkoseura",
                "dog",
                "Savu Seura",
                "OMAS",
                "Pelleseura",
                "Yung Tallent",
                "Aseharrastajien Yhtenäisyys",
                "Tähtäysmestarit",
                "Laukausryhmä Aurora",
                "Ampumataito");

        List<User> users = new ArrayList<>();
        List<String> clubIds = new ArrayList<>();

        for (String clubName : clubList) {

            int memberCount = ThreadLocalRandom.current().nextInt(3, 6);

            String clubId = Constants.createIdString(clubName);

            if (clubId == null) {
                throw new Exception("Bad input in club name");
            }

            clubIds.add(clubId);

            Club club = new Club(clubName, clubId, 0);
            clubRepository.save(club);

            users.addAll(generateUsersForClub(memberCount, clubId));
        }

        userRepository.saveAll(users);

        List<Competition> rifleComps = saveCompetitions(rifleCompetitionList, rifleCompetitionTypeName);
        List<Competition> pistolComps = saveCompetitions(pistolCompetitionList, pistolCompetitionTypeName);

        saveTeamsToComps(rifleComps);
        saveTeamsToComps(pistolComps);

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

        ThreadLocalRandom random = ThreadLocalRandom.current();

        for (String competitionName : competitionNames) {

            long currentTime = System.currentTimeMillis();

            int competitionLengthClass = random.nextInt(2);

            // Different "length classes" for competitions
            int maxDays = switch (competitionLengthClass) {
                case 0 -> 730;
                case 1 -> 60;
                default -> throw new IllegalStateException("Unexpected value: " + competitionLengthClass);
            };

            // Minimum 1 week competition
            int competitionLength = random.nextInt(7, maxDays);

            long day = 24 * 60 * 60 * 1000;
            boolean shouldStartInFuture = random.nextBoolean();

            long startDate;

            // 50% chance for competition to start in the future, i.e. subtract or add the randomly generated number of days from the current time
            if (!shouldStartInFuture) {
                startDate = currentTime - (day * random.nextInt(0, maxDays));
            } else {
                startDate = currentTime + (day * random.nextInt(0, maxDays));
            }

            long endDate = startDate + (day * competitionLength);

            String competitionId = Constants.createIdString(competitionName);

            if (competitionId == null) {
                throw new IllegalStateException("Competition id is null while creating test data");
            }

            Competition competition = new Competition(competitionId, competitionName, type, startDate, endDate);

            competitions.add(competition);
        }
        return competitionRepository.saveAll(competitions);
    }

    private List<Team> saveTeamsToComps(List<Competition> competitions) {
        log.info("adding teams");

        List<Team> teams = new ArrayList<>();

        for (Competition comp : competitions) {

            // Add a team for each club in each competition
            for (Club club : clubRepository.findAll()) {

                TeamId teamId = new TeamId(comp.getCompetitionId(), club.getName());

                Team team = new Team(teamId, club.getNameNonId(), club.getName());

                teams.add(team);
            }
        }
        return teamRepository.saveAll(teams);
    }

    private void addMemberWithScores(List<User> users, List<Competition> competitions, String compType) throws JsonProcessingException {
        log.info("adding member and scores");

        for (User user : users) {
            for (Competition comp : competitions) {

                TeamMember teamMember = new TeamMember(comp.getCompetitionId(), user.getId(), user.getPartOfClub());

                teamMemberRepository.save(teamMember);
                log.info(" club: " + user.getPartOfClub());

                TeamMemberId teamMemberId = new TeamMemberId(user.getId(), comp.getCompetitionId(), user.getPartOfClub());
                TeamMemberScore teamMemberScore = new TeamMemberScore(teamMemberId, give60shots(), 10);

                TeamMemberScore score = teamMemberScoreRepository.save(teamMemberScore);
                log.info(" userId: " + score.getUserId());

            }
        }
    }

}
