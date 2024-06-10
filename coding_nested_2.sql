-- Ramdayal

/*QUESTION 1
Write a query to display all the building details in which the building type is ‘Library’. Display the records in ascending order based on their owner_name.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
id, owner_name, address, building_type_id, contact_number, email_address */
/*QUERY*/
SELECT building.id, building.owner_name, building.address, building.building_type_id, building.contact_number, building.email_address
FROM building
JOIN building_type ON building.building_type_id = building_type.id
WHERE building_type.name = 'Library'
ORDER BY building.owner_name ASC;


/*QUESTION 2
Write a query to display all the contact numbers of the building type 'Police Station'. Display the records in ascending order based on the contact number.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
contact_number */
/*QUERY*/
SELECT building.contact_number
FROM building
JOIN building_type ON building.building_type_id = building_type.id
WHERE building_type.name = 'Police Station'
ORDER BY building.contact_number ASC;


/*QUESTION 3
Write a query to display the building type name of the meter number 'SG824012'.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
name */
/*QUERY*/
SELECT building_type.name
FROM meter
JOIN building ON meter.building_id = building.id
JOIN building_type ON building.building_type_id = building_type.id
WHERE meter.meter_number = 'SG824012';

/*QUESTION 4
Write a query to display the total units and payable amount of the particular meter number 'SG934826'.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
total_units, payable_amount  */
/*QUERY*/
SELECT bill.total_units, bill.payable_amount
FROM bill
JOIN meter ON bill.meter_id = meter.id
WHERE meter.meter_number = 'SG934826';


/*QUESTION 5
Write a query to display the number of buildings that have been charged for a fine amount. Give an alias name as 'building_count'.

Input Format
The input tables are populated in the backend. 

Output Format
Follow the below output header for the query to be considered.
building_count  */
/*QUERY*/
SELECT COUNT(DISTINCT building.id) AS building_count
FROM building
JOIN meter ON building.id = meter.building_id
JOIN bill ON meter.id = bill.meter_id
WHERE bill.fine_amount > 0;
