package com.omas.webapp.service;

import java.util.List;
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

    // Authorization for this method is handled in CompetitionController
    public Team addTeam(String CompetitionToJoin, String ClubJoining) {

        Team savedTeam = teamRepository.save(new Team(new TeamId(ClubJoining, CompetitionToJoin)));

        return savedTeam;
    }

    public TeamMember addTeamMember(TeamMemberId teamMemberId) throws Exception {

        if (isTeamPartOfThisComp(teamMemberId.getClubId(), teamMemberId.getCompetitionId())) {
            return teamMemberRepository.save(new TeamMember(teamMemberId));
        }
        throw new Exception("this team does not exist");

    }

    public TeamMemberId thisUserIsValidMember(UserInfoDetails userDetails, String competitionName) throws Exception {

        String club = userDetails.getPartOfClub();
        if (club == null || club.isEmpty()) {
            throw new Exception("error: this user is not in club");
        }

        return new TeamMemberId(userDetails.getId(), new TeamId(club, competitionName));
    }

    // checks if user is a teamMember in the given team
    public boolean isUsertPartOfThisTeam(long userId, TeamId teamId) {

        Optional<List<TeamMember>> teamMates = teamMemberRepository.findByTeamId(teamId);
        if (teamMates.isPresent()) {
            List<TeamMember> results = teamMates.get();
            if (results.contains(
                    new TeamMember(new TeamMemberId(userId, teamId.getClubId(), teamId.getCompetitionId())))) {
                return true;
            }
        }
        return false;
    }

    // checks if team with given Id exists in the db
    public boolean isTeamPartOfThisComp(String clubParticipating, String activeCompetition) {

        Optional<Team> participatingTeam = teamRepository.findById(new TeamId(clubParticipating, activeCompetition));

        if (participatingTeam.isPresent()) {
            return true;
        }
        return false;
    }
}
