
# copy the lastest schema
    docker exec database pg_dump -U postgres -d omas -n public > schema.sql

# place env files to root
    there should be two env files in the root of this project => '.env' and 'env.properties'

    .env should look like this: 

        NEXT_PUBLIC_API_URL=http://localhost:8080/
        NEXT_PUBLIC_RECAPTCHA_SITE_KEY=
        RECAPTCHA_SECRET_KEY=

    and env.properties should look like this:

        OMAS_DATABASE_URL=jdbc:postgresql://localhost:5432/omas
        OMAS_DATABASE_USERNAME=postgres
        OMAS_DATABASE_PASSWORD=password
        OMAS_SECRET_KEY=48794134879942idontlikedogs1323572342328789
        OMAS_SMTP_HOST=smtp.gmail.com
        OMAS_SMTP_USERNAME=
        OMAS_SMTP_PASSWORD=
        OMAS_SMTP_PORT=587
        OMAS_RECOVERY_PAGE_URL=https://localhost:3000/recovery
        OMAS_TOKEN_VALIDITY_DURATION=28800000
        OMAS_MAX_LOGIN_ATTEMPTS=10
        OMAS_BAN_DURATION=86400000

# then run docker-compose.prod.yml file