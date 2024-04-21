package com.omas.webapp.config;

import com.omas.webapp.Constants;
import com.omas.webapp.entity.requests.RegistrationRequest;
import com.omas.webapp.repository.*;
import com.omas.webapp.service.*;
import com.omas.webapp.table.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

@Log4j2
@Profile("dev")
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

    private void addAdminUser() throws Exception {

        RegistrationRequest registrationRequest = new RegistrationRequest();
        registrationRequest.setEmail("adminin sähköposti");
        registrationRequest.setName("adminin nimi");
        registrationRequest.setUsername("admin");
        registrationRequest.setPassword("adminPassword");

        userService.registerUser(registrationRequest);

        try {
            User createdUser = userService.getUserByUsername("admin").get();
            roleService.addAdminRole(createdUser.getId());
        } catch (Exception e) {
            System.out.println("ex : " + e);
        }

    }

    @Override
    public void run(String... args) throws Exception {

        addAdminUser();

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

        for (String clubName : clubList) {

            String clubId = Constants.createIdString(clubName);

            if (clubId == null) {
                throw new Exception("Bad input in club name");
            }

            Club club = new Club(clubName, clubId, 0);

            System.out.printf("creating club: %s (%s)\n", club.getNameNonId(), club.getName());

            clubRepository.save(new Club(clubName, clubId, 0));
        }

        List<Competition> rifleComps = saveCompetitions(rifleCompetitionList, rifleCompetitionTypeName);
        List<Competition> pistolComps = saveCompetitions(pistolCompetitionList, pistolCompetitionTypeName);

        saveTeamsToComps(rifleComps);
        saveTeamsToComps(pistolComps);

        populateTeamsAndScores();
    }

    private String generateRandomName() {

        ThreadLocalRandom random = ThreadLocalRandom.current();

        String firstName = FINNISH_FIRST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));
        String lastName = FINNISH_LAST_NAMES.get(random.nextInt(FINNISH_LAST_NAMES.size()));

        return firstName + " " + lastName;
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

    private List<Competition> saveCompetitions(List<String> competitionNames, String type) {
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

            System.out.printf("creating competition: %s (%s)\n", competition.getDisplayName(), competition.getCompetitionId());

            competitions.add(competition);
        }

        return competitionRepository.saveAll(competitions);
    }

    private List<Team> saveTeamsToComps(List<Competition> competitions) throws Exception {

        List<Team> teams = new ArrayList<>();

        for (Competition comp : competitions) {

            // Add a team for each club in each competition
            for (Club club : clubRepository.findAll()) {

                // Generate 1-3 teams for each club
                int teamCount = ThreadLocalRandom.current().nextInt(1, 4);

                for (int i = 1; i <= teamCount; i++) {

                    String teamDisplayName = club.getNameNonId() + " " + i;
                    String teamName = Constants.createIdString(teamDisplayName);

                    if (teamName == null) {
                        throw new Exception("Failed to generate a valid team name in TestDataForFrontend");
                    }

                    TeamId teamId = new TeamId(comp.getCompetitionId(), teamName);

                    Team team = new Team(teamId, teamDisplayName, club.getName());

                    System.out.printf("creating team: %s (%s) for competition %s (%s)\n", team.getTeamDisplayName(), team.getTeamName(), comp.getDisplayName(), comp.getCompetitionId());

                    teams.add(team);
                }

            }
        }

        return teamRepository.saveAll(teams);
    }

    private void populateTeamsAndScores() {

        for (Team team : teamRepository.findAll()) {

            int memberCount = ThreadLocalRandom.current().nextInt(3, 6);

            for (int i = 0; i < memberCount; i++) {

                User user = new User();

                user.setUsername(generateRandomString(10));
                user.setLegalName(generateRandomName());
                user.setPartOfClub(team.getClubName());

                user = userRepository.save(user);

                System.out.printf("userId: %d, creating %s and their scores for team %s (%s)\n", user.getId(), user.getLegalName(), team.getTeamDisplayName(), team.getTeamName());

                TeamMember member = new TeamMember(team.getCompetitionId(), user.getId(), team.getTeamName());

                teamMemberRepository.save(member);

                TeamMemberScore score = new TeamMemberScore(member.getId(), give60shots(), 10, 10);

                teamMemberScoreRepository.save(score);
            }
        }

    }

}
