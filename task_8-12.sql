DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;
USE human_friends;

-- DDL операции

CREATE TABLE IF NOT EXISTS animal_type (
	id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS animals (
	id SERIAL PRIMARY KEY,
	animal_type_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(100),
    description VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (animal_type_id) REFERENCES animal_type(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS commands (
	id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS nursery (
	id SERIAL PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(100),
    birth_date DATE,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS animal_commands (
	id SERIAL PRIMARY KEY,
	nursery_animal_id BIGINT UNSIGNED NOT NULL,
	command_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (nursery_animal_id) REFERENCES nursery(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (command_id) REFERENCES commands(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- DML операции

INSERT INTO animal_type (name)
VALUES 
	('pets'),
	('pack animals')
;

INSERT INTO animals (animal_type_id, name, description)
VALUES 
	(1, 'Dog', 'All dogs'),
	(1, 'Cat', 'All cats'),
	(1, 'Hamster', 'All humsters'),
	(2, 'Horse', 'All horses'),
	(2, 'Camel', 'All camels'),
	(2, 'Donkey', 'All donkeys')
;

INSERT INTO commands (name, description)
VALUES
	('Дай лапу', 'Даёт лапу'),
	('Мурчи', 'Мурчит'),
	('Беги', 'Бежит'),
	('В галоп', 'Быстро скачет'),
	('Присядь', 'Опускается на колени'),
	('Не тупи', 'Идёт вперёд')
;

INSERT INTO nursery (animal_id, name, birth_date)
VALUES
	(1, 'Дружок', '2020-12-03'),
	(2, 'Барсик', '2018-05-13'),
	(3, 'Пушок', '2022-01-25'),
	(4, 'Быстрый', '2017-06-23'),
	(5, 'Стойкий', '2019-09-08'),
	(6, 'Весельчак', '2021-03-15')
;

INSERT INTO animal_commands (nursery_animal_id, command_id)
VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 3),
	(4, 4),
	(5, 5),
	(6, 6)
;

DELETE FROM animals 
WHERE name = 'Camel';

-- DDL операция для задания 11-12

CREATE TABLE young_animals 
AS (SELECT animal_id, name, birth_date, TIMESTAMPDIFF(MONTH, birth_date, NOW()) AS age
	FROM nursery
	WHERE TIMESTAMPDIFF(MONTH, birth_date, NOW()) BETWEEN 12 AND 36)
;

CREATE TABLE all_tables
AS (SELECT 
			ant.name AS animal_type_name, 
			a.animal_type_id AS animal_type_id, 
			a.name AS animal_name, 
			a.description AS animal_description, 
			c.name AS commands_name, 
			c.description AS commands_description, 
			n.animal_id AS nursery_animal_id, 
			n.name AS nursery_name, 
			n.birth_date AS nursery_birth_date, 
			ac.nursery_animal_id AS animal_command_nursery_animal_id, 
			ac.command_id AS animal_command_command_id
	FROM animal_type ant, animals a, commands c, nursery n, animal_commands ac)
;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	