/*Ramdayal*/


use PersonalTrainer;

/*-- Use an aggregate to count the number of Clients.*/

SELECT COUNT(*) AS NumberOfClients FROM Client;*/

/*-- 500 rows
--------------------

-- Use an aggregate to count Client.BirthDate.*/

SELECT COUNT(Client.BirthDate) AS NumOfClientBirthday FROM Client;

/*-- The number is different than total Clients. Why?*/

/*Because Some of the BirthDate columns are Empty.*/

/*-- 463 rows

-- Group Clients by City and count them.
-- Order by the number of Clients desc.*/

SELECT City, Count(*) AS NumberOfClients 
FROM Client
GROUP BY City
ORDER BY NumberOfClients DESC;

/*-- 20 rows
--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().*/

SELECT InvoiceId, SUM(Price * Quantity) AS TotalAmount
FROM InvoiceLineItem
GROUP BY InvoiceId;

/*-- 1000 rows
--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.*/

SELECT InvoiceId, SUM(Price * Quantity) AS TotalAmount
FROM InvoiceLineItem
GROUP BY InvoiceId
HAVING SUM(Price * Quantity) > 500.00
ORDER BY TotalAmount ASC;

/*-- 234 rows
--------------------

-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.*/

SELECT Description, AVG(Price * Quantity) AS AverageLineItemTotal
FROM InvoiceLineItem
GROUP BY Description;

/*-- 3 rows
--------------------

-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.*/
/*SELECT C.ClientId, C.FirstName, C.LastName
FROM Client C
JOIN Invoice I ON C.ClientId=I.ClientId
JOIN InvoiceLineItem ILI ON I.InvoiceId=ILI.InvoiceId
WHERE I.InvoiceStatus=2
GROUP BY C.ClientId, C.FirstName, C.LastName
HAVING SUM(ILI.Price * ILI.Quantity) > 1000
ORDER BY C.FirstName,C.LastName;
/*-- 146 rows
--------------------

-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.*/

SELECT EC.Name AS ExerciseCategoryName, COUNT(E.ExerciseId) AS ExerciseCount
FROM Exercise E 
JOIN ExerciseCategory EC ON E.ExerciseCategoryId=EC.ExerciseCategoryId
GROUP BY EC.Name
ORDER BY ExerciseCount DESC;

/*-- 13 rows
--------------------

-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.*/

SELECT E.Name, MAX(EI.Sets) AS MaxSets, MIN(EI.Sets) AS MinSets, AVG(EI.Sets)
FROM Exercise E 
JOIN ExerciseInstance EI ON E.ExerciseId=EI.ExerciseId
GROUP BY E.Name
ORDER BY E.Name;

/*-- 64 rows
--------------------

-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'*/
SELECT W.Name AS WorkoutName,
 MIN(C.BirthDate) AS EarliestBirthDate,
 MAX(C.BirthDate) AS LatestBirthDate
FROM Workout W
JOIN ClientWorkout CW ON W.WorkoutId=CW.WorkoutId
JOIN Client C ON CW.ClientId=C.ClientId
GROUP BY W.Name;
/*--------------------
-- Count client goals.
-- Be careful not to exclude rows for clients without goals.*/

/*-- 500 rows total
-- 50 rows with no goals
--------------------*/
SELECT C.ClientId, C.FirstName, C.LastName, COUNT(CG.GoalId) AS NumberOfGoals
FROM Client C 
LEFT JOIN ClientGoal CG ON C.ClientId=CG.ClientId
GROUP BY C.ClientId, C.FirstName, C.LastName;

/*-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.*/
SELECT 
    E.Name AS ExerciseName, 
    U.Name AS UnitName, 
    MIN(EIUV.Value) AS MinValue, 
    MAX(EIUV.Value) AS MaxValue
FROM 
    Exercise E
JOIN 
    ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId
JOIN 
    ExerciseInstanceUnitValue EIUV ON EI.ExerciseInstanceId = EIUV.ExerciseInstanceId
JOIN 
    Unit U ON EIUV.UnitId = U.UnitId
GROUP BY 
    E.Name, U.Name
ORDER BY  
    E.Name, U.Name;


/*-- 82 rows
--------------------

-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.*/
SELECT 
    EC.Name AS ExerciseCategoryName,
    E.Name AS ExerciseName, 
    U.Name AS UnitName, 
    MIN(EIUV.Value) AS MinValue, 
    MAX(EIUV.Value) AS MaxValue
FROM 
    Exercise AS E
JOIN 
    ExerciseInstance AS EI ON E.ExerciseId = EI.ExerciseId
JOIN 
    ExerciseInstanceUnitValue AS EIUV ON EI.ExerciseInstanceId = EIUV.ExerciseInstanceId
JOIN 
    Unit AS U ON EIUV.UnitId = U.UnitId
JOIN 
    ExerciseCategory AS EC ON E.ExerciseCategoryId = EC.ExerciseCategoryId
GROUP BY 
    EC.Name, E.Name, U.Name
ORDER BY  
    EC.Name, E.Name, U.Name;

/*-- 82 rows
--------------------

-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.*/
SELECT L.Name AS LevelName,
FLOOR(DATEDIFF(CURDATE(), MIN(C.BirthDate)) / 365.25) AS MinAge,
FLOOR(DATEDIFF(CURDATE(), MAX(C.BirthDate)) / 365.25) AS MaxAge
FROM Client C
JOIN ClientWorkout CW ON C.ClientId = CW.ClientId
JOIN Workout W ON CW.WorkoutId = W.WorkoutId
JOIN Level L ON W.LevelId = L.LevelId
GROUP BY L.Name
ORDER BY L.Name;

/*-- 4 rows
--------------------

-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)
--------------------*/
SELECT SUBSTRING_INDEX(EmailAddress, '@', -1) AS EmailExtension, COUNT(*) AS LoginCount
FROM Login
GROUP BY EmailExtension;
/*-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.*/
SELECT C.FirstName, C.LastName, W.Name AS WorkoutName
FROM Client C
JOIN ClientGoal CG ON C.ClientId = CG.ClientId
JOIN Goal G ON CG.GoalId = G.GoalId
JOIN WorkoutGoal WG ON G.GoalId = WG.GoalId
JOIN Workout W ON WG.WorkoutId = W.WorkoutId
GROUP BY C.ClientId, W.WorkoutId
HAVING COUNT(*) >= 2
ORDER BY C.LastName, C.FirstName;
/*-- 139 rows
--------------------*/
