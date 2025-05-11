# README

This project integrates an API endpoint to load data and find details of car models discontinued for a given year.

`https://vpic.nhtsa.dot.gov/api/` API is used for this project.

The project has two endpoints -
1. `/load_data` to load data initially for all the years and cache the result.
2. `/discontinued_vehicles/:year` to find discontinued vehicles for a given year

To run the project -
* Clone and download the repo
* Run `bundle install` to install dependencies
* Run `rails dev:cache` (To enable caching in dev mode)
* Run `rails s` to start dev server and visit the endpoints