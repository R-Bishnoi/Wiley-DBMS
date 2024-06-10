--Ramdayal
--Metro_train
CREATE DATABASE Metro_train;

CREATE TABLE route
    (id INT(11) NOT NULL PRIMARY KEY, 
    route_name VARCHAR(255));

CREATE TABLE station
    (id INT(11) NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    locality VARCHAR(100),
    is_interchange TINYINT(1));

CREATE TABLE travel_card
    (id INT(11) NOT NULL PRIMARY KEY,
    person_name VARCHAR(100),
    contact_number VARCHAR(100),
    balance DOUBLE);

CREATE TABLE metro_train
    (id INT(11) NOT NULL PRIMARY KEY,
    route_id INT(11) NOT NULL,
    position INT(11) NOT NULL,
    updated_time DATETIME,
    forward TINYINT(1),
    FOREIGN KEY (route_id) REFERENCES route(id));

CREATE TABLE station_route
    (id INT(11) NOT NULL PRIMARY KEY,
    station_id INT NOT NULL,
    route_id INT NOT NULL,
    position INT(11),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (route_id) REFERENCES route(id));

CREATE TABLE train_schedule
    (id INT(11) NOT NULL PRIMARY KEY,
    metro_train_id INT(11) NOT NULL,
    station_id INT(11) NOT NULL,
    schedule_time DATETIME,
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id));

CREATE TABLE train_arrival_time
    (id INT(11) NOT NULL PRIMARY KEY,
    metro_train_id INT(11) NOT NULL,
    station_id INT(11) NOT NULL,
    train_schedule_id INT(11) NOT NULL,
    actual_time DATETIME,
    deviation INt(11),
    FOREIGN KEY (metro_train_id) REFERENCES metro_train(id),
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (train_schedule_id) REFERENCES train_schedule(id));

CREATE TABLE travel_payment
    (id INT(11) NOT NULL PRIMARY KEY,
    travel_card INT(11) NOT NULL,
    entry_station_id INT(11) NOT NULL,
    entry_time DATETIME,
    exit_station_id INT(11) NOT NULL,
    exit_time DATETIME,
    amount DOUBLE,
    FOREIGN KEY (travel_card) REFERENCES travel_card(id),
    FOREIGN KEY (entry_station_id) REFERENCES station(id),
    FOREIGN KEY (exit_station_id) REFERENCES station(id));

INSERT INTO route (id, route_name) VALUES
(1, 'North East line'),
(2, 'Circle line'),
(3, 'East-West line');

INSERT INTO station (id, name, locality, is_interchange) VALUES
(1, 'BUONA VISTA MRT STATION', '150 NORTH BUONA VISTA ROAD SINGAPORE 139350', 0),
(2, 'PROMENADE MRT STATION', '2 TEMASEK AVENUE SINGAPORE 039193', 0);

INSERT INTO travel_card (id, person_name, contact_number, balance) VALUES
(1, 'ALEX', '+65 95227525', 35.21),
(2, 'KENNY', '+65 85227415', 28.15),
(3, 'MICHAEL', '+65 62582155', 52.29),
(4, 'GERARD EE', '+65 87892541', 20),
(5, 'KAM NING', '+65 78245225', 49.25),
(6, 'AARON LEE', '+65 92588226', 43.25);

INSERT INTO metro_train (id, route_id, position, updated_time, forward) 
VALUES (1, 2, 1, '2017-12-21 09:00:00', 1);

INSERT INTO station_route (id, station_id, route_id, position) 
VALUES (1, 1, 2, 1), (2, 2, 2, 2);

INSERT INTO train_schedule (id, metro_train_id, station_id, schedule_time) VALUES
(1, 1, 1, '2017-12-21 09:30:15'),
(2, 1, 2, '2017-12-21 09:43:15');

INSERT INTO train_arrival_time (id, metro_train_id, station_id, train_schedule_id, actual_time, deviation) VALUES
(1, 1, 1, 1, '2017-12-21 09:32:00', 2),
(2, 1, 2, 2, '2017-12-21 09:45:00', 2);

INSERT INTO travel_payment (id, travel_card, entry_station_id, entry_time, exit_station_id, exit_time, amount) VALUES
(1, 5, 1, '2017-12-21 09:30:15', 2, '2017-12-21 09:43:15', 49.25),
(2, 6, 1, '2017-12-21 09:30:15', 2, '2017-12-21 09:43:15', 43.25),
(3, 1, 1, '2017-12-21 09:30:15', 2, '2017-12-21 09:43:15', 35.21),
(4, 6, 1, '2017-12-21 09:30:15', 2, '2017-12-21 09:43:15', 43.25);

