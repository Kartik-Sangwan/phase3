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
	Name varchar(30),
	FantasyPoints integer,
	MinutesTotal float,
	FieldGoalsMade integer,
	FieldGoalsAttempted integer,
	EffectiveFieldGoalsPercentage float,
	TwoPointersMade integer,
	ThreePointerMade integer,
	FreeThrowsAttempted integer, 
	Rebounds integer,
	PersonalFouls integer,
	AssistsPercentage float,
	foreign key (Name) references Player(Name)
);


create table TeamStats(
	StatID integer primary key,
	TeamID integer,
	Wins integer,
	Losses integer,
	Possessions float,
	Minutes float,
	FieldGoalsMade integer,
	FieldGoalsPercentage float,
	TwoPointersMade integer,
	ThreePointerAttempted integer,
	FreeThrowsMade integer, 
	DefensiveRebounds integer,
	Assists integer,
	steals integer,
	TrueShootingPercentage float,
	AssistPercentage float,
	foreign key (TeamID) references Teams
);

create table standings (
	TeamID integer primary key,
	Wins integer,
	Losses integer,
	ConferenceLosses integer,
	ConferenceWins integer,
	DivisonWins integer,
	DivisionLosses integer,
	HomeWins integer,
	HomeLosses integer,
	AwayWins integer,
	LastTenWins integer,
	LastTenLosses integer,
	Streak float,
	foreign key (TeamID) references Teams
);

create table betting(
	TeamID integer primary key,
	WinsAgainstTheSpread integer, 
	LossesAgainstTheSpread integer,
	pushesAgainstTheSpread integer, 
	AverageScore float,
	AverageOpponentScore float,
	foreign key (TeamID) references Teams
);
