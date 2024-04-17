package com.omas.webapp.service;

import com.omas.webapp.repository.ClubRepository;
import com.omas.webapp.table.Club;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
public class ClubService {

    @Autowired
    private ClubRepository repository;

    public Club registerClub(Club club) {

        if (repository.findById(club.getName()).isPresent()) {
            return null;
        }
        return repository.save(club);

    }

    public Optional<Club> getClub(String name) {
        return repository.findById(name);
    }

    public List<Club> getAll() {
        return repository.findAll();
    }

    public Page<Club> findWithPaginatedSearch(int page, int size, String search) {
        return repository.findByNameContainingIgnoreCase(search, PageRequest.of(page, size));
    }

    public Page<Club> firstPaginated(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }



    /**
     * Sets the passkey for a club.
     *
     * @param clubName the name of the club
     * @param passkey  the passkey to set
     * @throws Exception if there is no club with the given name
     */
    public void setPassKey(String clubName, String passkey) throws Exception {

        clubName = clubName.toLowerCase();

        Optional<Club> optional = repository.findById(clubName.toLowerCase());

        if (optional.isEmpty()) {
            throw new Exception("There is no club with the given name. " + clubName);
        }

        Club club = optional.get();

        club.setPasskey(passkey);
        repository.save(club);
    }

    /**
     * checks that passkeys match.
     *
     * @param clubName the name of the club
     * @param passKey  the passkey to set
     * @throws Exception if there is no club with the given name or if the passkeys
     *                   do not match
     */
    public void checkPasskeyMatch(String clubName, String passKey) throws Exception {

        clubName = clubName.toLowerCase();

        Optional<Club> optional = repository.findById(clubName);

        if (optional.isEmpty()) {
            throw new Exception("There is no club with the given name. " + clubName);
        }

        Club club = optional.get();

        // both are null check
        if (club.getPasskey() == null && passKey == null) {
            return;
        }

        // Fail if only one of the two variables is null
        if ((club.getPasskey() == null && passKey != null) || (club.getPasskey() != null && passKey == null)) {
            throw new Exception("The passkeys do not match");

        }

        if (passKey.equals(club.getPasskey())) {
            return;
        }

        throw new Exception("The passkeys do not match");
    }

}
