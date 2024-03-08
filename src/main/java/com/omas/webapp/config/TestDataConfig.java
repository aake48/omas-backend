// package com.omas.webapp.config;

// import java.sql.Date;
// import java.time.Instant;
// import java.util.ArrayList;
// import java.util.Arrays;
// import java.util.List;
// import java.util.Random;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.boot.CommandLineRunner;
// import org.springframework.stereotype.Component;
// import com.omas.webapp.Constants;
// import com.omas.webapp.service.ClubService;
// import com.omas.webapp.service.CompetitionService;
// import com.omas.webapp.service.TeamMemberScoreService;
// import com.omas.webapp.service.TeamService;
// import com.omas.webapp.service.UserService;
// import com.omas.webapp.table.Club;
// import com.omas.webapp.table.Competition;
// import com.omas.webapp.table.TeamMemberId;

// @Component
// public class TestDataConfig implements CommandLineRunner {

//     @Autowired
//     UserService userService;

//     @Autowired
//     ClubService clubService;

//     @Autowired
//     TeamMemberScoreService teamMemberScoreService;

//     @Autowired
//     CompetitionService competitionService;

//     @Autowired
//     TeamService teamService;

//     @Override
//     public void run(String... args) throws Exception {

//         final String pistolCompetitionTypeName = Constants.pistolType;
//         final String rifleCompetitionTypeName = Constants.rifleType;

//         List<String> rifleCompetitionList = Arrays.asList(
//                 "kesan_ampujaiset",
//                 "talvi_pistooli",
//                 "lasten_ammunta",
//                 "seniori-ammunta",
//                 "tarkkuuslaukaus-festivaali",
//                 "kivaarikilpailujen-huipennus",
//                 "polaris-ampumaharjoitus",
//                 "aamunkoiton-tahtays",
//                 "nordic-sharpshooters-cup",
//                 "taivaanranta-tulitus",
//                 "lumivyory-ammunta");

//         for (String competition : rifleCompetitionList) {
//             competitionService
//             .addCompetition(new Competition(competition, competition, rifleCompetitionTypeName,
//             System.currentTimeMillis(), System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000));

//         }

//         List<String> pistolCompetitionList = Arrays.asList(
//                 "tarkka-ammunta-cup",
//                 "nopean-laukauksen-mestaruus",
//                 "moniottelu-kilpailu",
//                 "kansallinen-tahtayskilpailu",
//                 "kaupunkiammunta-challenge",
//                 "laukausmaraton",
//                 "vapaa-asekilpailu",
//                 "taitoluodikko-turnaus",
//                 "precision-pistol-cup",
//                 "tulevaisuuden-ampuja",
//                 "pikakivaari-klassikko");

//         for (String competition : pistolCompetitionList) {
//             competitionService
//                     .addCompetition(new Competition(competition, competition, pistolCompetitionTypeName,
//                             System.currentTimeMillis(), System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000));

//         }

//         List<String> clubList = Arrays.asList(
//                 "Poliisi_seura", "Koira_seura",
//                 "Hammaspeikko_seura",
//                 "dog",
//                 "SavuSeura",
//                 "OMAS",
//                 "Pelle_seura",
//                 "young_tallent_-seura",
//                 "aseharrastajien-yhtenaisyys",
//                 "tahtaysmestarit",
//                 "laukausryhma-aurora",
//                 "ampumataito");

//         for (String club : clubList) {
//             clubService.registerClub(new Club(club, club, new Date(Instant.now().toEpochMilli()), getRandomNumber()));
//         }

//         for (String competition : rifleCompetitionList) {
//             for (String club : clubList) {
//                 teamService.addTeam(competition, club);
//                 for (int i = 0; i < 5; i++) {
//                     addTeamMemberWithScoresRifle(club, competition);

//                 }
//             }
//         }

//         for (String competition : pistolCompetitionList) {
//             for (String club : clubList) {
//                 teamService.addTeam(competition, club);
//                 for (int i = 0; i < 5; i++) {
//                     addTeamMemberWithScoresPistol(club, competition);

//                 }
//             }
//         }
//     }

//     private void addTeamMemberWithScoresPistol(String club, String competition) throws Exception {
//         Long userId = getRandomNumber();
//         teamService.addTeamMember(new TeamMemberId(userId, club, competition));
//         teamMemberScoreService.addPistolScore(new TeamMemberId(userId, club, competition), give60shots());

//     }

//     private void addTeamMemberWithScoresRifle(String club, String competition) throws Exception {
//         Long userId = getRandomNumber();
//         teamService.addTeamMember(new TeamMemberId(userId, club, competition));
//         teamMemberScoreService.addRifleScore(new TeamMemberId(userId, club, competition), give60shots());

//     }

//     private Long getRandomNumber() {
//         Random random = new Random();
//         return random.nextLong(1000);
//     }

//     private static List<Double> give60shots() {
//         Random rand = new Random();
//         List<Double> shots = new ArrayList<>();

//         for (int i = 0; i < 60; i++) {
//             double shot = rand.nextDouble() * 10.9;
//             shot = Math.round(shot * 10.0) / 10.0;
//             shots.add(shot);
//         }
//         return shots;

//     }

// }
