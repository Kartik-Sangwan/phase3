drop schema if exists NBAschema cascade;
create schema NBAschema;
set search_path to NBAschema;

-- Table Teams which consist of the teamID (Primary Key), Name of the unique team, 
-- City to which it belongs to and the Divsion and gives basic info about teams that played in 2019 NBA Season
create table Teams(
	TeamID integer primary key,
	Name varchar(30) not null,
	City varchar(30),
	Conference varchar(30),
	Division varchar(30),
	unique (name)
);

-- Table Players which consist of the PlayerID (Primary Key), unique name, stats(eg: status, weight, height, position, etc) 
-- TeamID to indicate which team they belong to.
create table Player(
	PlayerID integer primary key,
	Name varchar(30) not null,
	Status varchar(30),
	TeamID integer,
	Position varchar(30),
	Height float,
	Weight float,
	Salary float,
	Experience float,
	College varchar(30),
	unique (Name),
	foreign key (TeamID) references teams
	on delete RESTRICT on update Restrict
);

-- PlayerStats table that gives in depth overall performance stats (like fieldGoalsMade, TwoPointersMade, etc.) of Players 
-- who played in the 2019 NBA season and it references Player Table
create table PlayerStats(
	StatID integer primary key,
	TeamID integer,
	PlayerID integer not null,
	Name varchar(30),
	FantasyPoints float,
	MinutesTotal float,
	FieldGoalsMade float,
	FieldGoalsAttempted float,
	EffectiveFieldGoalsPercentage float,
	TwoPointersMade float,
	ThreePointersMade float,
	FreeThrowsAttempted float,
	Rebounds float,
	PersonalFouls float,
	AssistsPercentage float,
	unique (PlayerID),
	foreign key (PlayerID) references Player
	on delete RESTRICT on update Restrict
);

-- TableStats table that gives in depth overall performance stats (like fieldGoalsMade, Assists, etc.) of teams 
-- who played in the 2019 NBA season and it references Teams Table
create table TeamStats(
	StatID integer primary key,
	TeamID integer,
	Wins integer,
	Losses integer,
	Possessions float,
	Minutes float,
	FieldGoalsMade float,
	FieldGoalsPercentage float,
	TwoPointersMade float,
	ThreePointerMade float,
	FreeThrowsMade float,
	DefensiveRebounds float,
	Assists float,
	Steals float,
	TrueShootingPercentage float,
	foreign key (TeamID) references Teams
	on delete RESTRICT on update Restrict
);

-- Table Standings gives the overall wins and losses for each team in 2019 NBA season based on 
-- different criteria and factors and it references Table Teams
create table Standings (
	TeamID integer primary key,
	Wins integer,
	Losses integer,
	ConferenceLosses integer,
	ConferenceWins integer,
	DivisionWins integer,
	DivisionLosses integer,
	HomeWins integer,
	HomeLosses integer,
	AwayWins integer,
	LastTenWins integer,
	LastTenLosses integer,
	Streak float,
	foreign key (TeamID) references Teams
	on delete RESTRICT on update Restrict
);

-- AllStar Table consist of all the top NBA players who played the AllStar Match of 2019 NBA season. 27 top players are selected based 
-- on their performance in NBA 2019 season for this All Stars Match.
create table Allstar(
    PlayerID integer primary key,
    Name varchar(30),
    TeamID integer not null,
    Team varchar(30),
    Position varchar(30),
	foreign key (PlayerID) references Player
	on delete RESTRICT on update Restrict
);
