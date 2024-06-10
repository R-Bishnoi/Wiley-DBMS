/*Ramdayal*/

USE PersonalTrainer;
SELECT * FROM Exercise;
SELECT * FROM Client;
SELECT * FROM Client WHERE City='Metairie';
SELECT * FROM Client WHERE ClientId='818u7faf-7b4b-48a2-bf12-7a26c92de20c';
SELECT COUNT(*) FROM Goal;
SELECT Name, LevelId FROM Workout;
SELECT Name, LevelId, Notes FROM Workout WHERE LevelId=2;
SELECT FirstName, LastName, City FROM Client WHERE City='Matairie' OR City='Kenner' OR City='Gretna';
SELECT FirstName, LastName, BirthDate FROM Client WHERE BirthDate >='1980-01-01' AND BirthDate <='1989-12-31';
SELECT FirstName, LastName, BirthDate FROM Client WHERE BirthDate BETWEEN '1980-01-01' AND '1989-12-31';
SELECT * FROM Login WHERE EmailAddress LIKE '%.gov';
SELECT * FROM Login WHERE EmailAddress NOT LIKE '%.com';
SELECT FirstName, LastName FROM Client WHERE BirthDate IS NULL;
SELECT Name FROM ExerciseCategory WHERE ParentCategoryId IS NOT NULL;
SELECT Name, Notes FROM Workout WHERE LevelId=3 AND Notes LIKE '%you%';
SELECT FirstName, LastName, City FROM Client WHERE (LastName LIKE 'L%' OR LastName LIKE 'M%' OR LastName LIKE 'N%') AND City='LaPlace';
SELECT InvoiceId, Description, Price, Quantity, ServiceDate, (Price * Quantity) AS Line_Item_Total  FROM InvoiceLineItem;
SELECT ClientId FROM Client WHERE FirstName='Estrella' AND LastName='Bazely';
SELECT EmailAddress FROM Login WHERE ClientId='87976c42-9226-4bc6-8b32-23a8cd7869a5';
SELECT WorkoutId FROM Workout WHERE Name='This is Parkour';
SELECT GoalId FROM WorkoutGoal WHERE WorkoutId=12;
SELECT Name FROM Goal WHERE GoalId=3 OR GoalId=8 OR GoalId=15;
