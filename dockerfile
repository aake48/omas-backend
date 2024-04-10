#FROM gradle:latest AS build

#WORKDIR /home/gradle/src

#COPY env.properties .

#COPY build.gradle .
#COPY settings.gradle .

#COPY src src

# Remove -x test if you want to run the tests
#RUN gradle build -x test --no-daemon

#Uncomment above if gradle build is needed.


FROM openjdk:latest

ENV DB-URL=jdbc:postgresql://localhost:5432/omas
ENV DB-USERNAME=postgres
ENV DB-PASSWORD=password
ENV SECRET=48794134879942idontlikedogs1323572342328789
ENV MAIL-HOST=smtp.gmail.com
ENV MAIL-USERNAME=someexample@gmail.com
ENV MAIL-PASSWORD=password1
ENV MAIL-PORT=587
ENV RecoveryPage=https://localhost:3000/recovery
ENV DURATIONOFVALIDTY=28800000

WORKDIR /app


COPY env.properties .
COPY /build/libs/webapp-0.0.1-SNAPSHOT.jar webapp-0.0.1-SNAPSHOT.jar
COPY src/main/resources/keystore/omas.p12 omas.p12

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "webapp-0.0.1-SNAPSHOT.jar"]
