-- Ramdayal
/*QUESTION 1
Create a trigger named 'trigger_slab_insert' that is triggered whenever a record is added to the slab table.
This trigger will insert the from_unit, to_unit, rate and action into the table 'slab_log_history' after the insertion of records into the slab table.
The action name in the affected log table is 'slab_log_history' is "Insert_Slab".

In Solution, write a trigger alone with the given specifications.
 The creation of slab_log_history table and INSERTing a new row will be taken care in the back end.
Hints:
Trigger name: trigger_slab_insert
Table name: slab_log_history
Field names: from_unit, to_unit, rate, action
Action: 'Insert_Slab'

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the trigger is successful.
from_unit, to_unit, rate, action */

DELIMITER $$

CREATE TRIGGER trigger_slab_insert
AFTER INSERT ON slab
FOR EACH ROW
BEGIN
    INSERT INTO slab_log_history (from_unit, to_unit, rate, action)
    VALUES (NEW.from_unit, NEW.to_unit, NEW.rate, 'Insert_Slab');
END $$

DELIMITER ;


/*QUESTION 2
Create a trigger named 'trigger_electricity_connection_type_insert' that is
triggered whenever an electricity connection type record is added in the electricity_connection_type table.
This trigger will insert the connection_name and action into the table 'electricity_connection_type_log_history'
after the insertion of records into the electricity_connection_type table.
The action name in the affected log table is 'electricity_connection_type_log_history' is "Insert_Electricity_Connection_Type".

In Solution, write a trigger alone with the given specifications.
The creation of electricity_connection_type_log_history table and INSERTing new row will be taken care in the back end.

Hints:
Trigger name: trigger_electricity_connection_type_insert
Table name: electricity_connection_type_log_history
Field names: connection_name, action
Action: 'Insert_Electricity_Connection_Type'

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the trigger is successful.
connection_name, action*/

DELIMITER $$

CREATE TRIGGER trigger_electricity_connection_type_insert
AFTER INSERT ON electricity_connection_type
FOR EACH ROW
BEGIN
    INSERT INTO electricity_connection_type_log_history (connection_name, action)
    VALUES (NEW.connection_name, 'Insert_Electricity_Connection_Type');
END $$

DELIMITER ;


/*QUESTION 3
Create a trigger named 'trigger_building_bf_update' that is triggered whenever the building table is updated.
This trigger will insert the contact_number and action into the table 'building_log_history' before the updation of building details.
The action name in the affected log table building_log_history is 'Before_Update_Building'.

In Solution, write a trigger alone with the given specifications.
The creation of building_log_history table and updating a row will be taken care in the back end.

Hints:
Trigger name: trigger_building_bf_update
Table name: building_log_history
Field names: contact_number, action
Action: 'Before_Update_Building'

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the trigger is successful.
contact_number, action */

DELIMITER $$

CREATE TRIGGER trigger_building_bf_update
BEFORE UPDATE ON building
FOR EACH ROW
BEGIN
    INSERT INTO building_log_history (contact_number, action)
    VALUES (OLD.contact_number, 'Before_Update_Building');
END $$

DELIMITER ;


/*QUESTION 4
Create a trigger named 'trigger_meter_af_update' that is triggered whenever the meter table is updated.
This trigger will insert the meter_number and action into the table 'meter_log_history' after the updation of meter details.
The action name in the affected log table meter_log_history is 'After_Update_Meter'.

In Solution, write a trigger alone with the given specifications.
The creation of meter_log_history table and updating row will be taken care in the back end. end.

Hints:
Trigger name: trigger_meter_af_update
Table name: meter_log_history
Field names: meter_number, action
Action: 'After_Update_Meter'

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the trigger is successful.
travel_card_id, action */

DELIMITER $$

CREATE TRIGGER trigger_meter_af_update
AFTER UPDATE ON meter
FOR EACH ROW
BEGIN
    INSERT INTO meter_log_history (meter_number, action)
    VALUES (NEW.meter_number, 'After_Update_Meter');
END $$

DELIMITER ;

/*QUESTION 5
Create a trigger named 'trigger_building_type_bf_update' that is triggered whenever the building_type table is updated.
This trigger will insert the name and action into the table 'building_update_log_history' before the updation of building type details.
The action name in the affected log table building_update_log_history is 'Before_Update_Building_Type'.

In Solution, write a trigger alone with the given specifications.
The creation of building_update_log_history table and updating row will be taken care in the back end.

Hints:
Trigger name: trigger_building_type_bf_update
Table name: building_update_log_history
Field names: name, action
Action: 'Before_Update_Building_Type'

Input Format
The input tables are populated in the backend. 

Output Format
The output will display the below header if the trigger is successful.
name, action */

DELIMITER $$

CREATE TRIGGER trigger_building_type_bf_update
BEFORE UPDATE ON building_type
FOR EACH ROW
BEGIN
    INSERT INTO building_update_log_history (name, action)
    VALUES (OLD.name, 'Before_Update_Building_Type');
END $$

DELIMITER ;
