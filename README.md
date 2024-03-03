# omas-backend - table of contents	 
- [<ins>__How to run this project__</ins>](#how-to-run-this-project)
  - [1st Setup PostgreSQL database](#1st-setup-postgresql-database)
    - [1st method: postgres docker container](#1st-method-postgres-docker-container-recommended-method)
    - [2st method: postgres docker container](#2nd-method-local-install)
  - [2nd create env.properties](#2nd-create-envproperties)
  - [3rd run](#3rd-run)

- [<ins>__URLs for API__</ins>](#urls-for-api)

  - [User related](#user-related)
    - [Users](#user-related)
      - [registration](#registration)
      - [login](#login)

    - [Clubs](#clubs)
      - [Create new Club](#create-new-club)
      - [Get club by Id](#get-club-by-id)
      - [Get all clubs](#get-all-clubs)
      - [Search clubs with pagination](#search-clubs-with-pagination)
      - [Join club](#join-club)

  - [Competition related](#competition-related)
    - [competitions](#competition-related)
      - [Create new Competition](#create-new-competition)
      - [Get competition by Id](#get-competition-by-id)
      - [Get all competitions](#get-all-competitions)
      - [Search for competitions with pagination](#search-for-competitions-with-pagination)
      - [get results](#get-results)

    - [teams](#teams)
      - [create new team](#create-new-team)
      - [get team's score](#get-teams-score)
      - [team members](#team-member)
      - [add team member to team](#add-team-member-to-team)
      - [get user's score](#get-users-score)
      - [submit user's score](#submit-users-score)


- [<ins>__Types__</ins>](#Types)
  - [competitionResults](#competitionresults)
  - [login response](#login-response)
  - [competition](#competition)
  - [club](#club)
  - [...](#)



  



  

# How to run this project
## 1st Setup PostgreSQL database

### 1st method: postgres docker container (recommended method)
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
If user was added successfully, this will return {messge:"user added"}. If registration fails, the errors will be provided like this: 
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
```
[returns](#login-response): 
```

{
  "user": {
    "username": "johndoe",
    "legalName": "John doe",
    "email": "temp@email.com",
    "userId": 1,
    "authorities": "[ROLE_USER]",
    "creationDate": "2024-03-02",
    "club": null
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyIiwiaWF0IjoxNzA5MzYyOTcyLCJleHAiOjE3MDkzOTE3NzJ9.Qd1IsqU89ArTLkt6w91kKEzGGtkL5RTnzsACnpy8Efc"
} 
```
If login fails, the errors will be provided in the same kind of structure as in api/reg
## Clubs
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
GET http://localhost:8080/api/club/?id=${clubName}

```
returns club JSON
### Get all clubs

```
GET http://localhost:8080/api/club/all
```
returns List of clubs -JSON

### Search clubs with pagination
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Oulun" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.
```
GET http://localhost:8080/api/club/query?search=${search}&page=${page}&size=${size}
```
[returns page of clubs](#page)  =>
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
  "numberOfElements": 2,
  "empty": false
}
```
### join club
```
Post http://localhost:8080/api/club/join
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VybmFtZSIsImlhdCI6MTcwNzk3NTg2MSwiZXhwIjoxNzA4MDA0NjYxfQ.ygQwdRasggnz6V7ysze03ECpmS0YRDIFBbFY5c6Bmec
content-type: application/json

{
    "clubName": "Poliisi_seura"
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
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Kesän_2024" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.

```
GET http://localhost:8080/api/competition/query?search=${search}&page=${page}&size=${size}
```
[returns page of competitions](#page)

### get results
``` 
GET api/competition/result/{competitionName}
```
returns [competitionResults](#competitionResults)
``` 
{"name" : string,
  "nameNonId" : string,
  "creationDate" : string,
  "teams" : team[] || null
}
  Team:{
    "club" : "String",
    "totalScore" : number,
    "scores" : score[] || null
  }
    score: {
      "bullsEyeCount" : number,
      "sum" : number,
      "userId" : number,
      "scorePerShot":string
    }

``` 
## teams
### create new team 
Note: the following conditions must be met before a team can be created: 
- The user must be [a member of a club](#join-club)
- The competition that the team is participating in must already [exist](#create-new-competition) in the database.
```
POST api/competition/team/new
Authorization: required
Content-Type: application/json
{
  competitionName:String 
}
```
returns the team just created in json format.
If the team creation fails, reason for the failure will be provided in json {error:"reason for failure -string"}

### get team's score 
```
GET api/competition/team/score
Content-Type: application/json
{
  competitionName:String,
  clubName:string
}
```
returns JSON array of TeamMemberScore objects, and these objects look like this: 
```
{
    userId:long.
    clubId:string,
    competitionId:string;
    UUID:uuid
    sum:number
    bullsEyeCount:numer,
    scorePerShot:String, //this is a string representation of scoreList sent by the user
    creationDate:2024-12-1(String),
    }
```
## team member
### add team member to team 
Note: the following conditions must be met before user can join a team: 
- The user must be [a member of a club](#join-club)
- the club that user is part of must have [created a team](#create-new-team) for this competition before users add themselves to it.
```
POST api/competition/team/member/add
Authorization: required
Content-Type: application/json
{
  competitionName:String
}
```
Returns either created team member object or reason for failure in error:string json 

### get user's score
```
GET api/competition/team/member/score
Content-Type: application/json
{
  competitionName:String,
  userId:number
}
```
Returns [teamMemberScore object](#get-teams-score) if a score for this user exist.

### submit user's score
Note: the following conditions must be met before user can submit his scores: 
- The user must be [a team member](#add-team-member-to-team) for the competition before he is able to submit his scores
```
POST api/competition/team/member/score/add
Authorization: required
Content-Type: application/json
{
  competitionName:String,
  ScoreList:number[]
}
```
Returns [teamMemberScore object](#get-teams-score) if submission was successful. In other cases, a error:string json will be provided.

# Types 
## competitionResults
``` 
{"name" : string,
  "nameNonId" : string,
  "creationDate" : string,
  "teams" : team[] || null
}
``` 
### competitionResults.team
``` 
  {
    "club" : "String",
    "totalScore" : number,
    "scores" : score[] || null
  }
  ```
   
  ### competitionResults.team.scores
  ``` 
    {
      "bullsEyeCount" : number,
      "sum" : number,
      "userId" : number,
      "scorePerShot":string
    }
``` 
## login response
``` 
{
  "user": {
    "username": string,
    "legalName": string,
    "email": string,
    "userId": number,
    "authorities": string, 
    "creationDate": string,
    "club": string || null
  },
  "token": string
} 
``` 
## page
Tässä on kaikki oleellinen käytölle, muu on extraa, jotka voidaan sivuuttaa.
Jos haluat nähdä mitä kokonaisuudessaan tulee, sen pystyt näkemään  [täältä, seurojen hausta](#search-clubs-with-pagination)
```
{
  "content": club[]||competition[] ||null,
  "pageable": {
    "pageNumber": number,
    "pageSize": number,
  },
  "last": boolean,
  "totalPages": number, // kuinka paljon tuloksia haulla on saatavilla
  "totalElements": number, // kuinka monta elementtiä kyseistä asiaa DB:ssä on
  "size": number, //haun sivun koko
  "number": number, // sivunumero
  "first": boolean,
  "numberOfElements": number, //sivun sisällön määrä
  "empty": boolean
}
```
## competition
Mm. onnistunut kilpailun luominen palauttaa tälläisen.
```
  {
	  name:String, //@id
	  nameNonId:String,
    creationDate:string
    }
```
## club
Mm. onnistunut seuran luominen palauttaa tälläisen.
```
{
	name:string, // @id
	nameNonId:String,
	private Date creationDate:string,
	idCreator:number
  }
```
## --- unfinished ---
check source 



```
src\main\java\com\omas\webapp\table

src\main\java\com\omas\webapp\controller

```