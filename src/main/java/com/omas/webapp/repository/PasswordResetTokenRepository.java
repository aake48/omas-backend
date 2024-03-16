package com.omas.webapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.omas.webapp.table.PasswordResetToken;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {

    public PasswordResetToken findByResetPasswordToken(String PasswordResetToken);

}
