# First stage: build the application
FROM gradle:jdk17 as build

WORKDIR /app

# Copy the Gradle configuration files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Install dos2unix and convert the gradlew file
# this converts the local windows line-ended gradlew file to unix line-ended gradlew file
# this is necessary because the local environment was windows and the docker environment is linux

RUN apt-get update && apt-get install -y dos2unix && dos2unix gradlew && chmod +x gradlew

# Download Gradle
RUN ./gradlew --version

# Copy the source code
COPY src src

# Build the application
RUN ./gradlew clean build -x test

# Second stage: run the application
FROM openjdk:latest

WORKDIR /app

# Copy the built JAR file from the first stage
COPY --from=build /app/build/libs/*.jar webapp.jar
COPY src/main/resources/keystore/omas.p12 omas.p12

# Copy the env.properties file
COPY env.properties env.properties

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "webapp.jar"]