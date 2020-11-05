drop schema if exists NBAschema cascade;
create schema NBAschema;
set search_path to NBAschema;

create table Teams(
	TeamID integer primary key,
	Name varchar(30) not null,
	City varchar(30),
	Conference varchar(30),
	Division varchar(30),
	unique (name)
);

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
);

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
);


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
);

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
);

create table Allstar(
    PlayerID integer primary key,
    Name varchar(30),
    TeamID integer not null,
    Team varchar(30),
    Position varchar(30),
	foreign key (PlayerID) references Player
);
