package com.omas.webapp;

import java.util.regex.Pattern;

public final class Constants {

    private Constants() {
        // restrict instantiation
    }

    public static final String PISTOL_TYPE = "pistol";
    public static final String RIFLE_TYPE = "rifle";

    public static final String COMPETITION_SERIES = "Y-mestaruussarja";


    public static final String ADMIN_USERNAME = "admin";
    public static final String ADMIN_PASSWORD = "adminPassword";

    public static final String ADD_METHOD_SET = "set";
    public static final String ADD_METHOD_UPDATE = "update";

    public static final double MAX_SCORE = 654;
    public static final int MAX_BULLS_EYES = 60;
    public static final int MAX_ROUND = 10;

    public static final Pattern VALID_NAME_PATTERN = Pattern.compile("^[a-z0-9-_]+$");

    public static String createIdString(String name) {

        String idString = name.toLowerCase()
        .replace('ä', 'a')
        .replace('ö', 'o')
        .replace('å', 'a')
        .replace(' ', '_');

        if (!VALID_NAME_PATTERN.matcher(idString).matches()) {
            return null;
        }

        return idString;
    }

    // add more constants here
}