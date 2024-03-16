package com.omas.webapp.entity.validators.timevalidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = EpochMilliValidator.class)
@Target({ ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidEpochMilli {
    String message() default "Invalid epoch milli";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int daysBehind() default 1;

    int daysAhead() default 365;
}