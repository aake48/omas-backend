package com.omas.webapp.controller;

import com.omas.webapp.entity.requests.ClubRequest;
import com.omas.webapp.entity.requests.SetPasskeyRequest;
import com.omas.webapp.entity.response.MessageResponse;
import com.omas.webapp.service.ClubService;
import com.omas.webapp.service.RoleService;
import com.omas.webapp.service.UserInfoDetails;
import com.omas.webapp.service.UserService;
import com.omas.webapp.table.Club;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

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

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/new")
    public ResponseEntity<?> newClub(@Valid @RequestBody ClubRequest clubRequest) {

        // This section of the code performs two operations on the 'Id', clubName:
        // 1. It removes whitespaces and characters 'ä', 'ö', 'å' from the 'Id'.
        // 2. It stores the original, unaltered version of 'Id' into 'nameNonId'.
        // If 'Id' still contains unsafe characters after these alterations, the code
        // returns a 400 status.
        String clubNameNonId = clubRequest.getClubName();
        String clubName = clubRequest.getClubName()
                .replace('ä', 'a').replace('Ä', 'A')
                .replace('ö', 'o').replace('Ö', 'O')
                .replace('å', 'a').replace('Å', 'A')
                .replace(' ', '_');

        String regex = "^[a-zA-Z0-9-_]+$";

        if (!clubName.matches(regex)) {
            return new MessageResponse("Club name contains characters which are forbidden.", HttpStatus.BAD_REQUEST);
        }

        UserInfoDetails userDetails = UserInfoDetails.getDetails();

        Club createdClub = clubService.registerClub(new Club(clubNameNonId, clubName, userDetails.getId()));

        if (createdClub != null) {
            Long id = UserInfoDetails.getDetails().getId();
            roleService.addRole(id, clubName + "/admin");
            return new ResponseEntity<>(createdClub, HttpStatus.OK);
        }

        return new MessageResponse("Club name has already been taken.", HttpStatus.BAD_REQUEST);
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @PostMapping("/auth/club/join")
    public ResponseEntity<?> joinClub(@Valid @RequestBody ClubRequest club) {

        UserInfoDetails userDetails = UserInfoDetails.getDetails();

        try {
            clubService.checkPasskeyMatch(club.getClubName(), club.getPasskey());
            userService.joinClub(userDetails.getId(), club.getClubName());
            return new ResponseEntity<>(Map.of("message", "Club joined successfully."), HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("club/{name}")
    public ResponseEntity<?> getClub(@PathVariable String name) {
        try {
            return new ResponseEntity<>(clubService.getClub(name), HttpStatus.OK);
        } catch (Exception e) {
            return new MessageResponse("No club found with the given name.", HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("@teamService.isAdminInclub(#request.clubName)")
    @PostMapping("club/setPasskey")
    public ResponseEntity<?> setPasskey(@Valid @RequestBody SetPasskeyRequest request) {

        try {
            clubService.setPassKey(request.getClubName(), request.getPasskey());
            return new ResponseEntity<>(Map.of("message", "passkey updated"), HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of("message", e.getMessage()), HttpStatus.BAD_REQUEST);
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
                return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>(resultPage, HttpStatus.OK);
        }

        Page<Club> resultPage = clubService.firstPaginated(page, size);

        if (page > resultPage.getTotalPages()) {
            return new MessageResponse("Requested page does not exist.", HttpStatus.BAD_REQUEST);
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