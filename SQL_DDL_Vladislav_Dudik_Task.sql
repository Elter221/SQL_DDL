CREATE DATABASE SQL_DDL_Vladislav_Dudik_Task

CREATE SCHEMA climb_club;

CREATE TABLE IF NOT EXISTS climb_club.City
(
	city_id SERIAL PRIMARY KEY,
	city_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS climb_club.Country
(
	country_id SERIAL PRIMARY KEY,
	country_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS climb_club."Address"
(
	address_id SERIAL PRIMARY KEY,
	street_name VARCHAR(50) NOT NULL,
	house_number SMALLINT NOT NULL,
	city_id BIGINT NOT NULL CONSTRAINT FK_city_id REFERENCES climb_club.City(city_id),
	country_id BIGINT NOT NULL CONSTRAINT FK_country_id REFERENCES climb_club.Country(country_id)
);

CREATE TABLE IF NOT EXISTS climb_club.Climber 
(
	climber_id SERIAl PRIMARY KEY,
	climber_first_name VARCHAR(30) NOT NULL,
	climber_last_name VARCHAR(30) NOT NULL,
	gender CHAR(1) NOT NULL CHECK (gender IN('F', 'M')),
	address_id BIGINT NOT NULL CONSTRAINT FK_address_id REFERENCES climb_club."Address"(address_id)
);

CREATE TABLE IF NOT EXISTS climb_club."Group"
(
	group_id SERIAL PRIMARY KEY,
	group_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS climb_club.Join_Group 
(
	joining_id SERIAL PRIMARY KEY,
	climber_id BIGINT NOT NULL CONSTRAINT FK_climber_id REFERENCES climb_club.Climber(climber_id),
	group_id BIGINT NOT NULL CONSTRAINT FK_group_id REFERENCES climb_club."Group"(group_id)
);

CREATE TABLE IF NOT EXISTS climb_club.Venue 
(
	venue_id SERIAL PRIMARY KEY,
	venue_name VARCHAR(20) NOT NULL,
	longtitude VARCHAR(20) NOT NULL,
	latitude VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS climb_club.Mountain
(
	mountain_id SERIAL PRIMARY KEY,
	mountain_name VARCHAR(30) NOT NULL,
	longtitude VARCHAR(20) NOT NULL,
	latitude VARCHAR(20) NOT NULL,
	height SMALLINT NOT NULL CHECK(height > 0),
	country_id BIGINT NOT NULL CONSTRAINT FK__mountain_country_id REFERENCES climb_club.Country(country_id),
	venue_id BIGINT NOT NULL CONSTRAINT FK_venue_id REFERENCES climb_club.Venue(venue_id)
);

CREATE TABLE IF NOT EXISTS climb_club.Climb 
(
	climb_id SERIAL PRIMARY KEY,
	"start_date" DATE NOT NULL CHECK ("start_date">'2000-01-01'),
	"end_date" DATE,
	venue_id BIGINT NOT NULL CONSTRAINT FK_climb_venue_id REFERENCES climb_club.Venue(venue_id),
	mountain_id BIGINT NOT NULL CONSTRAINT FK__mountain_id REFERENCES climb_club.Mountain(mountain_id)
);

ALTER TABLE IF EXISTS climb_club.Climb
ALTER COLUMN "end_date" SET DEFAULT '2000-01-01';

CREATE TABLE IF NOT EXISTS climb_club.Choose_The_Way
(
	travel_id SERIAL PRIMARY KEY,
	climb_id BIGINT NOT NULL CONSTRAINT FK_climb REFERENCES climb_club.Climb(climb_id),
	group_id BIGINT NOT NULL CONSTRAINT FK_group_climbs REFERENCES climb_club."Group"(group_id)
);

INSERT INTO climb_club.Country (country_name)
	VALUES
	('Germany'),
	('Tanzania'),
	('Belarus'),
	('Italy');

INSERT INTO climb_club.City (city_name)
	VALUES
	('Berlin'),
	('Minsk'),
	('Rome'),
	('Grodno');

INSERT INTO climb_club."Address" (street_name, house_number, city_id, country_id)
	VALUES
	('Rathausstraße', 15, 1, 1),
	('Rokosovskogo', 42, 2, 3);

INSERT INTO climb_club.Climber(climber_first_name, climber_last_name, gender, address_id)
	VALUES
	('Vladislav', 'Dudik', 'M', 2),
	('Anna', 'Chelukanova', 'F', 1);

INSERT INTO climb_club."Group"(group_name)
	VALUES
	('Redheads'),
	('Street Gang');

INSERT INTO climb_club.Join_Group(climber_id, group_id)
	VALUES
	(1,2),
	(2,1),
	(1,1);

INSERT INTO climb_club.Venue(venue_name, longtitude, latitude)
	VALUES
	('Marangu gate', '3°17′05''''S', '37°31′19′′E'),
	('Passo Fedaia', '46°45′35′′N', '11°88′90′′E');

INSERT INTO climb_club.Mountain(mountain_name, longtitude, latitude, height, country_id, venue_id)
	VALUES
	('Kilimanjaro', '3°06′74′′S', '37°35′56′′E', 5892, 2, 1),
	('Marmolada', '46°26′05″N', '11°51′03″E', 3343, 4, 2);

INSERT INTO climb_club.Climb("start_date", "end_date", venue_id, mountain_id)
	VALUES
	('2016-06-07', '2016-06-13', 1, 1),
	('2023-01-01', '2023-01-15', 2, 2),
	('2024-05-05', NULL, 1, 1);

INSERT INTO climb_club.Choose_The_Way(climb_id, group_id)
	VALUES
	(3, 1),
	(1, 2);

ALTER TABLE IF EXISTS climb_club.Country
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.City
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club."Address"
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Climber
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club."Group"
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Join_Group
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Venue
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Mountain
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Climb
	ADD record_ts DATE NOT NULL DEFAULT current_date;

ALTER TABLE IF EXISTS climb_club.Choose_The_Way
	ADD record_ts DATE NOT NULL DEFAULT current_date;

SELECT *
FROM climb_club.Country;

SELECT *
FROM climb_club.City;

SELECT *
FROM climb_club."Address";

SELECT *
FROM climb_club.Climber;

SELECT *
FROM climb_club."Group";

SELECT *
FROM climb_club.Join_Group;

SELECT *
FROM climb_club.Venue;

SELECT *
FROM climb_club.Mountain;

SELECT *
FROM climb_club.Climb;

SELECT *
FROM climb_club.Choose_The_Way;

