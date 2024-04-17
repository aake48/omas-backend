# omas-backend - table of contents	 
- [<ins>__How to run this project__</ins>](#how-to-run-this-project)
  - [1st Setup PostgreSQL database](#1st-setup-postgresql-database)
    - [1st method: postgres docker container](#1st-method-postgres-docker-container-recommended-method)
    - [2st method: local install](#2nd-method-local-install)
  - [2nd create env.properties](#2nd-create-envproperties)
  - [3rd run](#3rd-run)

- [<ins>__API endpoints__</ins>](#api-endpoints)

  - [User related](#user-related)
    - [Users](#user-related)
      - [registration](#registration)
      - [login](#login)
      - [update password](#update-password)
      - [update email](#update-email)
      - [forgot password](#forgot-password)
      - [reset password](#reset-password)
      - [get user's team in competition](#get-users-team-in-competition)
      - [get all user's teams](#get-all-users-teams-in-all-competitions)

    - [admin](#admin-related)
      - [search users](#search-users)
      - [promote user](#promote-user)
      - [demote user](#demote-user)
      - [Delete user](#delete-user)

    - [club admins](#reset-password)
      - [update team member's scores](#update-team-members-scores)
      - [set passkey](#set-passkey)

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
      - [get competition by year](#get-competition-by-year)
      - [query active competitions](#query-active-competitions)
      - [query inactive competitions](#query-inactive-competitions)
      - [query upcoming competitions](#query-upcoming-competitions)
      - [Get results](#get-competition-results)
      - [am I participating in this competition?](#am-i-participating-in-this-competition)
    - [teams](#teams)
      - [query teams with clubName](#query-teams-with-clubname)
      - [create new team](#create-new-team)
      - [get team's score](#get-team-scores)
      - [teamExists](#check-if-team-exists)
      - [Get all teams participating in a competition](#get-all-teams-participating-in-a-competition)
      - [get club's team that are in active competitions](#get-clubs-team-that-are-in-active-competitions)
      - [get team with member IDs](#get-team-with-member-ids)
    - [team members](#team-member)
      - [add team member to team](#add-team-member-to-team)
      - [get user's score](#get-users-score)
      - [submit user's score as a sum](#submit-users-score-as-a-sum)
      - [isMember](#ismember)
    - [images](#image)
      - [upload image](#upload-image)
      - [download image](#download-image)


- [<ins>__Types__</ins>](#Types)
  - [CompetitionResponse](#competitionresponse)
  - [CompetitionTeamResponse](#competitionteamresponse)
  - [TeamMemberScoreResponse](#teammemberscoreresponse)
  - [TeamMemberScore](#teammemberscore)
  - [LoginResponse](#loginresponse)
  - [Page](#page)
  - [Competition](#competition)
  - [Club](#club)
  - [TeamMember](#teammember)
  - [Team](#team)
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
```
## 3rd run 
Run main found in <ins>src/main/java/com/omas/webapp/WebappApplication.java</ins>

# API endpoints 

All endpoints will return HTTP status 200 on success and HTTP status 400 on fail unless specified otherwise.
Missing or invalid fields will return messages in the form
```
{
  "password": "Password cannot be fewer than 6 characters",
  "name": "name cannot be fewer than 3",
  "email": "Email should be in the correct format.",
  "username": "Username cannot be larger than 64 characters"
}
```
and other messages will be returned in the form
```
{
  "message": "Some message"
}
```
These messages may also be errors, but they will be errors such as a competition or club not existing.
These messages are intended for developers and users should be given more descriptive messages.

## User related
### Registration
```
POST https://localhost:8080/api/reg 
Content-Type: application/json
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
### Login
```
POST https://localhost:8080/api/login
Content-Type: application/json
{
  "username": "Username",
  "password": "password"
}
```
returns [LoginResponse](#loginresponse):
```
{
  user: {
    username: string,
    legalName: string,
    email: string,
    userId: number,
    roles: string[],
    creationDate: string //"2024-03-02",
    club: null | string
  },
  token: string 
} 
```
If login fails, the errors will be provided in the same kind of structure as in api/reg

### update password
```
POST https://localhost:8080/api/updatePassword
Authorization: required

Content-Type: application/json
{
  newPassword: string,
  oldPassword: string
}
```
returns status code 200 if email was changed

### update email
```
POST https://localhost:8080/api/updateEmail
Authorization: required

Content-Type: application/json
{
  password: string,
  email: string
}
```
returns status code 200 if password was changed
### forgot password

```
POST https://localhost:8080/api/forgot_password
Content-Type: application/json
{
  "email": string
}
```
returns code 200 if email was sent, 400 if not

### reset password
```
POST https://localhost:8080/api/reset_password?token=${token}&password=${newPassword}
```

### Get user's team in competition
```
GET https://localhost:8080/api/user/team?competitionId={competitionId}
```
returns [team](#team)

### Get all user's teams in all competitions
```
GET https://localhost:8080/api/user/teams
```
returns list of [team](#team)s

returns code 200 if password was updated, 400 if not
## admin related
### search users
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Oulun" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.
```
get https://localhost:8080/api/admin/user/query?search=${search}&page=${page}&size=${size}
Authorization: ROLE_ADMIN required
Content-Type: application/json
```
returns Page of users with their roles 

### promote user
use this endpoint for adding roles for users
```
Post https://localhost:8080/api/admin/promote
Authorization: ROLE_ADMIN required
Content-Type: application/json
{
userId:number,
role:string
}
```
returns the role created
### demote user
use this endpoint for removing roles from users
```
Post https://localhost:8080/api/admin/demote
Authorization: ROLE_ADMIN required
Content-Type: application/json
{
userId:number,
role:string
}
```
Returns arbitrary message. StatusCodes => 200=success, 400=failure
### Delete user
```
DELETE https://localhost:8080/api/admin/delete
Content-Type: application/json
{
  userId: number
}
```
returns code 200 if the user was deleted, 400 if something went wrong
Note: this endpoint requires admin role

## club admin related
### update team member's scores
Update/add your fellow teamMember's Scores with this, when you have clubAdmin Role in your club

requestType determines the operation used to update the user's scores. It has two possible values:
"set" sets the score overwriting any previous while
"update" adds to the previous score or sets the score if there are none yet
```
POST https://localhost:8080/api/competition/team/member/score/add/sum/admin
Authorization: required "{clubName}/admin" role required
Content-Type: application/json
{
  competitionName:string,
  teamName:String,
  clubName:String,
  userId:number,
  score:number,
  requestType: set || update, optional
  bullsEyeCount:number
}
```
### set passkey
Note: A user must obtain clubAdmin status either by  [creating a club](#create-new-club) or by being [promoted](#promote-user) by an sys admin in order to have the authority to update passkeys for that club.
```
POST https://localhost:8080/api/club/setPasskey
Authorization: required clubAdmin Role
Content-Type: application/json
{
clubName:string,
passkey:string
}
```
if successful, returns status code 200.

## Clubs
### Create new Club
Note: backend will remove any whitespaces and äöå from the clubName and this altered version of the string will be made the ID. 
Unaltered version of the name will be saved to [nameNonId](#club). Only [a-zA-Z0-9-_] chars are allowed to be in the name, after the alterations. 
If there are any others the result will be code 400.
```
POST https://localhost:8080/api/auth/club/new
Authorization: required
Content-Type: application/json
{
    "clubName": "Seuraajien seura"
}
```
returns either the created [club](#club) or a JSON object containing validation violations
```
{
  "name": "Seuraajien_seura",
  "nameNonId": "Seuraajien seura"
  "creationDate": "2024-02-15",
  "idCreator": 1
}
```

### Get club by Id
```
GET https://localhost:8080/api/club/{clubId}
```
returns [Club](#club):
```
{
  "name": string, // @id
  "nameNonId": string,
  "creationDate": string,
  "idCreator": number
}
```
### Get all clubs
```
GET https://localhost:8080/api/club/all
```
returns a list of all [Club](#club)s

### Search clubs with pagination
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Oulun" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.
```
GET https://localhost:8080/api/club/query?search=${search}&page=${page}&size=${size}
```
[returns page of clubs](#page)  =>
```
{
  "content": [
    {
      "name": "SeuraajienSeura",
      "nameNonId": "SeuraajienSeura,
      "creationDate": "2024-02-18",
      "idCreator": 1
    },
    {
      "name": "SeuraajienSeura2",
      "nameNonId": "SeuraajienSeura2,
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
### Join club
```
POST https://localhost:8080/api/auth/club/join
Authorization: required
Content-Type: application/json
{
    clubName: string,
    passkey:string | null // optional 
}
```


## Competition related
### Create new Competition
Note: backend will remove any whitespaces and äöå from the competitionName and this altered version of the string will be made the ID. 
Unaltered version of the name will be saved to [competitionId](#competition). Only [a-zA-Z0-9-_] chars are allowed to be in the name, after the alterations. 
If there are any others the result will be code 400.

startDate and endDate are optional. If they are not provided, backend will set them automatically start date to now and end date now + 7d. If provided: start can range from now-1 to now +365d and end from now to +364d
```
POST https://localhost:8080/api/auth/competition/new
Authorization: required
Content-Type: application/json
{
    "competitionName": string,
    "competitionType": "rifle" || "pistol"
    "startDate": number,
    "endDate": number,
}
```
returns [competition](#competition)
```
{
  "competitionId": string,
  "displayName": string,
  "type": "rifle" || "pistol"
  "startDate": number,
  "endDate": number,
  "creationDate": string
}
```

### Get competition by Id

```
GET https://localhost:8080/api/competition/{competitionName}
```
returns [competition](#competition)
### Get all competitions

```
GET https://localhost:8080/api/competition/all
```
returns a list of all [competition](#competition)s

### Search for competitions with pagination
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Kesän_2024" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.

```
GET https://localhost:8080/api/competition/query?search=${search}&page=${page}&size=${size}
```
### get competition by year
```
GET https://localhost:8080/api/competition/query?year=${year:number}&page=${page}&size=${size}
```
### query active competitions
```
GET https://localhost:8080/api/competition/active/query?page=${page:number}&size=${size:number}
```
[returns page of competitions](#page) which have begun and have not ended yet (startDate<now && endDate>now).
### query inactive competitions
```
GET https://localhost:8080/api/competition/inactive/query?page=${page:number}&size=${size:number}
```
### query upcoming competitions
```
GET https://localhost:8080/api/competition/upcoming/query?page=${page:number}&size=${size:number}
```
[returns page of competitions](#page) which have not started yet (startDate>now).
### Get competition results
teams and scores are sorted descending by totalScore and sum
``` 
GET api/competition/result/{competitionName}
```
returns [CompetitionResponse](#competitionresponse)
### am I participating in this competition
```
GET https://localhost:8080/api/competition/team/amParticipating
Authorization: required (ROLE_USER)
Content-Type: application/json
{
    "competitionName": string
}
```
If user is in [a team](#team) team of this competition, team object will be returned with code 200. If this competition exist but user is not participating in it, code 204 will be returned. 400 if this competition does not exist.

## Teams

### query teams with clubName
Note the following:
  - search parameter is optional, it can be left empty.
  - When changing search parameter, please reset your current __page__ parameter to 0. Each search has its own number of pages which could result in an error if you're on page 34 of all results(search=null) and after this you change the search term for "Kesän_2024" which may only results in totalPages of 1. Query of a page numer that is larger than totalPages will result in an error.
```
get api/competition/team/query?search=${clubName}&page=${page}&size=${size}
```

### Create new team 
Note: the following conditions must be met before a team can be created: 
- The user must be [a member of a club](#join-club)
- The competition that the team is participating in must already [exist](#create-new-competition) in the database.
```
POST api/competition/team/new
Authorization: required
Content-Type: application/json
{
  "competitionName": string 
}
```
returns the team just created in json format.
If the team creation fails, reason for the failure will be provided in json {error:"reason for failure -string"}

### Get team scores
```
GET api/competition/team/score
Content-Type: application/json
{
  "competitionName": string,
  "teamName": string
}
```
returns a list of [TeamMemberScore](#teammemberscore)s
### Check if team exists
```
GET api/competition/team/teamExists
Content-Type: application/json
{
  "competitionName": string,
  "teamName": string
}
```
returns true if club has team in this comp, false otherwise. 

### Get all teams participating in a competition
```
GET api/competition/teams
Content-Type: application/json
{
  "competitionName": String
}
```
returns
```
{
  "message": "No competition found with that name"
}
```
and HTTP status code 400 if the competition is not found, or
```
{
  "competitionId": string,
  "teams": [
    {
      "teamName": string,
      "teamDisplayName": string
    }
  ]
}
```
and HTTP status code 200 if the competition is found

### get club's team that are in active competitions
```
GET api/competition/team/active/query?club=${clubName:sring}&page=${pageNumber:number}&size=${sizeOfPage:number}
```
[returns page of club's teams](#page) which are in active competitions(comps where(startDate<now && endDate>now))


### Get team with member IDs
```
GET api/competition/team?team={teamName}&competition={competitionName}
```
returns [team](#team)
```
{
  "teamName": string,
  "competitionId": string,
  "teamMembers": TeamMember[]
}
```

## Team member
[TeamMember](#teammember)
### Add team member to team 
Note: the following conditions must be met before user can join a team: 
- The user must be [a member of a club](#join-club)
- the club that user is part of must have [created a team](#create-new-team) for this competition before users add themselves to it.
```
POST api/competition/team/member/add
Authorization: required
Content-Type: application/json
{
  "teamName": string,
  "competitionName": string
}
```
returns [TeamMember](#teammember)
### get user's score
```
GET api/competition/team/member/score
Content-Type: application/json
{
  "competitionName": string,
  "userId": number
}
```
returns [TeamMemberScore](#teammemberscoreresponse) if a score for this user exist.

### Submit user's score as a sum
Note: the following conditions must be met before user can submit his scores: 
- The user must be [a team member](#add-team-member-to-team) for the competition before he is able to submit his scores
- userId is optional. If left empty, userId is will be gotten from token. UserId must be a member of the team.

requestType determines the operation used to update the user's scores. It has two possible values:
"set" sets the score overwriting any previous while
"update" adds to the previous score or sets the score if there are none yet
```
POST api/competition/team/member/score/add/sum
Authorization: required
Content-Type: application/json
{
  competitionName: string,
  teamName: string,
  score: number,
  userId: number // optional
  requestType: set || update, optional
  bullsEyeCount: number
}
```
Returns [TeamMemberScore](#teammemberscore) if submission was successful.
### isMember 
```
GET api/competition/team/member/isMember
Authorization: required
Content-Type: application/json
{
  "teamName": string,
  "competitionName": string
}
```
returns true if the team is in the competition and the user is part of it

# Image
### upload image
```
POST api/file/upload/
Authorization: required
Content-Type: multipart/form-data
```
Requires competitionId field and file field for the image. Currently only accepts one image at a time.

### download image
```
POST api/file/download/
Authorization: required
Content-Type: application/json
{
  "userId": number,
  "competitiondId": string,
  "teamName": string,
  "fileName": string || null
}
```
Returns files in multipart/form-data format with the image name as the name and the image bytes as the value.
If filename is null, all images associated with the TeamMemberId will be returned.

### delete image
```
POST api/file/delete/
Authorization: required,
Content-Type: application/json
{
  "userId": number,
  "competitiondId": string,
  "teamName": string,
  "fileName": string
}
```
Deletes a file by the given id. The fileName must be provided.

# Types 
## CompetitionResponse
``` 
{
  "competitionId": string,
  "displayName": string,
  "competitionType": string,
  "creationDate": number,
  "startDate": number,
  "endDate": number,
  "teams": CompetitionTeamResponse[]
}
```
Note: used to be called competitionResults

### CompetitionTeamResponse
``` 
{
  "teamName": string,
  "teamDisplayName": string,
  "totalScore" : number,
  "scores": TeamMemberScoreResponse[]
}
```
Note: used to be called competitionResults.team

### TeamMemberScoreResponse
``` 
{
  "bullsEyeCount": number,
  "sum": number,
  "userId": number,
  "competitionId": string,
  "teamName": string,
  "scorePerShot": string,
  "creationDate": string
}
```  
Note: used to be called competitionResults.team.scores

### TeamMemberScore
```
{
  "userId": number,
  "competitionId": string,
  "teamName": string,
  "sum": number,
  "bullsEyeCount": number,
  "scorePerShot": string,
  "creationDate": string
}
```
### LoginResponse
``` 
{
  user: {
    username: string,
    legalName: string,
    email: string,
    userId: number,
    roles: string[],
    creationDate: string //"2024-03-02",
    club: null | string
  },
  token: string 
} 
``` 
### Page
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
## Competition
Mm. onnistunut kilpailun luominen palauttaa tälläisen.
```
{
    "competitionId": string,
    "displayName": string,
    "type": "rifle" || "pistol"
    "startDate": number,
    "endDate": number,
    "creationDate": string
}
```
## Club
Mm. onnistunut seuran luominen palauttaa tälläisen.
```
{
  "name": string, // @id
  "nameNonId": string,
  "creationDate": number,
  "idCreator": number
}
```

## TeamMember
```
{
  userId: number,
  competitionId: string,
  teamName: string
}
```

## Team
```
{
  teamName: string,
  teamDisplayName: string,
  competitionId: string,
  teamMembers: teamMember[]
}
```
## --- unfinished ---
check source 



```
src\main\java\com\omas\webapp\table

src\main\java\com\omas\webapp\controller

```
