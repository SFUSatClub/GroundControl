Website is available at http://localhost:8080/
# About  


SFU Sattelite Tracker App is a webapp that enables users to sign up and
create a personalized list of satellites. Users can choose from a range
of categories such as:

* Special-Interest Satellites
* Weather & Earth Resources Satellites
* Communications Satellites
* Navigation Satellites
* Scientific Satellites
* Miscellaneous Satellites

The user  will be able to see the selected satellites on a map using street view once they have selected the satelites they like to view.

# Background  

Each category of satellites contains a list currently tracked by NORAD.

This list is obtained from:
[Celestrak](https://www.celestrak.com/NORAD/elements)

NORAD provides their data in a line separated txt format.
Each satellite is displayed using three lines.  

`NOAA 1 [-]`  
`1 04793U 70106A   17321.26389674 -.00000039  00000-0  41132-4 0  9994`  
`2 04793 101.7843  25.5071 0031568 323.0510  79.0946 12.53982828148349`  

The first line is the name and the second and third lines are [TLE](https://spaceflight.nasa.gov/realdata/sightings/SSapplications/Post/JavaSSOP/SSOP_Help/tle_def.html) records.
These records can be converted to gps coordinates.

# Implementation  

## GPS Data for the frontend  

Conversion from TLE to GPS Coordinates is done at the frontend.
This conversion is done using a javascript library and takes the current unix time as inputs and combines this with the TLE parameters to predict the Coordinates to a certain level of accuracy up to 24 hours.
After 24 hours it is required to get new TLE values to maintain accuracy.

## Users  

Users that have signed up to the app can choose their satellite from a menu of categories or search for the satellite name in a search bar.

## Backend  

On the Backend there is a Rails rake task running that will fetch new data from the NORAD txt files and write these to the database every 24 hours.

# Current development  

* Database tables created and populated with test TLE data.
* Rake task to automate daily updates has been created.
* reading txt files from NORAD and combining the line seperated records in groups of three for each satellite.
* TLE to GPS coordinates libary has been tested and is working.
* Users signup functionality completed.
* Users are able to add/delete satellites from their list.
* Enable Rake task to write to database.

## Current UI designs  

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/14edcc5cce5fd1b8ce26e67241f7a622/image.png "user menu")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/562449322e2d78ce3db6d73f67149823/image.png "User Login")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/a2a47edee1090a8543b1e93b34be94e9/image.png "User Dashboard V1")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/19b5ff64f8a06adf012f750b2f52f69e/image.png "User Dashboard V2")


## Tech Evaluation
The following technology was used for the creation of our website
#Application Backend

Oracle Virtualbox + Vagrant
We virtualize a Web Server using Virtualbox and Vagrant so the whole team have the same ubuntu environment to work with. Orcale virtualbox and vagrant is chosen because we are more familiar with them after the exercises done already.


Nginx + Chef + Unicorn
We use the chef script to set up a Nginx Server and listen on the Unicorn socket. This combination of setup is chosen to be more compatiable with the overall rails web framework and initial set up has already been done within the exercises.


Rails
We use Rails as a Web Framework to do rapid web development. Rails is chosen due to the large amount of existing gems to work with and the fact that several of our members is already familiar with development in rails.

Scheduling by Whenever gem + CRON
We use whenever gem to schedule in order to fetch all TLE from Celestrak Website to databases at 12:00 am everyday. Whenever gem and CRON is chosen by the already available online website and forums to help with the process of setting up.

Security / bcrypt
We use bcrypt to secure our user password by hashing. Bcrypt is the most popular gem to set up security in Rails and there was no reason not to use it.


PostgreSQL Datebase
We use PostgreSQL for the creation of database and chose it because it is one of the world’s most advanced open source database

Amazon database for testing
Initially Amazon databse is used as database to test out basic feature without postgrSQL setted up. It is replaced due to the constant fetching of TLE data slowing the database down.

#Application Frontend

WebGL Earth / OpenStreetMap/ Google Map API
We use WebGL Earth, OpenStreetMap, and Google Map to show the users the position of the satellites on the map. The reason why these are used because there are no other mapping system that we can think of.

Bootstrap
We use Bootstrap to design the UI and provide a suitable view to both mobile and desktop browser. Bootstrap is chosen because it is relatively easy to set up and get started.

Jquery
We use Jquery to update the latitude and longitude of the satellites and pin it into the map. We chose Jquery because we have already done the tutorial for jquery for the exercise.

Slim Gem
We use Slim to shorten the normal HTML format. It is not necessary to use slim as some of our members do not use it but some people simply perfer to use it.

Puma Application Server
We use Puma server for development process of the rails web application. It is fast and easy to run and set up is all covered by exercise.

## Challenges
There was a couple of challenges with the implmentation of our websites. One of the major challenge was the conversion of TLE text data into longitude and latitude to be plotted on the map. Although Api is provided for the conversion of TLE to Longitude and Latitude, there still requires some experimenting before realizing the need to download a js library to write TLE and then another javascript to read the TLE. The other major challenge comes from setting up production mode using unicorn and nginx and rails. Tutorial is provided for basic set up that can be used on a linux machine, but on a windows machine unicorn port is blocked and cannot be used. Many iterations of the code is made in adjusting unicorn before it can be used on a windows machine. The last major challenge comes from the merging the git lab repository and doing quailty control and debugging with all the codes and devleopment that are comming in. Sometimes some code has to be refactor before it can be used.

## Roles
Henry
* Quailty control/debugging
* Git Merge control
* User login system
- password security
- base rails app set up
- set up bootstrap,slim library
- display lat and lon on the table
- set up whenever gem for scheduling
Nick
* Setting up vagrant
- set up nignx server and communication nignx to rails app by unicorn socket
- debug everyone's backend setup
- poster design
- project requirement
* Website designs on html, css, bootstrap
Ching
* Website designs on html, css, bootstrap, logo
- home / manual page
* tester for windows website prouction mode
* Writing Readme/ Project overview
Darren
- create the map controller
* Displaying satellites on maps with given longitude and latitude
- about page
- testing on everything
- google font
Arvin
- set up whenever gem for scheduling
- find all the source: TLE to lon and lat library, map library
- insert satellite data into the database
* Communication with satellite club about website layout and functionality
* Displaying satellites on maps with given longitude and latitude
Dimtri
- build a Amazon database for testing
- google map API



# Further development  
* Make proper connections between user model and satellite model so that user's list can be recorded.
* Mapping library should read from database and display markers on the map of the current locations.
* TLE provides more parameters than just coordinates. Read these out and display as tooltip for the markers or in a separate dashboard on the side as the user hovers/selects their satellite.
* creating 3d map of the globe to display the satellite's locations
