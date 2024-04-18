package com.omas.webapp.service;

import com.omas.webapp.entity.UserLoginAttemptCache;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class LoginAttemptService {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private TaskScheduler taskScheduler;

    @Value("${login.max-login-attempts}")
    private int MAX_ATTEMPTS = 10;

    @Value("${login.ban-duration}")
    private long BAN_DURATION = 24 * 60 * 60 * 1000;

    private static final ConcurrentHashMap<String, UserLoginAttemptCache> attemptsCache = new ConcurrentHashMap<>();

    @PostConstruct
    public void scheduleCacheClear() {

        taskScheduler.scheduleAtFixedRate(() -> {

            final long lastValidTime = System.currentTimeMillis() - BAN_DURATION;

            attemptsCache.entrySet().removeIf(entry -> {

                UserLoginAttemptCache cache = entry.getValue();

                return cache == null || cache.previousAttempt <= lastValidTime;
            });

        }, Duration.ofMillis(BAN_DURATION));

    }

    public void clearCache() {
        attemptsCache.remove(getClientIP());
    }

    /**
     * Signal to the service that the user behind the given IP address failed to log in and that their attempt counter should be increment
     * @param ip the IP address of the user attempting to log in
     */
    public void loginFailed(String ip) {

        UserLoginAttemptCache cache = attemptsCache.get(ip);

        // Reset the cache if it has been over 24 hours
        if (cache == null || cache.isExpired(BAN_DURATION)) {
            cache = new UserLoginAttemptCache();
        }

        cache.attempts++;
        cache.previousAttempt = System.currentTimeMillis();

        attemptsCache.put(ip, cache);
    }

    // Convenience method for the above method so you don't have to fetch the client IP every time
    public void loginFailed() {
        loginFailed(getClientIP());
    }

    /**
     * Check if the user is blocked from logging in.
     * @return true if the user has less than {@link LoginAttemptService#MAX_ATTEMPTS} failed login attempts in the past 24 hours
     */
    public boolean isBlocked() {

        String ip = getClientIP();

        UserLoginAttemptCache cache = attemptsCache.get(ip);

        if (cache == null) {
            return false;
        }

        if (cache.isExpired(BAN_DURATION)) {
            attemptsCache.remove(ip);
            return false;
        }

        return cache.attempts >= MAX_ATTEMPTS;
    }

    public String getClientIP() {

        String xfHeader = request.getHeader("X-Forwarded-For");

        if (xfHeader != null) {
            return xfHeader.split(",")[0];
        }

        return request.getRemoteAddr();
    }

}
