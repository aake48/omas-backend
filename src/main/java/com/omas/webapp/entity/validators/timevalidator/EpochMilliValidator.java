package com.omas.webapp.entity.validators.timevalidator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.time.Instant;
import java.time.temporal.ChronoUnit;

public class EpochMilliValidator implements ConstraintValidator<ValidEpochMilli, Long> {
    private int daysBehind;
    private int daysAhead;

    @Override
    public void initialize(ValidEpochMilli constraintAnnotation) {
        daysBehind = constraintAnnotation.daysBehind();
        daysAhead = constraintAnnotation.daysAhead();
    }

    @Override
    public boolean isValid(Long value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        }
        Instant now = Instant.now();
        Instant past = now.minus(daysBehind, ChronoUnit.DAYS);
        Instant future = now.plus(daysAhead, ChronoUnit.DAYS);
        Instant valueInstant = Instant.ofEpochMilli(value);
        return !valueInstant.isBefore(past) && !valueInstant.isAfter(future);
    }
}