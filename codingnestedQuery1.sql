-- Active: 1717407623731@@127.0.0.1@3306@Metro_train
-- Ramdayal

/*QUESTION 1
Write a query to display all the train details that belong to the ‘East-West line’. Display the records in ascending order based on the updated_time.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
id, route_id, position, updated_time, forward */
/*OUERY:*/
SELECT metro_train.id, metro_train.route_id, metro_train.position, metro_train.updated_time, metro_train.forward
FROM metro_train
JOIN route ON metro_train.route_id = route.id
WHERE route.route_name = 'East-West line'
ORDER BY metro_train.updated_time ASC;

/*QUESTION 2
Write a query to display the station details which belong to the route 'Downtown line'. Display the records in ascending order based on station_name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
id, name, locality, is_interchange */
/*QUERY:*/
SELECT station.id, station.name, station.locality, station.is_interchange
FROM station
JOIN station_route ON station.id = station_route.station_id
JOIN route ON station_route.route_id = route.id
WHERE route.route_name = 'Downtown line'
ORDER BY station.name ASC;

/*QUESTION 3
 Write a query to display person name and contact number of all persons who traveled on 2017-12-23.
 Display the records in ascending order based on the person's name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
person_name, contact_number*/
/*QUERY:*/
SELECT travel_card.person_name, travel_card.contact_number
FROM travel_card
JOIN travel_payment ON travel_card.id = travel_payment.travel_card
WHERE DATE(travel_payment.entry_time) = '2017-12-23' OR DATE(travel_payment.exit_time) = '2017-12-23'
ORDER BY travel_card.person_name ASC;

/*QUESTION 4
Write a query to display all the train details scheduled on '2017-12-21'.
Display the records in ascending order based on position.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
id, route_id, position, updated_time, forward */
/*QUERY:*/
SELECT metro_train.id, metro_train.route_id, metro_train.position, metro_train.updated_time, metro_train.forward
FROM metro_train
JOIN train_schedule ON metro_train.id = train_schedule.metro_train_id
WHERE DATE(train_schedule.schedule_time) = '2017-12-21'
ORDER BY metro_train.position ASC;

/*QUESTION 5
Write a query to display the metro train id, position, and updated time of all the trains having deviation. 
Display the records in ascending order based on updated time.

Input Format
The input tables are populated in the backend. 
Output Format
Follow the below output header for the query to be considered.
id, position, updated_time */
/*QUERY*/
SELECT metro_train.id, metro_train.position, metro_train.updated_time
FROM metro_train
JOIN train_arrival_time ON metro_train.id = train_arrival_time.metro_train_id
WHERE train_arrival_time.deviation <> 0
ORDER BY metro_train.updated_time ASC;

