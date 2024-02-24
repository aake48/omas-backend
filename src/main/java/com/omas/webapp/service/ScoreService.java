package com.omas.webapp.service;

import com.omas.webapp.entity.data.Message;
import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.repository.*;
import com.omas.webapp.table.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ScoreService {

    @Autowired
    private ScoreRepository repository;

    @Autowired
    private TeamMemberRepository teamMemberRepository;

    public ResponseEntity<?> addScoresFromPayload(TeamScorePayload request) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        TeamId teamId = request.getTeamId();
        Long userId = userDetails.getId();

        TeamMemberId teamMemberId = new TeamMemberId(userId, teamId);

        Optional<TeamMember> member = teamMemberRepository.findById(teamMemberId);

        // Score validation, the user must be part of a team to post scores
        // This check should cover the checks for the existence of the team and club as
        // it is impossible for a team member to exist without the two
        if (member.isPresent()) {
            return new ResponseEntity<>(new Message("No team found for user with ID " + userId), HttpStatus.BAD_REQUEST);
        }

        TeamMemberScore score = repository.save(new TeamMemberScore(teamMemberId, request.getScoreList()));

        return new ResponseEntity<>(score, HttpStatus.CREATED);
    }

    public List<TeamMemberScore> getAllScores() {
        return repository.findAll();
    }

    public List<TeamMemberScore> getTeamScores(TeamId teamId) {
        return repository.findByTeamId(teamId);
    }

}
