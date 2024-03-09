package com.omas.webapp.repoTests;

import com.omas.webapp.repository.TeamMemberRepository;
import com.omas.webapp.table.TeamId;
import com.omas.webapp.table.TeamMember;
import com.omas.webapp.table.TeamMemberId;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class member {

	@Autowired
	TeamMemberRepository repository;

	@Test
	public void addAndFindById() {

		TeamId idTeam = new TeamId("club", "club");

		TeamMemberId memberId =new TeamMemberId( 15225323532l, idTeam);
		TeamMember member = new TeamMember(memberId);




		try {
			repository.save(member);
			Optional<TeamMember> result1 = repository.findById(memberId);
			fail();
		} catch (Exception e) {
			return;
		}

		
		
	}

}
