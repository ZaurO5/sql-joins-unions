CREATE TABLE Movies (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    ReleaseDate DATE,
    IMDB FLOAT
);
CREATE TABLE Actors (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Surname VARCHAR(255)
);
CREATE TABLE Genres (
    Id INT PRIMARY KEY,
    Name VARCHAR(255)
);
CREATE TABLE Movies_Actors (
    MovieId INT,
    ActorId INT,
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (ActorId) REFERENCES Actors(Id)
);
CREATE TABLE Movies_Genres (
    MovieId INT,
    GenreId INT,
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id)
);
SELECT Actors.Name, Actors.Surname, COUNT(Movies_Actors.MovieId) AS RoleCount
FROM Actors JOIN Movies_Actors ON Actors.Id = Movies_Actors.ActorId

GROUP BY Actors.Id, Actors.Name, Actors.Surname
ORDER BY RoleCount DESC;

SELECT Genres.Name, COUNT(Movies_Genres.MovieId) AS MovieCount
FROM Genres JOIN Movies_Genres ON Genres.Id = Movies_Genres.GenreId

GROUP BY Genres.Id, Genres.Name
ORDER BY MovieCount DESC;

SELECT Name, ReleaseDate
FROM Movies
WHERE ReleaseDate > '2023-09-02'
ORDER BY ReleaseDate;

SELECT AVG(IMDB) AS AverageIMDB
FROM Movies
WHERE ReleaseDate >= '2019-08-04';

SELECT Actors.Name, Actors.Surname, COUNT(Movies_Actors.MovieId) AS MovieCount
FROM Actors JOIN Movies_Actors ON Actors.Id = Movies_Actors.ActorId

GROUP BY Actors.Id, Actors.Name, Actors.Surname
HAVING COUNT(Movies_Actors.MovieId) > 1;
