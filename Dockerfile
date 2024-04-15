# Base image
FROM alpine:latest

# Install Java (OpenJDK 17) and PostgreSQL
RUN apk add --no-cache openjdk17 postgresql postgresql-client

# Set up environment variables
ENV DB_URL="jdbc:postgresql://localhost:5432/omas" \
    DB_USERNAME="postgres" \
    DB_PASSWORD="password" \
    SECRET="48794134879942idontlikedogs1323572342328789" \
    MAIL_HOST="smtp.gmail.com" \
    MAIL_USERNAME="someexample@gmail.com" \
    MAIL_PASSWORD="password1" \
    MAIL_PORT="587" \
    RECOVERY_PAGE="https://localhost:3000/recovery" \
    DURATIONOFVALIDITY="288000"

# Set permissions and initialize the database
RUN mkdir -p /var/log/postgresql /var/lib/postgresql/data /run/postgresql && \
    chown -R postgres:postgres /var/log/postgresql /var/lib/postgresql/data /run/postgresql && \
    su postgres -c "initdb -D /var/lib/postgresql/data"

# Create a database
RUN echo "CREATE DATABASE omas;" > /create_db.sql && \
    chown postgres:postgres /create_db.sql && \
    su postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/log/postgresql/postgres.log" && \
    su postgres -c "psql -f /create_db.sql"

# Prepare startup scripts
RUN echo "#!/bin/sh" > /start-postgres.sh && \
    echo "su postgres -c 'pg_ctl start -D /var/lib/postgresql/data -l /var/log/postgresql/postgres.log'" >> /start-postgres.sh && \
    echo "sleep infinity" >> /start-postgres.sh && chmod +x /start-postgres.sh

# Set working directory
WORKDIR /app

# Copy application files
COPY /build/libs/webapp-0.0.1-SNAPSHOT.jar webapp-0.0.1-SNAPSHOT.jar
COPY env.properties .
COPY src/main/resources/keystore/omas.p12 .

# Start script
RUN echo "#!/bin/sh" > /start.sh && \
    echo "echo 'Starting PostgreSQL...'" >> /start.sh && \
    echo "/start-postgres.sh &" >> /start.sh && \
    echo "echo 'PostgreSQL started'" >> /start.sh && \
    echo "echo 'Starting Java application...'" >> /start.sh && \
    echo "java -jar /app/webapp-0.0.1-SNAPSHOT.jar || echo 'Java application failed with status \$?'" >> /start.sh && \
    echo "echo 'Java application exited'" >> /start.sh && \
    echo "tail -f /dev/null" >> /start.sh && chmod +x /start.sh

# Expose port
EXPOSE 8080

# Run command
CMD ["/bin/sh", "/start.sh"]
