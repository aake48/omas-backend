package com.omas.webapp.entity.validators.stringValidator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.Arrays;

/**
 * This class is a custom validator for validating string options.
 * It implements the ConstraintValidator interface and is used to validate
 * whether a given string value is one of the specified options.
 */
public class StringOptionsValidator implements ConstraintValidator<StringOptions, String> {

    private String[] options;

    @Override
    public void initialize(StringOptions constraintAnnotation) {
        options = constraintAnnotation.value();
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value == null || Arrays.asList(options).contains(value);
    }


}
