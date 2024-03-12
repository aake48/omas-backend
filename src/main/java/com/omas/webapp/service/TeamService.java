package com.omas.webapp.service;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.repository.TeamRepository;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;
@Service
public class TeamService {
    
    @Autowired
    private TeamRepository teamRepository;

    @Autowired
    private TeamMemberRepository teamMemberRepository;

    /**
     * Note: this method does not perform any validation to check if the provided competition or club exists.
     * @param competitionId
     * @param teamName
     * @return savedTeam
     */
    public Team addTeam(String competitionId, String teamName, String teamDisplayName) {

        Team team = new Team(new TeamId(competitionId, teamName), teamDisplayName);

        return teamRepository.save(team);
    }

    /**
     * This method checks if the provided teamId is part of competition and saves the team member.
     * @param teamMemberId
     * @return saved team member
     * @throws Exception throws an exception if team member cannot be saved because the team is not part of the competition
     */
    public TeamMember addTeamMember(TeamMemberId teamMemberId) throws Exception {

        if (isTeamPartOfCompetition(teamMemberId.getCompetitionId(), teamMemberId.getTeamName())) {
            return teamMemberRepository.save(new TeamMember(teamMemberId));
        }
        throw new Exception("this team does not exist");

    }

    /** @return TeamMemberId if this user has permissions to submit scores to given competition
     * checks whether user is in club. 
     * checks that user is in his clubs team for this competition
     * @throws Exception throws an exception if validation fails
    */
    public TeamMemberId CanUserSubmitScores(UserInfoDetails userDetails, String competitionName, String teamName) throws Exception {

        if (!isUserPartOfTeam(userDetails.getId(), new TeamId(competitionName, teamName))){
            throw new Exception("error: this user is not in the team");
        }

        return new TeamMemberId(userDetails.getId(), new TeamId( competitionName, teamName));
    }

    /**
     * Checks if a user is a member of a specific team.
     *
     * @param userId The ID of the user.
     * @param teamId The ID of the team.
     * @return true if the user is in the team, false otherwise.
     */
    public boolean isUserPartOfTeam(long userId, TeamId teamId) {

        Optional<List<TeamMember>> teamMates = teamMemberRepository.findByTeamId(teamId);
        if (teamMates.isPresent()) {
            List<TeamMember> results = teamMates.get();
            if (results.contains(
                new TeamMember( teamId.getCompetitionId(), userId, teamId.getTeamName()))){
                return true;
            }
        }
        return false;
    }

    /**
     * Checks if a team is part of a specific competition.
     *
     * @param teamName The club participating in the competition.
     * @param activeCompetition The active competition.
     * @return true if the team is part of the competition, false otherwise.
     */
    public boolean isTeamPartOfCompetition(String activeCompetition, String teamName) {

        Optional<Team> participatingTeam = teamRepository.findById(new TeamId(activeCompetition, teamName));

        if (participatingTeam.isPresent()) {
            return true;
        }
        return false;
    }

    /**
     * Retrieves a list of teams that are participating in the given competition.
     *
     * @param competition The name of the competition.
     * @return List of teams participating in the competition.
     */
    public List<Team> getTeamsParticipatingInCompetition(String competition) {
        
        return teamRepository.findByCompetitionId(competition);
    }


    public Optional<Team> getTeam(TeamId teamId)  {
        return teamRepository.findById(teamId);
    }

    /**
     * Retrieves the team with the specified club and competition.
     * @param teamName the club of the team
     * @param competitionId the ID of the team's competition
     * @return the team with the specified club and competition
     */
    public Optional<Team> getTeam(String competitionId, String teamName)  {
        return getTeam(new TeamId(competitionId, teamName));
    }
}
