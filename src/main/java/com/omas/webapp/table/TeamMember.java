package com.omas.webapp.table;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor; 

@Entity
@Data
@NoArgsConstructor
@Table(name = "TeamMember")
@IdClass(TeamMemberId.class)
public class TeamMember {

    @Id
    @Column(nullable = false)
    private Long userId;
    
    @Id
    @Column(nullable = false)
    private String competitionId;

    @Id
    @Column(nullable = false)
    private String clubId;

    private double sumScore;



} 

