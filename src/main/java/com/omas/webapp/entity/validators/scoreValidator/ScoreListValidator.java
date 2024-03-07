package com.omas.webapp.entity.validators.scoreValidator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.List;

public class ScoreListValidator implements ConstraintValidator<ValidScoreList, List<Double>> {
    @Override
    public boolean isValid(List<Double> value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        }
        return value.stream().allMatch(score -> score >= 0 && score <= 10.9);
    }

}
