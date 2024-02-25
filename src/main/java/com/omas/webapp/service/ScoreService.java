package com.omas.webapp.service;

import com.omas.webapp.entity.data.TeamScorePayload;
import com.omas.webapp.repository.ScoreRepository;
import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
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

    public TeamMemberScore addScoresFromPayload(TeamScorePayload request) {

        UserInfoDetails userDetails = (UserInfoDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        TeamId teamId = request.getTeamId();
        Long userId = userDetails.getId();

        TeamMemberId teamMemberId = new TeamMemberId(userId, teamId);

        Optional<TeamMember> member = teamMemberRepository.findById(teamMemberId);

        // Score validation, the user must be part of a team to post scores
        // This check should cover the checks for the existence of the team and club as
        // it is impossible for a team member to exist without the two
        if (member.isPresent()) {
            return null;
        }

        return repository.save(new TeamMemberScore(teamMemberId, request.getScoreList()));
    }

    public List<TeamMemberScore> getAllScores() {
        return repository.findAll();
    }

    public List<TeamMemberScore> getTeamScores(TeamId teamId) {
        return repository.findByTeamId(teamId);
    }

}
