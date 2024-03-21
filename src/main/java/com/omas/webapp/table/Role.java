package com.omas.webapp.table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table
@IdClass(RoleId.class)
@NoArgsConstructor
public class Role {

    @Id
    @Column(nullable = false)
    private long userId;

    @Id
    @Column(nullable = false)
    private String role;

    @JsonIgnore
    public Role(Long id, String role){
        this.userId = id;
        this.role = role;
    }



}
