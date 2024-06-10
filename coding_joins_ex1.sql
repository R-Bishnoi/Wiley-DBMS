-- ramdayal
/*QUESTION 1
Write a query to display the names and contact numbers of persons
 whose destination station is on the route 'North East line' with a payment of more than 25.
Display the records in ascending order based on person's name.

Input Format

The input tables are populated in the backend

Output Format
Follow the below output header for the query to be considered..
person_name, contact_number */

SELECT DISTINCT tc.person_name, tc.contact_number
FROM travel_payment tp
JOIN travel_card tc ON tp.travel_card = tc.id
JOIN station s ON tp.exit_station_id = s.id
JOIN station_route sr ON s.id = sr.station_id
JOIN route r ON sr.route_id = r.id
WHERE r.route_name = 'North East line'
AND tp.amount > 25
ORDER BY tc.person_name;


/*QUESTION 2
Write a query to display the name and locality of the stations
with the metro trains scheduled to arrive on '2017-12-21' along
 the route 'Circle line'. Display the records in ascending order based on the station name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
name, locality */

SELECT s.name, s.locality
FROM train_schedule ts
JOIN metro_train mt ON ts.metro_train_id = mt.id
JOIN station s ON ts.station_id = s.id
JOIN station_route sr ON s.id = sr.station_id
JOIN route r ON sr.route_id = r.id
WHERE r.route_name = 'Circle line'
AND DATE(ts.schedule_time) = '2017-12-21'
ORDER BY s.name;


/*QUESTION 3
Write a query to display a person's name, contact number, and balance details,
who have a minimum balance on their travel_card. If there are multiple records,
display the record in descending order by person name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance */

SELECT person_name, contact_number, balance
FROM travel_card
WHERE balance = (SELECT MIN(balance) FROM travel_card)
ORDER BY person_name DESC;


/*QUESTION 4
Write a query to display the person's name, contact number, balance, entry_time, and exit_time of all the details,
who has the second highest balance on their travel cards. Display the records in ascending order based on their person_name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance, entry_time, exit_time */

SELECT person_name, contact_number, balance, tp.entry_time, tp.exit_time
FROM travel_card tc
JOIN travel_payment tp ON tc.id = tp.travel_card
WHERE balance = (
    SELECT DISTINCT balance
    FROM travel_card
    ORDER BY balance DESC
    LIMIT 1 OFFSET 1
)
ORDER BY person_name ASC;


/*QUESTION 5
Write a query to display the person's name, contact number, and balance of all the travelers, who traveled for a maximum number of times.
If there are multiple records then display the records in descending order by person name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
person_name, contact_number, balance */

SELECT tc.person_name, tc.contact_number, tc.balance
FROM travel_card tc
JOIN travel_payment tp ON tc.id = tp.travel_card
GROUP BY tc.id
HAVING COUNT(tp.id) = (
    SELECT MAX(travel_count) FROM (
        SELECT COUNT(tp.id) AS travel_count
        FROM travel_payment tp
        GROUP BY tp.travel_card
    ) AS travel_counts
)
ORDER BY tc.person_name DESC;
