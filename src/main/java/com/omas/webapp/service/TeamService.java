package com.omas.webapp.service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.repository.TeamRepository;
import com.omas.webapp.table.Role;
import com.omas.webapp.table.RoleId;
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

    @Autowired RoleService roleService;

    /**
     * Note: this method does not perform any validation to check if the provided competition or club exists.
     * @param competitionId
     * @param teamName
     * @return savedTeam
     */
    public Team addTeam(String competitionId, String teamName, String teamDisplayName, String club) {

        Team team = new Team(new TeamId(competitionId, teamName), teamDisplayName, club);

        return teamRepository.save(team);
    }

    /**
     * Check if a team exists.
     * @param competitionId the id of the competition
     * @param teamName the sanitized team name
     * @return true of the team exists, false if not
     */
    public boolean teamExists(String competitionId, String teamName) {
        return teamRepository.existsById(new TeamId(competitionId, teamName));
    }

    /**
     * Check if the given user can join a team in the given competition
     * by checking if the user is already in a team in the given competition
     * @return true if the user can join a team, false if not
     */
    public boolean isUserParticipatingInThisCompetition(Long userId, String competitionId) {
        return !getUserTeam(userId, competitionId).isEmpty();
    }

    /**
     * validates that the user has privileges to administer teams of this club
     */
    public boolean isAdminInclub(String club) {
        Long id = UserInfoDetails.getDetails().getId();

        Optional<Role> role = roleService.findRole(new RoleId(id, club+"/admin"));
        if (role.isEmpty()) {
            return false;
        }
        return true;

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

    public TeamMember removeTeamMember(TeamMemberId teamMemberId) throws Exception{
        if(thisUserIsTeamMember(teamMemberId)){
            TeamMember member = teamMemberRepository.getReferenceById(teamMemberId);
            teamMemberRepository.deleteById(teamMemberId);
            return member;
        }
        throw new Exception("this team does not exist");
    }

    /** @return TeamMemberId if this user has permissions to submit scores to given competition
     * checks that user is member of the team
     * @throws Exception throws an exception if validation fails
    */
    public TeamMemberId canUserSubmitScores(Long userId, String competitionName, String teamName) throws Exception {

        if (thisUserIsTeamMember(new TeamMemberId(userId, competitionName, teamName))){
            return new TeamMemberId(userId, new TeamId( competitionName, teamName));
        }

        throw new Exception("error: this user is not in the team");
    }

    /**
     * Figure out which {@link TeamMemberId} to use. If the given userId is null, the authenticated user's id will be used.
     * Otherwise, the given userId will be used.
     * This method is used when the authenticated user might be posting a score for another team member
     * @return the resolved {@link TeamMemberId}
     * @throws Exception if the users are not in the same team
     */
    public TeamMemberId resolveTeamMemberId(Long userId, String competitionName, String teamName) throws Exception {

        long authenticatedUserId  = UserInfoDetails.getDetails().getId();

        // validates that user is part of the team and that the team has entered this
        // competition
        TeamMemberId teamMemberId = canUserSubmitScores(authenticatedUserId, competitionName, teamName);

        // validates that userId is part of the team and that the team has entered this
        // competition
        if (userId != null) {
            teamMemberId = canUserSubmitScores(userId, competitionName, teamName);
        }

        return teamMemberId;
    }

    /**
     * Checks if a user is a member of a specific team.
     *
     * @param teamMemberId The ID of the user.
     * @return true if the user is in the team, false otherwise.
     */
    public boolean thisUserIsTeamMember(TeamMemberId teamMemberId) {
        return teamMemberRepository.findById(teamMemberId).isPresent();
    }

    /**
     * Checks if a team is part of a specific competition.
     *
     * @param teamName The club participating in the competition.
     * @param activeCompetition The active competition.
     * @return true if the team is part of the competition, false otherwise.
     */
    public boolean isTeamPartOfCompetition(String activeCompetition, String teamName) {
        return teamRepository.findById(new TeamId(activeCompetition, teamName)).isPresent();
    }

    /**
     * Retrieves a list of teams that are participating in the given competition.
     *
     * @param competition The name of the competition.
     * @return List of teams participating in the competition.
     */
    public List<Team> getTeamsParticipatingInCompetition(String competition) {
        
        return teamRepository.findByCompetitionIdIgnoreCase(competition);
    }

    /**
     * Find team by user id and competition id
     * @param userId the user's id
     * @param competitionId the competition's id
     * @return optional containing the user's team or empty optional
     */
    public Optional<Team> getUserTeam(Long userId, String competitionId) {
        TeamMember teamMember = teamMemberRepository.findByUserIdAndCompetitionIdIgnoreCase(userId, competitionId);
        if(teamMember==null){
            return Optional.empty();
        }
        return teamRepository.findById(teamMember.getTeamId());
    }

    /**
     * Get all the user's team from all competitions which are still ongoing
     * @param userId the user's id
     * @return all the teams the user is in
     */
    public List<Team> getUserTeams(Long userId) {

        List<TeamMember> teamMembers = teamMemberRepository.findThisUsersTeamMembershipsForActiveCompetitions(userId, new java.sql.Date(System.currentTimeMillis()));
        List<TeamId> teamIds = new ArrayList<>(teamMembers.size());

        for (TeamMember teamMember : teamMembers) {
            teamIds.add(teamMember.getTeamId());
        }

        return teamRepository.findAllById(teamIds);
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

    public Page<Team> findWithPaginatedsearchByClub(int page, int size, String search) {
        return teamRepository.findByClubNameContainingIgnoreCase(search, PageRequest.of(page, size));
    }

    public Page<Team> findWithPaginatedSearchByCompetitionId(int page, int size, String search) {
        return teamRepository.findByCompetitionIdContainingIgnoreCase(search, PageRequest.of(page, size));
    }

    public Page<Team> findThisClubsTeamsWhichAreInActiveCompetitions(int page, int size, String club) {
        return teamRepository.findThisClubsTeamsWhichAreCompetitionsThatHaveNotEnded(PageRequest.of(page, size), club, new java.sql.Date(System.currentTimeMillis()));
    }

    public boolean isThisTeamFull(String competitionName, String teamName) {

        List<TeamMember> team = teamMemberRepository.findByTeamId(new TeamId(competitionName, teamName));

        return team.size() >= 5;
    }
}
