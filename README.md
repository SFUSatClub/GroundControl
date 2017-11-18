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

The user be able to see the selected satellites on a map.

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

## Current UI designs  

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/14edcc5cce5fd1b8ce26e67241f7a622/image.png "user menu")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/562449322e2d78ce3db6d73f67149823/image.png "User Login")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/a2a47edee1090a8543b1e93b34be94e9/image.png "User Dashboard V1")

![alt text](https://csil-git1.cs.surrey.sfu.ca/mhzhao/CMPT470Project/uploads/19b5ff64f8a06adf012f750b2f52f69e/image.png "User Dashboard V2")

# Further development  

* Enable Rake task to write to database.
* Make proper connections between user model and satellite model so that user's list can be recorded.
* Users should be able to add/delete satellites from their list.
* Mapping library should read from database and display markers on the map of the current locations.
* TLE provides more parameters than just coordinates. Read these out and display as tooltip for the markers or in a separate dashboard
on the side as the user hovers/selects their satellite.
