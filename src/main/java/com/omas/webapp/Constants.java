package com.omas.webapp;

public final class Constants {

    private Constants() {
        // restrict instantiation
    }

    public static final String pistolType = "pistol";
    public static final String rifleType = "rifle";

    public static final String adminUsername = "admin";
    public static final String adminPassword = "adminPassword";

    public static String createIdString(String name) {

        String idString = name
        .replace('ä', 'a').replace('Ä', 'A')
        .replace('ö', 'o').replace('Ö', 'O')
        .replace('å', 'a').replace('Å', 'A')
        .replace(' ', '_');

        return idString;
    }

    // add more constants here
}