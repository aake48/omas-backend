package com.omas.webapp.entity.validators.scoreValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = ScoreListValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidScoreList {
    String message() default "Invalid score in ScoreList";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}