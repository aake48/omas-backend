package com.omas.webapp.entity;

public class UserLoginAttemptCache {

    public int attempts = 0;
    public long previousAttempt = -1;

    public boolean isExpired(long banDuration) {

        long lastValidTime = System.currentTimeMillis() - banDuration;

        return previousAttempt <= lastValidTime;
    }

}
