# DEPLOYMENT - table of contents	 
- [<ins>__How to run docker-compose.prod__</ins>](#how-to-run-docker-compose.prod)

- [<ins>__How to deploy to cloud__</ins> (?)](#how-to-deploy-to-cloud)


# How to run docker-compose.prod

## 1. have the lastest schema in the root of this project

### have the latest schema in the root of this project
#### if you do not have the latest schema, you can copy the lastest schema when running this project in dev profile

    docker exec database pg_dump -U postgres -d omas -n public > schema.sql

## 2.  Place the `.env` files in the root directory of the project.
There should be two environment files in the root directory of the project: `.env` and `env.properties`.

The `.env` file should have the following:

        NEXT_PUBLIC_API_URL=http://localhost:8080/
        NEXT_PUBLIC_RECAPTCHA_SITE_KEY=
        RECAPTCHA_SECRET_KEY=

and the `env.properties` should look like this:

        OMAS_DATABASE_URL=jdbc:postgresql://localhost:5432/omas
        OMAS_DATABASE_USERNAME=postgres
        OMAS_DATABASE_PASSWORD=password
        OMAS_SECRET_KEY=48794134879942idontlikedogs1323572342328789 // change this 
        OMAS_SMTP_HOST=smtp.gmail.com
        OMAS_SMTP_USERNAME=
        OMAS_SMTP_PASSWORD=
        OMAS_SMTP_PORT=587
        OMAS_RECOVERY_PAGE_URL=https://localhost:3000/recovery
        OMAS_TOKEN_VALIDITY_DURATION=28800000
        OMAS_MAX_LOGIN_ATTEMPTS=10
        OMAS_BAN_DURATION=86400000



## Ensure that you have the `omas-frontend` directory next to this one
The projects should be structured like this:

```
    .
    ├── omas-backend
    │   ├── src
    │   ├── Dockerfile
    │   ├── .env
    │   ├── env.properties
    │   └── ...
    └── omas-frontend
        ├── src
        ├── Dockerfile
        └── ...
```
## then run the docker-compose.prod.yml file to setup the containers
`docker-compose -f docker-compose.prod.yml up`

# how to deploy to cloud

Deployment to cloud depends on the cloud provider you are using. Here is a general guide on how to deploy to a cloud provider, but you should consult the documentation of the cloud provider you are using for more information.

## 1. Create a new project on the cloud provider's dashboard
Create a new project on the cloud provider's dashboard. This will give you access to the cloud provider's services.

## 2. Create a new Postgres database
Create a new Postgres database on the cloud provider's dashboard. This will be used to store the data for the application.

It is recommended to use the cloud provider's database services instead of the Docker image used in local development.

## 3. Push the code to the cloud provider's repository
Push the code based on the Dockerfiles to the cloud provider's repository. This will allow you to deploy the code to the cloud provider's services.

## 4. Update the env.properties file
Update the `env.properties` file with the database URL, username, and password for the database you created in step 2.

## 5. Update the .env file
Update the `.env` file with the API URL for the cloud provider's services.

