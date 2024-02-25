package com.omas.webapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.omas.webapp.entity.data.Message;
import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.service.ScoreService;
import com.omas.webapp.service.TeamService;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;

import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api/competition/team/member")
public class TeamMemberController {

    @Autowired
    TeamService teamsSrvice;

    @Autowired
    ScoreService ScoreService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("competition/team/member/add")
    public ResponseEntity<?> addTeamMember(@RequestBody TeamMemberId teamMemberId) {
        return teamsSrvice.addTeamMember(teamMemberId);
    }

    // not implemented
    @GetMapping("/score")
    public ResponseEntity<?> getScore(@RequestBody TeamMemberId teamMemberId) {
        // return ScoreService.getTeamMemberScore(teamMemberId);
        return null;
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping
    public ResponseEntity<?> addScores(@RequestBody TeamScorePayload request) {

        TeamMemberScore score = ScoreService.addScoresFromPayload(request);

        if (score == null) {
            return new ResponseEntity<>(new Message("Team membership not found"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(score, HttpStatus.CREATED);
    }

}
