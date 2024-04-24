# Base image
FROM alpine:latest

# Install Java (OpenJDK 17), PostgreSQL, and PostgreSQL client utilities
RUN apk add --no-cache openjdk17 postgresql postgresql-client

# Set permissions and initialize the database
RUN mkdir -p /var/log/postgresql /var/lib/postgresql/data /run/postgresql && \
    chown -R postgres:postgres /var/log/postgresql /var/lib/postgresql/data /run/postgresql && \
    su postgres -c "initdb -D /var/lib/postgresql/data"

# Create a database and initialize it with dump.sql
COPY dump.sql /dump.sql
RUN echo "CREATE DATABASE omas;" > /create_db.sql && \
    chown postgres:postgres /create_db.sql && \
    su postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/log/postgresql/postgres.log" && \
    su postgres -c "psql -f /create_db.sql" && \
    su postgres -c "psql -d omas -f /dump.sql"

# Set working directory
WORKDIR /app

ENV OMAS_DATABASE_URL=jdbc:postgresql://localhost:5432/omas
ENV OMAS_DATABASE_USERNAME=postgres
ENV OMAS_DATABASE_PASSWORD=password
ENV OMAS_SECRET_KEY=48794134879942idontlikedogs1323572342328789
ENV OMAS_SMTP_HOST=smtp.gmail.com
ENV OMAS_SMTP_USERNAME=example@gmail.com
ENV OMAS_SMTP_PASSWORD=password
ENV OMAS_SMTP_PORT=587 
ENV OMAS_RECOVERY_PAGE_URL=https://localhost:3000/recovery
ENV OMAS_TOKEN_VALIDITY_DURATION=28800000
ENV OMAS_MAX_LOGIN_ATTEMPTS=500
ENV OMAS_BAN_DURATION=86400000

# Copy application files
COPY /build/libs/webapp-0.0.1-SNAPSHOT.jar webapp-0.0.1-SNAPSHOT.jar
COPY env.properties .
COPY src/main/resources/keystore/omas.p12 .

# Prepare startup scripts
RUN echo "#!/bin/sh" > /start-postgres.sh && \
    echo "su postgres -c 'pg_ctl start -D /var/lib/postgresql/data -l /var/log/postgresql/postgres.log'" >> /start-postgres.sh && \
    echo "sleep infinity" >> /start-postgres.sh && chmod +x /start-postgres.sh

# Start script
RUN echo "#!/bin/sh" > /start.sh && \
    echo "echo 'Starting PostgreSQL...'" >> /start.sh && \
    echo "/start-postgres.sh &" >> /start.sh && \
    echo "echo 'PostgreSQL started'" >> /start.sh && \
    echo "until pg_isready -h localhost -p 5432 -U postgres; do sleep 1; done" >> /start.sh && \
    echo "echo 'Starting Java application...'" >> /start.sh && \
    echo "java -jar /app/webapp-0.0.1-SNAPSHOT.jar || echo 'Java application failed with status \$?'" >> /start.sh && \
    echo "echo 'Java application exited'" >> /start.sh && \
    echo "tail -f /dev/null" >> /start.sh && chmod +x /start.sh

# Expose port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "webapp.jar", "--spring.profiles.active=prod"]