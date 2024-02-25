package com.omas.webapp.controller;

import com.omas.webapp.entity.data.Message;
import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.service.ScoreService;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ScoreController {

    @Autowired
    ScoreService service;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/score")
    public ResponseEntity<?> addScores(@RequestBody TeamScorePayload request) {

        TeamMemberScore score = service.addScoresFromPayload(request);

        if (score == null) {
            return new ResponseEntity<>(new Message("Team membership not found"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(score, HttpStatus.CREATED);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@RequestBody TeamId teamId) {

        List<TeamMemberScore> scores = service.getTeamScores(teamId);

        // Notify client if there are no scores for this team id
        if (scores.isEmpty()) {
            return new ResponseEntity<>(new Message("Invalid team ID or no scores"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(scores, HttpStatus.OK);
    }

    @GetMapping("/score/all")
    @ResponseStatus(HttpStatus.OK)
    public List<TeamMemberScore> getAllScores() {
        return service.getAllScores();
    }

}
