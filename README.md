## User Stories

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of bookmarks
```
```
As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager
```
```
As a user
So I can store bookmark data for later retrieval
I want to add a bookmark to Bookmark Manager
```

## Domain Model 

![Bookmark Manager domain model](./public/domain_model.png)

## Setting up the development/test Databases 

# Development 
``` connect to psql; ``` 
create the database 
``` CREATE DATABASE bookmark_manager; ``` 
connect to DB 
``` \c bookmark_manager; ``` 
create table using queries stored inside ```db/migrations/01_create_bookmarks_table.sql```

# Test
Repeat above process but add _test to the DB upon creation 





