package com.omas.webapp.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.omas.webapp.repository.TeamMemberScoreRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import com.omas.webapp.table.TeamMemberScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TeamMemberScoreService {

    @Autowired
    private TeamMemberScoreRepository teamMemberScoreRepository;

    /**
     * Set the team member's scores. This will replace any old scores.
     * @param teamMemberId the {@link TeamMemberId} for whom these scores are being set.
     * @param scores the new scores
     * @param competitionType the competition type
     * @return the saved {@link TeamMemberScore}
     * @throws JsonProcessingException if converting the score list into a string fails for some reason
     */
    public TeamMemberScore setScore(TeamMemberId teamMemberId, List<Double> scores, String competitionType) throws JsonProcessingException {
        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, scores, competitionType));
    }

    /**
     * Add a score with the provided competition type
     * @param teamMemberId the {@link TeamMemberId} of the team member for whom these scores are being added
     * @param newScores the new scores
     * @param competitionType the competition type
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore addScore(TeamMemberId teamMemberId, List<Double> newScores, String competitionType) throws JsonProcessingException {

        Optional<TeamMemberScore> oldScore = teamMemberScoreRepository.findById(teamMemberId);

        // If there are no scores, just set them
        if (oldScore.isEmpty()) {
            return setScore(teamMemberId, newScores, competitionType);
        }

        // If there are scores the scorePerShot variable needs to be updated
        TeamMemberScore score = oldScore.get();

        score.appendScores(newScores, competitionType);

        return teamMemberScoreRepository.save(score);
    }

    public List<TeamMemberScore> getAllScores() {
        return teamMemberScoreRepository.findAll();
    }

    public List<TeamMemberScore> getTeamScores(TeamId teamId) {
        return teamMemberScoreRepository.findByTeamId(teamId);
    }

    public TeamMemberScore getUsersScore(long id, String competitionName) {
        return teamMemberScoreRepository.findByUserIdAndCompetitionId(id, competitionName);
    }

    /**
     * Add the scores and bullseyes directly without doing any calculations
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore addSum(TeamMemberId teamMemberId, int bullsEyeCount, double score) {
        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, score, bullsEyeCount));
    }

}
