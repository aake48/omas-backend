package com.omas.webapp.table;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
public class PasswordResetToken {

    public PasswordResetToken(String token, long userId) {
        this.expiryDate = LocalDateTime.now().plus(1, ChronoUnit.HOURS); // Set expiry date to 1 hour from now
        this.resetPasswordToken = token;
        this.id = userId;
    }

    @Id
    private Long id;

    @Column(unique = true)
    private String resetPasswordToken;

    private LocalDateTime expiryDate;

    public boolean hasExpired() {
        return LocalDateTime.now().isAfter(expiryDate);
    }

    @OneToOne
    @JoinColumn(name = "id", referencedColumnName = "id", insertable = false, updatable = false)
    private User user;

}