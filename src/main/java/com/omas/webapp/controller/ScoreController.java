package com.omas.webapp.controller;

import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.entity.data.Message;
import com.omas.webapp.service.ScoreService;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api")
public class ScoreController {

    @Autowired
    ScoreService service;

    @DeleteMapping("/score")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void deleteScore(@RequestBody UUID uuid) {
        service.deleteScore(uuid);
    }

    //@PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/score")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void addScores(@RequestBody TeamScorePayload request) {
        service.addScoresFromPayload(request);
    }

    @GetMapping("/score")
    public ResponseEntity<?> getScores(@RequestBody TeamId teamId) {

        List<TeamScore> scores = service.getTeamScores(teamId);

        // Notify client if there are no scores for this team id
        if (scores.isEmpty()) {
            return new ResponseEntity<>(new Message("Invalid team ID or no scores"), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(scores, HttpStatus.OK);
    }

    @GetMapping("/score/all")
    @ResponseStatus(HttpStatus.OK)
    public List<TeamScore> getAllScores() {
        return service.getAllScores();
    }

}
