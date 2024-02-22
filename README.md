# omas-backend - how to get started with dev
## 1st Setup PostgreSQL database

### 1st method: postgres docker container
With docker installed, use ```docker-compose up```
### 2nd method: local install
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
DB-PASSWORD=password
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
returns  string:message JSON
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
GET http://localhost:8080/api/club/?id=${compName}

```
returns club JSON
### Get all clubs

```
GET http://localhost:8080/api/club/all
```
returns List of clubs -JSON

### Search club with pagination

```
GET http://localhost:8080/api/club/query?search=${search}&page=${page}&size=${size}
```
returns [Page](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/domain/Page.html) of Clubs in JSON =>
```{
  "content": [
    {
      "name": "SeuraajienSeura",
      "creationDate": "2024-02-18",
      "idCreator": 1
    },
    {
      "name": "SeuraajienSeura2",
      "creationDate": "2024-02-18",
      "idCreator": 2
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 10,
    "sort": {
      "empty": true,
      "sorted": false,
      "unsorted": true
    },
    "offset": 0,
    "paged": true,
    "unpaged": false
  },
  "last": true,
  "totalPages": 1,
  "totalElements": 1,
  "size": 10,
  "number": 0,
  "sort": {
    "empty": true,
    "sorted": false,
    "unsorted": true
  },
  "first": true,
  "numberOfElements": 1,
  "empty": false
}
```

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
GET http://localhost:8080/api/competition/{competition's name}
```
returns competition in JSON
### Get all competitions

```
GET http://localhost:8080/api/competition/all
```
returns List of competitions in -JSON

### Search for competitions with pagination

```
GET http://localhost:8080/api/competition/query?search=${search}&page=${page}&size=${size}
```
returns [Page](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/domain/Page.html) of competitions in JSON