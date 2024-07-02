CREATE DATABASE DemoApp;
USE DemoApp;

CREATE TABLE People (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(50),
    Surname VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    BirthDate DATE,
    Gender CHAR(1),
    HasCitizenship DECIMAL
);

CREATE TABLE Countries (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(100),
    Area DECIMAL(10, 2)
);

CREATE TABLE Cities (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Name VARCHAR(100),
    Area DECIMAL(10, 2),
    CountryId INT,
    FOREIGN KEY (CountryId) REFERENCES Countries(Id)
);

ALTER TABLE People ADD CountryId INT;
ALTER TABLE People ADD CityId INT;
ALTER TABLE People ADD FOREIGN KEY (CityId) REFERENCES Cities(Id);
ALTER TABLE People ADD FOREIGN KEY (CountryId) REFERENCES Countries(Id);

CREATE VIEW PersonCountryCity AS
SELECT 
    p.Id, p.Name, p.Surname, p.PhoneNumber, p.Email, p.BirthDate, p.Gender, p.HasCitizenship,
    c.Name AS CountryName, ct.Name AS CityName
FROM 
    People p
JOIN 
    Countries c ON p.CountryId = c.Id
JOIN 
    Cities ct ON p.CityId = ct.Id;

SELECT * FROM Countries ORDER BY Area ASC;

SELECT * FROM Cities ORDER BY Name DESC;

SELECT COUNT(*) AS NumberOfLargeCountries FROM Countries WHERE Area > 20000;

SELECT MAX(Area) AS LargestArea FROM Countries WHERE Name LIKE 'İ%';

SELECT Name FROM Countries
UNION
SELECT Name FROM Cities;

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM People p
JOIN Cities ct ON p.CityId = ct.Id
GROUP BY ct.Name;

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM People p
JOIN Cities ct ON p.CityId = ct.Id
GROUP BY ct.Name
HAVING COUNT(p.Id) > 50000;


