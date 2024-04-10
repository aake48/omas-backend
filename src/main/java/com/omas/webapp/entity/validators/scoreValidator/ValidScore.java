package com.omas.webapp.entity.validators.scoreValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = ScoreValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidScore {
    String message() default "Invalid score. Must be in the range [0, 654]";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}