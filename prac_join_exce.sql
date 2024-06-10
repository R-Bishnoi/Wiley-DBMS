-- Ramdayal
/*Activity 1
Select all columns from ExerciseCategory and Exercise.

The tables should be joined on ExerciseCategoryId.
This query returns all Exercises and their associated ExerciseCategory.

64 rows*/
/*QUERY*/
SELECT *
FROM ExerciseCategory EC
JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId;

/*Activity 2
Select ExerciseCategory.Name and Exercise.
Name where the ExerciseCategory does not have a ParentCategoryId (it is null).

Again, join the tables on their shared key (ExerciseCategoryId).
9 rows*/
/*QUERY*/
SELECT EC.Name AS CategoryName, E.Name AS ExerciseName
FROM ExerciseCategory EC
JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId
WHERE EC.ParentCategoryId IS NULL;

/*Activity 3
The query above is a little confusing. At first glance,
it's hard to tell which Name belongs to ExerciseCategory and which belongs to Exercise.

Rewrite the query using aliases:

Alias ExerciseCategory.Name as 'CategoryName'.
Alias Exercise.Name as 'ExerciseName'.
9 rows*/
/*QUERY*/
SELECT EC.Name AS CategoryName, E.Name AS ExerciseName
FROM ExerciseCategory EC
JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId
WHERE EC.ParentCategoryId IS NULL;

/*Activity 4
Select FirstName, LastName, and BirthDate from Client and EmailAddress
from Login where Client.BirthDate is in the 1990s.

Join the tables by their key relationship.

What is the primary-foreign key relationship?
35 rows*/
/*QUERY*/
SELECT C.FirstName, C.LastName, C.BirthDate, L.EmailAddress
FROM Client C
JOIN Login L ON C.ClientId = L.ClientId
WHERE C.BirthDate BETWEEN '1990-01-01' AND '1999-12-31';

/*Activity 5
Select Workout.Name, Client.FirstName, and Client.LastName
for Clients with LastNames starting with 'C'?

How are Clients and Workouts related?
25 rows*/
/*QUERY*/
SELECT W.Name AS WorkoutName, C.FirstName, C.LastName
FROM Client C
JOIN ClientWorkout CW ON C.ClientId = CW.ClientId
JOIN Workout W ON CW.WorkoutId = W.WorkoutId
WHERE C.LastName LIKE 'C%';

/*Activity 6
Select Names from Workouts and their Goals.

This is a many-to-many relationship with a bridge table.
Use aliases appropriately to avoid ambiguous columns in the result.
78 rows*/
/*QUERY*/
SELECT W.Name AS WorkoutName, G.Name AS GoalName
FROM Workout W
JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId
JOIN Goal G ON WG.GoalId = G.GoalId;

/*Activity 7
Step 1
Select client names and email addresses.

Select FirstName and LastName from Client.
Select ClientId and EmailAddress from Login.
Join the tables, but make Login optional.
500 rows

Step 2
Using the query above as a foundation, select Clients who do not have a Login.

200 rows*/
/*QUERY*/
/*Step 1*/
SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client C
LEFT JOIN Login L ON C.ClientId = L.ClientId;

/*Step 2*/
SELECT C.FirstName, C.LastName, C.ClientId
FROM Client C
LEFT JOIN Login L ON C.ClientId = L.ClientId
WHERE L.ClientId IS NULL;

/*Activity 8
Does the Client, Romeo Seaward, have a Login?

Decide using a single query.
Depending on how this query is set up, it will return 1 row or 0 rows.*/
/*QUERY*/
SELECT C.FirstName, C.LastName, L.EmailAddress
FROM Client C
LEFT JOIN Login L ON C.ClientId = L.ClientId
WHERE C.FirstName = 'Romeo' AND C.LastName = 'Seaward';

/*Activity 9
Select ExerciseCategory.Name and its parent ExerciseCategory's Name.

This requires a self-join.
12 rows*/
/*QUERY*/
SELECT EC.Name AS CategoryName, ParentEC.Name AS ParentCategoryName
FROM ExerciseCategory EC
LEFT JOIN ExerciseCategory ParentEC ON EC.ParentCategoryId = ParentEC.ExerciseCategoryId;

/*Activity 10
Rewrite the query above so that every ExerciseCategory.Name is included, even if it doesn't have a parent.

16 rows*/
/*QUERY*/
SELECT EC.Name AS CategoryName, ParentEC.Name AS ParentCategoryName
FROM ExerciseCategory EC
LEFT JOIN ExerciseCategory ParentEC ON EC.ParentCategoryId = ParentEC.ExerciseCategoryId;

/*Activity 11
Are there Clients who are not signed up for a Workout?

50 rows*/
/*QUERY*/
SELECT C.ClientId, C.FirstName, C.LastName
FROM Client C
LEFT JOIN ClientWorkout CW ON C.ClientId = CW.ClientId
WHERE CW.WorkoutId IS NULL;

/*Activity 12
Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?

Goals are associated to Clients through ClientGoal.
Goals are associated to Workouts through WorkoutGoal.
6 rows, 4 unique rows*/
/*QUERY*/
SELECT DISTINCT W.Name AS WorkoutName
FROM Client C
JOIN ClientGoal CG ON C.ClientId = CG.ClientId
JOIN Goal G ON CG.GoalId = G.GoalId
JOIN WorkoutGoal WG ON G.GoalId = WG.GoalId
JOIN Workout W ON WG.WorkoutId = W.WorkoutId
JOIN Level L ON W.LevelId = L.LevelId
WHERE C.FirstName = 'Shell' AND C.LastName = 'Creane' AND L.Name = 'Beginner';

/*Activity 13
Select all Workouts having the goal "Core Strength" OR having no goal specified.
If you filter on Goal.Name in a WHERE clause, too few rows will be returned. Why?

26 rows*/
/*QUERY*/
SELECT W.Name AS WorkoutName
FROM Workout W
LEFT JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId
LEFT JOIN Goal G ON WG.GoalId = G.GoalId
WHERE G.Name = 'Core Strength' OR WG.GoalId IS NULL;

/*Activity 14
The relationship between Workouts and Exercises is... complicated:

Workout links to WorkoutDay (one day in a Workout routine) which links to WorkoutDayExerciseInstance 
(Exercises can be repeated in a day so a bridge table is required) which links to ExerciseInstance 
(Exercises can be done with different weights, repetitions, laps, etc...) which finally links to Exercise.
Select Workout.Name and Exercise.Name for related Workouts and Exercises.

744 rows*/
/*QUERY*/
SELECT W.Name AS WorkoutName, E.Name AS ExerciseName
FROM Workout W
JOIN WorkoutDay WD ON W.WorkoutId = WD.WorkoutId
JOIN WorkoutDayExerciseInstance WDEI ON WD.WorkoutDayId = WDEI.WorkoutDayId
JOIN ExerciseInstance EI ON WDEI.ExerciseInstanceId = EI.ExerciseInstanceId
JOIN Exercise E ON EI.ExerciseId = E.ExerciseId;

/*Activity 15
An ExerciseInstance is configured with ExerciseInstanceUnitValue.

It contains a Value and UnitId that links to Unit.

Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name for the 'Plank' exercise.

How many Planks are configured, which Units apply, and what are the configured Values?
4 rows, 1 Unit, and 4 distinct Values

Jump to...*/
/*QUERY*/
SELECT E.Name AS ExerciseName, EIUV.Value, U.Name AS UnitName
FROM Exercise E
JOIN ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId
JOIN ExerciseInstanceUnitValue EIUV ON EI.ExerciseInstanceId = EIUV.ExerciseInstanceId
JOIN Unit U ON EIUV.UnitId = U.UnitId
WHERE E.Name = 'Plank';
