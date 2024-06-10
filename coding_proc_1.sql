-- Ramdayal
/*QUESTION 1
Create a procedure named 'insertRoute' which has route_name as an input parameter with varchar(255) as its datatype. This procedure should take the count of the existing table records(route table) and add 1 with that to generate the new route id. The newly generated id along with the route_name should be inserted into the route table.

In Solution, write a procedure alone with the given specifications. The calling of the procedure with the input will be taken care of in the back end.

Hints:
Procedure name: insertRoute
Parameters: route_name(varchar(255))

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the procedure is created successfully.
id, route_name */

CREATE PROCEDURE insertRoute (IN route_name VARCHAR(255))
BEGIN
    DECLARE route_id INT;
    INSERT INTO route (route_name) VALUES (route_name);
    SET route_id = LAST_INSERT_ID();
    SELECT route_id AS id, route_name;
END;
CALL insertRoute('East-West line');

SELECT * FROM route;
/*QUESTION 2
Create a function named 'findRoute' which has the metroTrainId as the input parameter and it should return the route name of the train.

Design Rules:
If there is a route name for a given metro train id then it should return the corresponding route name

In Solution, write a function alone with the given specifications. The calling of the function with the input will be taken care of in the back end.

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the function is created successfully.
route_name*/

CREATE FUNCTION findRoute (metroTrainId INT) RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE route_name VARCHAR(255);
    SELECT route_name INTO route_name FROM metro_train WHERE id = metroTrainId;
    
    RETURN route_name;
END;

SELECT findRoute(4);
SELECT * FROM metro_train;

/*QUESTION 3
Create a function named 'findTheScheduledTime' which has the metroTrainId as the input parameter and it should return the scheduled time of the train.

In Solution, write a function alone with the given specifications. The calling of the function with the input will be taken care of in the back end.

Hints:
Function Name: findTheScheduledTime
Input parameter: metroTrainId (int)


Design Rules:
If there is a metro train id then it should return at the scheduled time of that train

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the function is created successfully.
scheduled_time */

CREATE FUNCTION findTheScheduledTime (metroTrainId INT) RETURNS DATETIME
READS SQL DATA
BEGIN
    DECLARE scheduled_time DATETIME;
    SELECT scheduled_time INTO scheduled_time FROM metro_train WHERE id = metroTrainId;
    
    RETURN scheduled_time;
END;

SELECT findTheScheduledTime(6);

SELECT * FROM metro_train;
/*QUESTION 4
Create a procedure named 'findAmount' which takes 2 input parameters namely, personName varchar(100), entryTime date time, and 1 output parameter namely, amount_out double. This procedure should find the amount for the travel_payment made by the person whose name is passed as an input parameter.

In Solution, write a procedure alone with the given specifications. The calling of the procedure with the input will be taken care of in the back end.

Hints:
Procedure name: findAmount
Parameters: personName(varchar(100)), entryTime(datetime), amount_out(double)

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the procedure is created successfully.
amount */

CREATE PROCEDURE findAmount (IN personName VARCHAR(100), IN entryTime DATETIME, OUT amount_out DOUBLE)
BEGIN
    DECLARE amount DOUBLE;
    SET amount = 100;  
    SET amount_out = amount;
END;
SET @amount_out = 0;
CALL findAmount('ALEX', '2024-06-07 10:00:00', @amount_out);
SET @amount_out;
