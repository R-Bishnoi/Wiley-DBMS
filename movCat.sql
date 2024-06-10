use MovieCatalogue;
INSERT INTO Director (DirectorID, FIRSTNAME, LASTNAME, BirthDate) 
VALUES(1, 'Ivan', 'Reitman', '1946-10-27');

INSERT INTO Director (DirectorID, FIRSTNAME, LASTNAME, BirthDate) 
VALUES(2, 'Ted', 'Kotcheff', NULL);

SELECT * FROM Level;

INSERT INTO Rating (RatingID, RatingName) 
VALUES(1, 'G');
INSERT INTO Rating (RatingID, RatingName) 
VALUES(2, 'PG');
INSERT INTO Rating (RatingID, RatingName) 
VALUES(3, 'PG-13');
INSERT INTO Rating (RatingID, RatingName) 
VALUES(4, 'R');

INSERT INTO Genre (GenreID, GenreName) 
VALUES(1, 'Action');
INSERT INTO Genre (GenreID, GenreName) 
VALUES(2, 'Comedy');
INSERT INTO Genre (GenreID, GenreName) 
VALUES(3, 'Drama');
INSERT INTO Genre (GenreID, GenreName) 
VALUES(4, 'Horror');

INSERT INTO Movie (MovieID, GenreID, DirectorID, RatingID, Title, ReleaseDate) 
VALUES(1, 1, 2, 4, 'Rambo:First Blood', '1982-10-22');
INSERT INTO Movie (MovieID, GenreID, DirectorID, RatingID, Title, ReleaseDate) 
VALUES(2, 2, NULL, 4, 'Planes, Trains & Automobiles', '1987-11-25');
INSERT INTO Movie (MovieID, GenreID, DirectorID, RatingID, Title, ReleaseDate) 
VALUES(3, 2, 1, 2, 'GhostBusters', NULL);
INSERT INTO Movie (MovieID, GenreID, DirectorID, RatingID, Title, ReleaseDate) 
VALUES(4, 2, NULL, 2, 'The Great Outdoors', '1988-06-17');

INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(1, 5, 1,'John Rambo');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(2, 4, 2,'Neil Page');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(3, 3, 2,'Del Griffith');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(4, 1, 3,'Dr. Peter Venkman');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(5, 2, 3,'Dr. Raymond Stanz');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(6, 2, 4,'Roman Craig');
INSERT INTO CastMembers (CastMemberID, ActorID, MovieID, Role) 
VALUES(7, 3, 4,'Chet Ripley');

UPDATE Movie SET Title='GhostBusters(1984)', ReleaseDate='1984-06-08' WHERE MovieID=3;

UPDATE Genre SET GenreName='Action/Adventure' WHERE GenreID=1;

Drop the existing foreign key constraint
ALTER TABLE CastMembers DROP FOREIGN KEY CastMembers_ibfk_2;

-- Add the foreign key constraint with ON DELETE CASCADE
ALTER TABLE CastMembers
ADD CONSTRAINT CastMembers_ibfk_2
FOREIGN KEY (MovieID) REFERENCES Movie(MovieID) ON DELETE CASCADE;

/*DELETE FROM Movie WHERE MovieID=1;

ALTER TABLE Actor ADD DateOfDeath DATE;
UPDATE Actor SET BirthDate='1994-03-04' 
WHERE FIRSTNAME='John' AND LASTNAME='Candy';
