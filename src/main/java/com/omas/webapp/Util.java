package com.omas.webapp;

import java.util.regex.Pattern;

public class Util {

    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z0-9-_]+$");

    /**
     * Perform simple sanitation on the given name to make it url friendly
     * @param name the name to sanitize
     * @return the sanitized name or null if the sanitation could not be done
     */
    public static String sanitizeName(String name) {

        name = name
            .replace('ä', 'a').replace('Ä', 'A')
            .replace('ö', 'o').replace('Ö', 'O')
            .replace('å', 'a').replace('Å', 'A')
            .replace(' ', '_');

        if (!NAME_PATTERN.matcher(name).matches()) {
            return null;
        }

        return name;
    }

}