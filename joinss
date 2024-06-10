USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.*/
SELECT * FROM ExerciseCategory ec LEFT OUTER JOIN Exercise e ON ec.ExerciseCategoryId = e.ExerciseCategoryId
UNION
SELECT * FROM ExerciseCategory ec RIGHT OUTER JOIN Exercise e ON ec.ExerciseCategoryId = e.ExerciseCategoryId;
/*-- 64 rows
--------------------
    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).*/
SELECT ExerciseCategory.Name, Exercise.Name
FROM ExerciseCategory LEFT JOIN Exercise ON ExerciseCategory.ExerciseCategoryId=Exercise.ExerciseCategoryId
WHERE ExerciseCategory.ParentCategoryId IS NULL;

/*-- 9 rows
--------------------

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.*/
SELECT ec.Name AS ExerciseCategoryName, e.Name AS ExerciseName
FROM ExerciseCategory ec LEFT JOIN Exercise e ON ec.ExerciseCategoryId=e.ExerciseCategoryId
WHERE ec.ParentCategoryId IS NULL;
/*-- 9 rows
--------------------

-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?*/
SELECT Client.FirstName, Client.LastName, Client.BirthDate, Login.EmailAddress
FROM Client 
JOIN Login ON Client.ClientId=Login.ClientId
WHERE Client.BirthDate BETWEEN '1990-01-01' AND '1999-12-31';
/*-- 35 rows
--------------------

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?*/
SELECT Workout.Name, Client.FirstName, Client.LastName
FROM Client
JOIN ClientWorkout ON Client.ClientId=ClientWorkout.ClientId
JOIN Workout ON ClientWorkout.WorkoutId=Workout.WorkoutId
WHERE Client.LastName LIKE 'C%';
/*-- 25 rows
--------------------

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
--------------------

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.*/
SELECT W.Name AS WorkoutName, G.Name AS GoalName
FROM Workout W
JOIN WorkoutGoal WG ON W.WorkoutId=WG.WorkoutId
JOIN Goal G ON WG.GoalId=G.GoalId;

SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client C 
LEFT JOIN Login L ON C.ClientId=L.ClientId;
/*-- 500 rows
--------------------

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.*/
SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client C 
LEFT JOIN Login L ON C.ClientId=L.ClientId
WHERE L.ClientId IS NULL;
/*-- 200 rows
--------------------

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.*/
SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
                FROM Client C
                JOIN Login L
                WHERE C.FirstName='Romeo' AND C.LastName='Seaward'
        )
        THEN 'YES'
        ELSE 'NO'
    END AS HasLogin;
/*-- nope :(
--------------------

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.*/
SELECT ec.Name AS ExerciseCategoryName, p.Name AS ParentCategoryName
FROM ExerciseCategory ec
INNER JOIN ExerciseCategory p ON ec.ExerciseCategoryId=p.ExerciseCategoryId;
/*-- 12 rows
--------------------
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.*/
SELECT ec.Name AS ExerciseCategoryName, p.Name AS ParentCategoryName
FROM ExerciseCategory ec
LEFT OUTER JOIN ExerciseCategory p ON ec.ExerciseCategoryId=p.ExerciseCategoryId;
/*-- 16 rows
--------------------
    
-- Are there Clients who are not signed up for a Workout?*/
SELECT C.FirstName, C.LastName
FROM Client C 
LEFT JOIN ClientWorkout CW ON C.ClientId=CW.ClientId
WHERE CW.ClientId IS NULL;
/*-- 50 rows
--------------------

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.*/
SELECT DISTINCT W.Name AS Workout
FROM Workout W
JOIN WorkoutGoal WG ON W.WorkoutId=WG.WorkoutId
JOIN Goal G ON WG.GoalId=G.GoalId
JOIN  ClientGoal CG ON G.GoalId=CG.GoalId
JOIN Client C ON CG.ClientId=C.ClientId
JOIN Level L ON W.LevelId=L.LevelId
WHERE C.FirstName='Shell' AND C.LastName='Creane' AND L.Name='Beginner';
/*-- 6 rows, 4 unique rows
--------------------

-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
--------------------
   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?*/
SELECT DISTINCT W.Name AS WorkoutName, E.Name AS ExerciseName
FROM Workout W
JOIN WorkoutDay WD ON W.WorkoutId=WD.WorkoutId
JOIN WorkoutDayExerciseInstance WDEI ON WD.WorkoutDayId=WDEI.WorkoutDayId
JOIN ExerciseInstance EI ON WDEI.ExerciseInstanceId=EI.ExerciseInstanceId
JOIN Exercise E ON EI.ExerciseId=E.ExerciseId;

SELECT E.Name AS ExerciseName, EIUV.Value, U.Name AS UnitName
FROM Exercise E 
JOIN ExerciseInstance EI ON E.ExerciseId=EI.ExerciseId
JOIN ExerciseInstanceUnitValue EIUV ON EI.ExerciseInstanceId=EIUV.ExerciseInstanceId
JOIN Unit U ON EIUV.UnitId=U.UnitId
WHERE E.Name='plank';
/*-- 4 rows, 1 Unit, and 4 distinct Values
--------------------*/
