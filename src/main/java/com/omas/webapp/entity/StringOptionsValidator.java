package com.omas.webapp.entity;

import jakarta.validation.Constraint;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import jakarta.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.Arrays;
import com.omas.webapp.entity.StringOptionsValidator.StringOptions;

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

    @Documented
    @Constraint(validatedBy = StringOptionsValidator.class)
    @Target({ ElementType.METHOD, ElementType.FIELD })
    @Retention(RetentionPolicy.RUNTIME)
    public
    @interface StringOptions {
        String message() default "Invalid option";

        Class<?>[] groups() default {};

        Class<? extends Payload>[] payload() default {};

        String[] value();
    }

}
