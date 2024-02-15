# omas-backend - how to get started with dev
## 1st Setup PostgreSQL database
Install  and setup the lastest version of [PostgreSQL](https://www.postgresql.org/download/).  
Go with the defaults when installing postgres. No additional dependencies or software are needed. 
Next create a postgres database either in SQL shell (psql) or pgadmin.

To create a database in SQL shell, use the following: 
```
create database omas; 
```
To check that omas db was created, type: \l


## 2nd create env.properties 
Create env.properties file in the root of the project.

env.properties should contain the following:
```
DB-URL=jdbc:postgresql://localhost:5432/omas
DB-USERNAME=postgres
DB-PASSWORD=yourPostgresPassword
SECRET=48794134879942idontlikedogs1323572342328789
```
## 3rd run 
Run main found in <ins>src/main/java/com/omas/webapp/WebappApplication.java</ins>

# URLs for API 
## user related
### Registration
```

POST http://localhost:8080/api/reg 
content-type: application/json

{
    "username": "Username",
    "name":"pekka",
    "password": "password",
    "email": "temp@email.com"
}
```
Ylläoleva palauttaa joko String message tai JSON:in, jossa on validointivirheet merkattu seuraavasti, ja seuraavissa POST syötteissä validointivirheet tulevat samankaitaisessa JSON-palautteena. 

403 = use not added / username is taken

200 => user added 

400 => JSON 
```
{
  "password": "Password cannot be fewer than 6 characters",
  "name": "name cannot be fewer than 3",
  "email": "Email should be in the correct format.",
  "username": "Username cannot be larger than 64 characters"
}
```
### login
```
POST http://localhost:8080/api/login
content-type: application/json

{
    "username": "Username",
    "password": "password"
}
returns string message /
```
## Club related
### Create new Club
```
Post http://localhost:8080/api/auth/club/new
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VybmFtZSIsImlhdCI6MTcwNzk3NTg2MSwiZXhwIjoxNzA4MDA0NjYxfQ.ygQwdRasggnz6V7ysze03ECpmS0YRDIFBbFY5c6Bmec
content-type: application/json

{
    "clubName": "Seuraajien seura"
}
```
returns either created club -JSON or list of validation violations -JSON
```
{
  "name": "Seuraajien seura",
  "creationDate": "2024-02-15",
  "idCreator": 1
}
```

### Get club by Id

```
Post http://localhost:8080/api/auth/club/{club'sname}
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VybmFtZSIsImlhdCI6MTcwNzk3NTg2MSwiZXhwIjoxNzA4MDA0NjYxfQ.ygQwdRasggnz6V7ysze03ECpmS0YRDIFBbFY5c6Bmec
content-type: application/json

{
    "clubName": "Seuraajien seura"
}
```
Retuns club JSON
### Get all clubs

```
GET http://localhost:8080/api/auth/club/all
```
Retuns List of clubs -JSON

### Search club with pagination

```
GET http://localhost:8080/api/club/query?search=${search}&page=${page}&size=${size}
```
Retuns [Page](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/domain/Page.html) of Clubs in JSON

## Competition related
### Create new Competition
```
Post http://localhost:8080/api/auth/competition/new
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VybmFtZSIsImlhdCI6MTcwNzk3NTg2MSwiZXhwIjoxNzA4MDA0NjYxfQ.ygQwdRasggnz6V7ysze03ECpmS0YRDIFBbFY5c6Bmec
content-type: application/json

{
    "competitionName": "kilpa"
}
```
returns either created competition -JSON or list of validation violations -JSON


### Get competition by Id

```
Post http://localhost:8080/api/auth/competition/{competition's name}
content-type: application/json
```
Retuns competition in JSON
### Get all competitions

```
GET http://localhost:8080/api/auth/competition/all
```
Retuns List of competitions in -JSON

### Search for competitions with pagination

```
GET http://localhost:8080/api/competition/query?search=${search}&page=${page}&size=${size}
```
Retuns [Page](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/domain/Page.html) of competitions in JSON