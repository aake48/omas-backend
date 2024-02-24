package com.omas.webapp.table;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table
@IdClass(RoleId.class)
public class Role {

    @Id
    @Column(nullable = false)
    private long userId;

    @Id
    @Column(nullable = false)
    private String role;

}
