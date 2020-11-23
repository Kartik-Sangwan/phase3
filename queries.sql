-- Q1
-- The following types of queries can be used to extract any information
-- regarding teamStats as a whole. We can also report any Statistics for the whole 2019 season.

--(A) Team with the highest season wins for 2019
select Teams.TeamID, Teams.Name, TeamStats.wins 
from Teams, TeamStats
where Teams.TeamID = TeamStats.TeamID and 
TeamStats.Wins >= all (select Wins from TeamStats); 

--(B) Team with the highest FieldGoalsMade wins for 2019
select Teams.TeamID, Teams.Name, TeamStats.FieldGoalsMade 
from Teams, TeamStats
where Teams.TeamID = TeamStats.TeamID and 
TeamStats.FieldGoalsMade >= all (select FieldGoalsMade from TeamStats); 

--(C) Team with the lowest Assists wins for 2019
select Teams.TeamID, Teams.Name, TeamStats.Assists 
from Teams, TeamStats
where Teams.TeamID = TeamStats.TeamID and 
TeamStats.Assists <= all (select Assists from TeamStats); 

--(D) Team with the longest winning streak in 2019 season.
select Teams.TeamID, Teams.Name 
from Teams, Standings
where Teams.TeamID = Standings.TeamID 
and Standings.streak >= all (select streak from Standings); 

--Q2
-- Player Stats

--(E) Player with the Highest Field Goals made 
select Player.PlayerID, Player.Name, PlayerStats.FieldGoalsMade 
from Player, PlayerStats 
where PlayerStats.PlayerID = Player.PlayerID and  
PlayerStats.FieldGoalsMade >= all (select FieldGoalsMade from PlayerStats);

--(F) Player with the most personal fouls
select Player.PlayerID, Player.Name, PlayerStats.PersonalFouls 
from Player, PlayerStats 
where PlayerStats.PlayerID = Player.PlayerID and  
PlayerStats.PersonalFouls >= all (select PersonalFouls from PlayerStats);

--(G) Experience of player vs Total Minutest that they played
select Player.PlayerID, Player.Name, Player.Experience, PlayerStats.MinutesTotal
from Player, PlayerStats 
where PlayerStats.PlayerID = Player.PlayerID
order by Experience;

DROP VIEW IF EXISTS AvgSalary CASCADE;
DROP VIEW IF EXISTS NumAllStar CASCADE;
DROP VIEW IF EXISTS Combined CASCADE;

--Q3
-- Overall Standings and general information that might be useful to teams/managers

--(H) Finding Number of AllStar Players that are in the Team and the average salary for that team players.

create VIEW AvgSalary as 
select Teams.TeamID, Teams.Name, count(*) as numPlayers, ROUND(avg(Player.salary)) as avgSalary
from Teams left join Player
on Teams.TeamID = Player.TeamID 
group by Teams.TeamID;
-- Average Salary of players for each team
select * from AvgSalary;


--(I) Finding the number of allStars in each team
create VIEW NumAllStar as 
select Teams.TeamID, count(*) as allStars
from Teams, Allstar, Player
where Teams.TeamID = Allstar.TeamID and Allstar.PlayerID = Player.PlayerID
group by Teams.TeamID;
-- Number of AllStar players in each team
select * from NumAllStar;


--(J) Combining query (H) and (I)
create VIEW Combined as 
select AvgSalary.TeamID, Name, avgSalary, COALESCE(allStars, 0) as Allstars
from AvgSalary left join NumAllStar
on AvgSalary.TeamID = NumAllStar.TeamID
order by avgSalary;

-- Number of AllStar Players that are in the Team and the average salary for that team players.
-- Warriors have the highest salary as they have the most AllStart Players
select * from Combined;

--