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
import com.omas.webapp.Constants;
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
                "lumivyory-ammunta",
                "rautalanka-revolveri-kisa",
                "jarvenpaan-jyryn-taisto",
                "tahallinen-tahtays-turnaus",
                "vuoristovaellus-kivaarihaaste",
                "kilpakivaari-komeetta",
                "aurinkoisen-ampujan-kilpailu",
                "satakunnan-salamakisa",
                "koillisen-kivaarihehku",
                "kuutamo-kranaatti-kilpailu",
                "rinteen-reunalla-ammunta",
                "peruskallio-potkinto",
                "jousiammunta-jayna",
                "suurpamaus-pistoolikilpailu",
                "tuulen-viehatys-kivaari",
                "hamaran-huippu-ampumapaiva",
                "liikkuvan-maalin-mittely",
                "aamuaurinko-ammunta",
                "lasersade-laukaukset",
                "tuomiontuomari-ammunta",
                "revontuli-ratamelonta",
                "hauen-hatistys-kivaari",
                "sirppi-ja-vasara-ammunta",
                "sateenkaarikuula-kilpailu",
                "talvivaellus-tahtays",
                "uudenkuun-kaiku-kilpailu",
                "kestavan-ampujan-koulu",
                "keskiyon-kaiku-kivaari",
                "ajaton-ampumaurakka",
                "purppuran-pamaus-panos",
                "muinaismestarin-malja",
                "hopeaharjoitus-kilpailu",
                "vuorijonon-vaellus-kivaari",
                "kiertue-kauden-kilpailu",
                "huipulle-hetkessa-ammunta",
                "virtuaali-vaellusvartio",
                "susi-ampujien-seikkailu",
                "korven-kutoja-kivaari",
                "vaaran-varma-ampumaleiri",
                "havupuun-hymina-ammunta",
                "uudenvuoden-uusiutuminen",
                "virtaviivainen-valmistelu",
                "lumen-liekki-laukaukset",
                "routareunu-ramppi-ammunta",
                "kehon-ja-kiikarin-kilpailu",
                "tuulenvire-tahtays",
                "pohjolan-pamaus-paivat",
                "puolenyon-pikaluodikko",
                "suunnanvaihto-ampumakilpailu",
                "piilossa-panos-paiva",
                "varjovalo-ampujien-turnaus",
                "virtuaali-vaistoliike-ammunta",
                "auringonnousu-ammunta",
                "korpin-kurkistus-kilpailu",
                "ilmakuula-ilottelu",
                "vuorijonon-valmistelu",
                "tornihaukka-tahtays",
                "punainen-panos-potkinto",
                "poltteen-pamaus-panos",
                "kesakuun-kahakka-kivaari",
                "rantaleijona-laukaus",
                "kirkas-kiikari-kilpailu",
                "vihrea-valmistelu-ammunta",
                "kiertorata-kauneus-kivaari",
                "aamu-usvan-ampuminen",
                "laukauksen-loppuhuipennus",
                "huurteinen-haaste-ammunta",
                "pohjoisen-pioneerin-potkinto",
                "aikamatka-ampujien-leiri",
                "kuula-kimaltelee-kilpailu",
                "tahtitaivaan-tarkkuus",
                "raskyvan-rantakallion-ammunta",
                "laskevan-aurinkokiven-kilpailu",
                "rakkauden-raiskinta-ampunta",
                "yon-ymparoinva-ampumakisa",
                "talvitarmon-tahtays",
                "jaansarkijan-kivaari-kier",
                "liikkuva-lumiukko-ammunta",
                "lounaisen-laukausleiri",
                "harmonisen-huumaava-haaste",
                "rauhallinen-ravintolaukaus",
                "tahtienvaliset-tahtaykset",
                "valon-viittaama-ampuma",
                "revontuli-rynnistys-ampunta",
                "monimuotoinen-metsastyspaiva",
                "luonnonvalon-laukaus",
                "virtuaali-valppauden-vartio",
                "kiikarin-kehitys-ammunta",
                "revolverin-rallatus-ampunta");

        for (String competition : rifleCompetitionList) {
            competitionService
                    .addCompetition(new Competition(competition, competition, rifleCompetitionTypeName));

        }

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
                "pikakivaari-klassikko",
                "maailman-turvallisin-laukaus",
                "hyppy-laukauksen-turnaus",
                "salainen-mestaruuskilpailu",
                "jousiammunta-kahakka",
                "virtuaalinen-ammunta-haaste",
                "historialliset-aseet-turnaus",
                "laukauksen-mestaruuskilpailu",
                "kivaari-koitos",
                "rautaluoti-ralli",
                "sahkoinen-laukaus-leiri",
                "kultaiset-pistoolit-kilpailu",
                "vahva-vasen-kivaari-cup",
                "valomerkki-laukaukset",
                "tactical-turbo-tahtayskilpailu",
                "haamulaukaukset-turnaus",
                "kaksoislaukaus-haaste",
                "pyha-ammuttu-kilpailu",
                "hopea-ampujien-turnaus",
                "maastomestari-ammunta",
                "aari-asteinen-aseiden-messut",
                "monikaliiberinen-mittelo",
                "rautakoura-ammunta-cup",
                "ampujan-seitsikko",
                "kiitolaukaus-karkelo",
                "ennakoidut-laukaukset-kisa",
                "laserkiikari-laukaus-liiga",
                "kultainen-kivaari-champion",
                "sotilaskivaari-supermestaruus",
                "tasma-laukauksen-taisto",
                "kyber-aika-ammunta",
                "suurkaliiberi-shootout",
                "laukausten-yomaraton",
                "tarkkuuspiippujen-turnaus",
                "rohkea-revolveri-ralli",
                "panssarilaukaus-potkintaa",
                "harjoitellut-haulikko-kilpailu",
                "nuolihallinnan-mestaruus",
                "korkea-kiikari-kilpailu",
                "kaksin-kasin-kivaari-mittelo",
                "olympialaisten-kaariammunta",
                "sektorin-ampujat-cup",
                "pohjoinen-panos-peli",
                "aari-asteinen-ase-akatemia",
                "yollinen-ydinkivaari-kilpailu",
                "taistelun-tahtayskilpailu",
                "kestava-ampujan-turnaus",
                "laukausten-luovuus-leiri",
                "ajastetut-aseet-kilpailu",
                "tuhannen-taplan-tahtays",
                "vauhdikas-valinta-vaanto",
                "pudotuspeli-pistooli-cup",
                "lukolliset-laukaukset",
                "painopisteen-pistoolihaaste",
                "pohjoinen-porras-ammunta",
                "salamakivaari-turnaus",
                "kivaari-kierros",
                "mestariluokan-ammunta",
                "raketti-ampujat-cup",
                "aikamatka-aseiden-aarella",
                "korkea-kulma-kivaari-cup",
                "voittajien-valinta-ammunta",
                "rynnakkopistooli-raivo",
                "piilotettujen-aseiden-taistelu",
                "laskeva-ja-laukaus",
                "luodit-lentoon-kilpailu",
                "aallonmurtaja-ammunta",
                "ilmapallolaukaus-leiri",
                "satelliitti-ampujat",
                "laukausten-luontopolku",
                "polaari-ampumakilpailu",
                "varahdelyvapaa-ammunta",
                "aavekivaari-turnaus",
                "kohiseva-kaasuhaulikko",
                "rautalanka-reika",
                "pistoolipaja",
                "turvallinen-tahtaystunnelma",
                "valahdysluoti-leiri",
                "maalattu-maali-kivaari",
                "tulostaulu-ammunta",
                "piilotetut-aseet-cup",
                "laukauksen-loisto",
                "varovainen-vahti-voima",
                "valon-valahdys-tahtays",
                "kuparinen-kivaari-cup",
                "kettera-ampujan-kierto",
                "hehkulangalla-laukaus",
                "kilpailulataus-kivaari",
                "vapaalaukaus-voitto",
                "tuulahdus-taktista-ampumista",
                "toiminnallinen-turvallisuus-ammunta",
                "vartijan-vahti-voima",
                "hopeinen-haulikko",
                "piilotettu-pistooli-panos",
                "tahti-ammunnan-turnaus",
                "nostalgialaukaus",
                "tulevaisuuden-tahtayskilpailu",
                "sisapiirin-ammunnat",
                "voittajien-valmistelu",
                "rajahdysva-va-voi",
                "salamalaukaus-surma",
                "konepistooli-kaksintaistelu",
                "virtuaalinen-valmistelu-ammunta",
                "ammunnan-asiantuntijat",
                "navigointi-nallit");

        for (String competition : pistolCompetitionList) {
            competitionService
                    .addCompetition(new Competition(competition, competition, pistolCompetitionTypeName));

        }

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
                "ampumataito",
                "aseveljeyden-kilta",
                "rata-asettajat",
                "ampujain-keskus",
                "pistooliklubi-pohjoinen",
                "suur-laukaajat",
                "kivaarikulma",
                "turvalliset-laukaukset",
                "selevat-osuukset",
                "metsastajien-tahtaysseura",
                "kiekon-tarkka",
                "etelan-kivaarimestarit",
                "jousi-ja-nuoli-ampujat",
                "keraamiset-ampujat",
                "metsastavat-tahdet",
                "laukaustaituriyhdistys",
                "kilpa-aseklubi");

        for (String club : clubList) {
            clubService.registerClub(new Club(club, club, new Date(Instant.now().toEpochMilli()), getRandomNumber()));
        }

        for (String competition : rifleCompetitionList) {
            for (String club : clubList) {
                teamService.addTeam(competition, club);
                for (int i = 0; i < 5; i++) {
                    addTeamMemberWithScoresRifle(club, competition);

                }
            }
        }

        for (String competition : pistolCompetitionList) {
            for (String club : clubList) {
                teamService.addTeam(competition, club);
                for (int i = 0; i < 5; i++) {
                    addTeamMemberWithScoresPistol(club, competition);

                }
            }
        }
    }

    private void addTeamMemberWithScoresPistol(String club, String competition) throws Exception {
        Long userId = getRandomNumber();
        teamService.addTeamMember(new TeamMemberId(userId, club, competition));
        teamMemberScoreService.addPistolScore(new TeamMemberId(userId, club, competition), give60shots());

    }

    private void addTeamMemberWithScoresRifle(String club, String competition) throws Exception {
        Long userId = getRandomNumber();
        teamService.addTeamMember(new TeamMemberId(userId, club, competition));
        teamMemberScoreService.addRifleScore(new TeamMemberId(userId, club, competition), give60shots());

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
