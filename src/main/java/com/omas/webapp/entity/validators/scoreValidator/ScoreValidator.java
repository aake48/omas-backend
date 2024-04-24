package com.omas.webapp.entity.validators.scoreValidator;

import com.omas.webapp.Constants;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class ScoreValidator implements ConstraintValidator<ValidScore, Double> {

    @Override
    public boolean isValid(Double value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        }
        return value >= 0 && value <= Constants.MAX_SCORE;
    }

}
