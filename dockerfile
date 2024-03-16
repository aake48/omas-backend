FROM gradle:latest AS build

WORKDIR /home/gradle/src

COPY env.properties .

COPY build.gradle .
COPY settings.gradle .

COPY src src

RUN gradle build -x test --no-daemon

FROM openjdk:latest

WORKDIR /app

# Copty the env.properties file from the build stage to the current directory in the Docker image
COPY --from=build /home/gradle/src/env.properties env.properties

# Copy the JAR file from the build stage to the current directory in the Docker image
COPY --from=build /home/gradle/src/build/libs/webapp-0.0.1-SNAPSHOT.jar webapp-0.0.1-SNAPSHOT.jar



# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "webapp-0.0.1-SNAPSHOT.jar"]
