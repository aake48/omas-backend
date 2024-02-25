package com.omas.webapp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.omas.webapp.entity.data.Message;
import com.omas.webapp.service.ScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;

@RestController
@RequestMapping("/api/competition/team")
public class TeamController {

    @Autowired
    TeamService teamService;

    @Autowired
    ScoreService scoreService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/new")
    public ResponseEntity<?> addTeam(@RequestBody TeamId teamId) {
        return teamService.createTeam(teamId);
    }

    // //not implemented yet
    // @GetMapping(params = { "clubid", "competitionId" }, value = "/score")
    // public ResponseEntity<?> getScore(@RequestParam("teamId") String teamId,
    // @RequestParam("competitionId") String competitionId) {
    // return null; //service.getTeamScore(teamId, competitionId)

    // }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@RequestBody TeamId teamId) {

        List<TeamMemberScore> scores = scoreService.getTeamScores(teamId);

        // Notify client if there are no scores for this team id
        if (scores.isEmpty()) {
            return new ResponseEntity<>(new Message("Invalid team ID or no scores"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(scores, HttpStatus.OK);
    }

}
