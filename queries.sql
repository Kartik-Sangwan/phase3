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

--(D) Average number FreeThrows made in 2019 season.
select avg(TeamStats.FreeThrowsMade) 
from TeamStats;

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

--Q3
-- Overall Standings and general information that might be useful to teams/managers

--(H) Number of AllStar Players that are in the Team and the average salary for that team players.
-- Warriors have the highest salary as they have the most AllStart Players.
CREATE VIEW AvgSalary as 
select Teams.TeamID, Teams.Name, count(*) as numPlayers, ROUND(avg(Player.salary)) as avgSalary
from Teams left join Player
on Teams.TeamID = Player.TeamID 
group by Teams.TeamID;

--(I) Finding the number of allStars in each team
CREATE VIEW NumAllStar as 
select Teams.TeamID, count(*) as allStars
from Teams, Allstar, Player
where Teams.TeamID = Allstar.TeamID and Allstar.PlayerID = Player.PlayerID
group by Teams.TeamID;

--(J) Combining query (H) and (I)
CREATE VIEW Combined as 
select AvgSalary.TeamID, Name, avgSalary, COALESCE(allStars, 0) as Allstars
from AvgSalary left join NumAllStar
on AvgSalary.TeamID = NumAllStar.TeamID
order by avgSalary;


--