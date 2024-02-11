# omas-backend - how to get started with dev
## 1st Setup PostgreSQL database
Install  and setup the lastest version of [PostgreSQL](https://www.postgresql.org/download/).  
Go with the defaults when installing postgres. No additional dependencies or software are needed. 
Next create a postgres database either in SQL shell (psql) or pgadmin.

To create a database in SQL shell, use the follwing following: 
```
create database omas; 
```
To check that omas db was created type: \l


## 2nd create env.properties 
Create env.properties file in the root of the project 

env.properties should contain the following:
```
DB-URL=jdbc:postgresql://localhost:5432/omas
DB-USERNAME=postgres
DB-PASSWORD=yourPostgresPassword
SECRET=48794134879942idontlikedogs1323572342328789
```
## 3rd run 
Run the main found in <ins>src/main/java/com/omas/webapp/WebappApplication.java</ins>