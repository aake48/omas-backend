package com.omas.webapp.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.omas.webapp.Constants;
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

    /**
     * Delete the given team member's score entry
     * @param teamMemberId the id of the team member
     * @return true if the scores were deleted, false if not
     */
    public boolean removeScore(TeamMemberId teamMemberId) {

        if (teamMemberScoreRepository.existsById(teamMemberId)) {
            teamMemberScoreRepository.deleteById(teamMemberId);
            return true;
        }

        return false;
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
     * Adds the scores and bullseyes directly
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore setSum(TeamMemberId teamMemberId, int bullsEyeCount, double score) {
        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, score, bullsEyeCount));
    }

    /**
     * Updates the scores and bullseyes directly
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore addSum(TeamMemberId teamMemberId, int bullsEyeCount, double score) {

        Optional<TeamMemberScore> optional = teamMemberScoreRepository.findById(teamMemberId);

        // If there is no score, just set it
        if (optional.isEmpty()) {
            return setSum(teamMemberId, bullsEyeCount, score);
        }

        TeamMemberScore teamMemberScore = optional.get();

        int newBullsEyeCount = teamMemberScore.getBullsEyeCount() + bullsEyeCount;
        double newScore = teamMemberScore.getSum() + score;

        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, newScore, newBullsEyeCount));
    }

    /**
     * Modify the score sum based on the provided add method
     * <br>{@link Constants#ADD_METHOD_SET} will set the score overwriting any score already present in the database
     * <br>{@link Constants#ADD_METHOD_UPDATE} will attempt to add to the existing score or set it if it does not exist yet
     * @return the modified or set {@link TeamMemberScore}
     */
    public TeamMemberScore modifyScoreSum(TeamMemberId teamMemberId, int bullsEyeCount, double score, String addMethod) {

        switch (addMethod) {
            case Constants.ADD_METHOD_SET -> {
                return setSum(teamMemberId, bullsEyeCount, score);
            }
            case Constants.ADD_METHOD_UPDATE -> {
                return addSum(teamMemberId, bullsEyeCount, score);
            }
            default -> {
                throw new IllegalArgumentException("Invalid add method");
            }
        }

    }

}
