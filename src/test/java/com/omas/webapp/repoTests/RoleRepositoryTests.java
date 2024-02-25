package com.omas.webapp.repoTests;

import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.List;
import com.omas.webapp.table.Role;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
import com.omas.webapp.repository.RoleRepository;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class RoleRepositoryTests {

        @Autowired
        private RoleRepository repo;

        @Test
        public void findDistinctByuserIdTest() {

                Role role1 = new Role(1, "USER_ROLE");
                Role role2 = new Role(1, "USER_ROLE");
                Role role3 = new Role(1, "USER_ROLE");
                Role user2 = new Role(11, "USER_ROLE");
                Role user3 = new Role(111, "USER_ROLE");
                Role user4 = new Role(0, "USER_ROLE");

                repo.save(role1);
                repo.save(role2);
                repo.save(role3);
                repo.save(user2);

                List<Role> roles = repo.findDistinctByuserId(1L);

                assertTrue(roles.size() == 1);
                assertTrue(roles.get(0).getRole().equals("USER_ROLE"));
                assertTrue(roles.contains(role1));
                assertTrue(roles.contains(role2));
                assertTrue(roles.contains(role3));

                assertTrue(!roles.contains(user2));
                assertTrue(!roles.contains(user3));
                assertTrue(!roles.contains(user4));
        }

}
