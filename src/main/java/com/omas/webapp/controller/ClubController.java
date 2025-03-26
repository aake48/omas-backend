package com.omas.webapp.controller;

import com.omas.webapp.entity.requests.ClubRequest;
import com.omas.webapp.entity.requests.SetPasskeyRequest;
import com.omas.webapp.service.*;
import com.omas.webapp.table.Club;
import com.omas.webapp.table.Team;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMemberId;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import com.omas.webapp.Constants;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private TeamService teamService;

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/new")
    public ResponseEntity<?> newClub(@Valid @RequestBody ClubRequest request) {

        String clubName = request.getClubName();
        String passKey = !request.getPassKey().trim().equals("") ? request.getPassKey().trim() : null;
        String clubId = Constants.createIdString(clubName);

        if (clubId == null) {
            return new ResponseEntity<>(Map.of("message","Club name contains characters which are forbidden."), HttpStatus.BAD_REQUEST);
        }

        UserInfoDetails userDetails = UserInfoDetails.getDetails();

        Club createdClub = clubService.registerClub(new Club(clubName, clubId, userDetails.getId(), passKey));

        if (createdClub == null) {
            return new ResponseEntity<>(Map.of("message","Club name has already been taken."), HttpStatus.BAD_REQUEST);
        }

        Long id = UserInfoDetails.getDetails().getId();
        roleService.addRole(id, clubName + "/admin");

        return new ResponseEntity<>(createdClub, HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/join")
    public ResponseEntity<?> joinClub(@Valid @RequestBody ClubRequest club) {

        UserInfoDetails userDetails = UserInfoDetails.getDetails();
        String clubId = Constants.createIdString(club.getClubName());

        if (clubId == null) {
            return new ResponseEntity<>(Map.of("message", "Club name contains characters which are forbidden."), HttpStatus.BAD_REQUEST);
        }

        // Check if the user is already a member of any club
        if (userService.isUserInAnyClub(userDetails.getId())) {
            return new ResponseEntity<>(Map.of("message", "User is already a member of a club."), HttpStatus.BAD_REQUEST);
        }

        try {
            clubService.checkPasskeyMatch(clubId, club.getPassKey());

            // Attempt to join the club
            boolean joined = userService.joinClub(userDetails.getId(), clubId);
            if (!joined) {
                return new ResponseEntity<>(Map.of("message", "User is already a member of a club."), HttpStatus.BAD_REQUEST);
            }

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(Map.of("message", "Club joined successfully."), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/leave")
    public ResponseEntity<?> leaveClub() {
        UserInfoDetails userDetails = UserInfoDetails.getDetails();
        Long userId = userDetails.getId();

        try {
            // Check if the user is in a club
            String currentClub = userService.getUserClub(userDetails.getId());
            if (currentClub == null) {
                return new ResponseEntity<>(Map.of("message", "User is not in any club."), HttpStatus.BAD_REQUEST);
            }

            // Remove user from teams
            int teamsLeft = removeUserFromAllTeamsInClub(userId, currentClub);

            // Remove user from the club
            boolean leftClub = userService.leaveClub(userDetails.getId());
            if (!leftClub) {
                return new ResponseEntity<>(Map.of("message", "Failed to leave the club."), HttpStatus.INTERNAL_SERVER_ERROR);
            }

            return new ResponseEntity<>(Map.of("message", "Successfully left the club and " + teamsLeft + " team(s)."), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private int removeUserFromAllTeamsInClub(Long userId, String currentClub) {
        List<Team> userTeams = teamService.getUserTeams(userId);
        if (userTeams.isEmpty()) {
            return 0;
        }

        int removed = 0;

        for (Team team : userTeams) {
            if (team.getClubName().equalsIgnoreCase(currentClub)) {
                TeamId teamId = team.getTeamId();
                try {
                    teamService.removeTeamMember(new TeamMemberId(userId, teamId.getCompetitionId(), teamId.getTeamName()));
                    removed++;
                } catch (Exception e) {
                    System.err.println("Failed to remove user " + userId + " from team " + teamId + ": " + e.getMessage());
                }
            }
        }

        return removed;
    }

    @GetMapping("club/{name}")
    public ResponseEntity<?> getClub(@PathVariable String name) {
        try {
            return new ResponseEntity<>(clubService.getClub(name), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message","No club found with the given name."), HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("@teamService.isAdminInclub(#request.clubName)")
    @PostMapping("club/setPasskey")
    public ResponseEntity<?> setPasskey(@Valid @RequestBody SetPasskeyRequest request) {

        try {
            clubService.setPassKey(request.getClubName(), request.getPasskey());

            return new ResponseEntity<>(Map.of("message","passkey updated"), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message",e.getMessage()), HttpStatus.BAD_REQUEST);
        }

    }

    @GetMapping("club/all")
    public ResponseEntity<List<Club>> getAll() {
        return new ResponseEntity<>(clubService.getAll(), HttpStatus.OK);
    }

    @GetMapping(params = { "page", "size", "search" }, value = "club/query")
    public ResponseEntity<?> queryClubs(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        if (search != null && !search.isBlank()) {
            Page<Club> resultPage = clubService.findWithPaginatedSearch(page, size, search);

            if (page > resultPage.getTotalPages()) {
                return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        Page<Club> resultPage = clubService.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new ResponseEntity<>(Map.of("message","Requested page does not exist."), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return errors;
    }
}