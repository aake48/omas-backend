package com.omas.webapp.table;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table
@IdClass(RoleId.class)
@AllArgsConstructor
@NoArgsConstructor
public class Role {

    @Id
    @Column(nullable = false)
    private long userId;

    @Id
    @Column(nullable = false)
    private String role;

}
