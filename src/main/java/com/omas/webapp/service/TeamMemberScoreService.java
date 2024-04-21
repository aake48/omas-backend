package com.omas.webapp.service;

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
        return teamMemberScoreRepository.findByUserIdAndCompetitionIdIgnoreCase(id, competitionName);
    }

    /**
     * Adds the scores and bullseyes directly
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore setSum(TeamMemberId teamMemberId, int bullsEyeCount, double score, int round) throws IllegalArgumentException {

        if (score > Constants.MAX_SCORE) {
            throw new IllegalArgumentException("Score exceeds maximum score");
        }

        if (bullsEyeCount > Constants.MAX_BULLS_EYES) {
            throw new IllegalArgumentException("Bulls eye count exceeds maximum bulls eye count");
        }

        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, score, bullsEyeCount, round));
    }

    /**
     * Updates the scores and bullseyes directly
     * @return the saved {@link TeamMemberScore}
     */
    public TeamMemberScore addSum(TeamMemberId teamMemberId, int bullsEyeCount, double score) throws IllegalArgumentException {

        Optional<TeamMemberScore> optional = teamMemberScoreRepository.findById(teamMemberId);

        // If there is no score, just set it
        if (optional.isEmpty()) {
            return setSum(teamMemberId, bullsEyeCount, score, 1);
        }

        TeamMemberScore teamMemberScore = optional.get();

        int newBullsEyeCount = teamMemberScore.getBullsEyeCount() + bullsEyeCount;
        double newScore = teamMemberScore.getSum() + score;
        int newRound = teamMemberScore.getRound() + 1;

        if (newRound > Constants.MAX_ROUND) {
            throw new IllegalArgumentException("Maximum rounds reached");
        }

        if (newScore > Constants.MAX_SCORE) {
            throw new IllegalArgumentException("New score exceeds maximum score");
        }

        if (newBullsEyeCount > Constants.MAX_BULLS_EYES) {
            throw new IllegalArgumentException("New bulls eye count exceeds maximum bulls eye count");
        }

        return teamMemberScoreRepository.save(new TeamMemberScore(teamMemberId, newScore, newBullsEyeCount, newRound));
    }

    /**
     * Modify the score sum based on the provided add method
     * <br>{@link Constants#ADD_METHOD_SET} will set the score overwriting any score already present in the database
     * <br>{@link Constants#ADD_METHOD_UPDATE} will attempt to add to the existing score or set it if it does not exist yet
     * @return the modified or set {@link TeamMemberScore}
     */
    public TeamMemberScore modifyScoreSum(TeamMemberId teamMemberId, int bullsEyeCount, double score, String addMethod) throws IllegalArgumentException {

        switch (addMethod) {
            case Constants.ADD_METHOD_SET -> {
                return setSum(teamMemberId, bullsEyeCount, score, Constants.MAX_ROUND);
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
