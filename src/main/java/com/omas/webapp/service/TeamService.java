package com.omas.webapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.repository.TeamRepository;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;

public class TeamService {

    @Autowired
    private TeamRepository teamRepository;

    @Autowired
    private TeamMemberRepository teamMemberRepository;

    // Authorization for this method is handled in CompetitionController
    public Team addTeam(String CompetitionToJoin, String ClubJoining) {

        Team savedTeam = teamRepository.save(new Team(new TeamId(CompetitionToJoin, ClubJoining)));

        return savedTeam;
    }

    public TeamMember addTeamMember(TeamMemberId teamMemberId) throws Exception{

        
        if(isTeamPartOfThisComp(teamMemberId.getClubId() ,teamMemberId.getCompetitionId())){
            return teamMemberRepository.save(new TeamMember(teamMemberId));
        }
        throw new Exception("this team does not exist");

    }

    public TeamMemberId thisUserIsValidMember(UserInfoDetails userDetails, String competitionName) throws Exception {

        String club = userDetails.getPartOfClub();
        if (club == null || club.isEmpty()) {
            throw new Exception("error: this user is not in club");
        }

        if (!isTeamPartOfThisComp(club, competitionName)) {
            throw new Exception("error: this user's club is not participating in this event / Team does not exist");
        }

        if (!isPartOfThisTeam(userDetails.getId(), new TeamId(userDetails.getPartOfClub(), competitionName))) {
            throw new Exception("error: this user is is not part of the team");
        }

        return new TeamMemberId(userDetails.getId(), new TeamId(club, competitionName));
    }

    // not implemented yet
    public boolean isPartOfThisTeam(long userId, TeamId teamId) {
        return false;
    }

    // not implemented yet
    public boolean isTeamPartOfThisComp(String clubParticipating, String activeCompetition) {

        return false;
    }
}
