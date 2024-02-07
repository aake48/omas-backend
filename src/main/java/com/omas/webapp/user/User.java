package com.omas.webapp.user;

import jakarta.persistence.*;

@Entity
@Table(name = "user_")
public class User {
    @Id
    @SequenceGenerator(name = "user_sequence", sequenceName = "user_sequence", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_sequence")
    private long id;
    private String username;
    private String name;
    private long teamId;
    private String password;

    public User(long id, String username, String name, long teamId, String password) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.teamId = teamId;
        this.password = password;

    }

    public User(String username, String name, long teamId, String password) {
        this.username = username;
        this.name = name;
        this.teamId = teamId;
        this.password = password;

    }

    public User() {
    }

    public long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public long getTeamId() {
        return teamId;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public String toString() {
        return "";
    }

}
