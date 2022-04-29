---1.
create table nba_2017_players(
              PLAYER_ID int ,
              Player_name text not null,
              Pos text,
              Age int,
              primary key (PLAYER_ID));


---2.
CREATE TABLE nba_2017_teams (
	TEAM_ID				integer,
	Team_name 			varchar(50) not null,
	TEAM_ABBREVIATION 	varchar(10),
	GMS					integer,
	TOTAL				integer,
	AVG					integer,
	PCT					numeric(4,1),
	VALUE_MILLIONS		numeric(6,2),
	PRIMARY KEY (TEAM_ID));
	
---3. 
CREATE TABLE nba_2017_player_ranking(
	rank_id serial PRIMARY KEY,
    PLAYER_ID	integer not null,
    GP_RANK 			integer,
	W_RANK 				integer,
	L_RANK 				integer,
	W_PCT_RANK 			integer,
	MIN_RANK 			integer,
	OFF_RATING_RANK 	integer,
	DEF_RATING_RANK 	integer,
	NET_RATING_RANK 	integer,
	AST_PCT_RANK		integer,
	AST_TO_RANK 		integer,
	AST_RATIO_RANK 		integer,
	OREB_PCT_RANK 		integer,
	DREB_PCT_RANK 		integer,
	REB_PCT_RANK 		integer,
	TM_TOV_PCT_RANK  	integer,
	EFG_PCT_RANK 		integer,
	TS_PCT_RANK 		integer,
	USG_PCT_RANK 		integer,
	PACE_RANK 			integer,
	PIE_RANK			integer,
	FGM_RANK 			integer,
	FGA_RANK 			integer,
	FGM_PG_RANK 		integer,
	FGA_PG_RANK			integer,
	FG_PCT_RANK			integer,
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID) );


---4. 
CREATE TABLE nba_2017_player_fact (
	fact_id serial PRIMARY KEY,
	PLAYER_ID			integer not null,
	W_PCT 				numeric(4,3),
	OFF_RATING 			numeric(4,1),
	DEF_RATING 			numeric(4,1),
	NET_RATING 			numeric(3,1),
	AST_PCT 			numeric(4,3),
	AST_TO 				numeric(4,3),
	AST_RATIO 			numeric(4,3),
	OREB_PCT 			numeric(4,3),
	DREB_PCT 			numeric(4,3),
	REB_PCT 			numeric(4,3),
	TM_TOV_PCT 			numeric(4,3),
	EFG_PCT 			numeric(4,3),
	TS_PCT 				numeric(4,3),
	USG_PCT 			numeric(4,3),
	FGM 				numeric(3,1),
	FGA 				numeric(3,1),
	FGM_PG 				numeric(3,2),
	FGA_PG 				numeric(3,2),
	FG_PCT 				numeric(4,3),
	PTS					integer,	
	ACTIVE_TWITTER_LAST_YEAR	varchar(10),
	TWITTER_FOLLOWER_COUNT_MILLIONS		integer,
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));


---5. 
create table nba_2017_player_stats_1(
			  stat_1_ID SERIAL PRIMARY KEY,
              PLAYER_ID      int not null,
              MP numeric,              
              FG numeric,
              FGP numeric,
			  ThreeP numeric,
			  ThreePA numeric,
			  ThreePP numeric,
			  TwoP numeric,
			  TwoPA numeric,
			  TwoPP numeric,
			  FT numeric,
			  FTA numeric,
			  FTP numeric,
			  ORB numeric,
			  DRB numeric,
			  TRB numeric,
			  AST numeric,
			  STL numeric,
			  BLK numeric,
			  TOV numeric,
			  PF numeric,
              FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));




---6.
create table nba_2017_player_stats_2(
			 stat_2_ID SERIAL PRIMARY Key,
	         Player_name         text,
             PLAYER_ID int  not null,
	         POINTS numeric,
             GP numeric,	
	         MPG numeric,         
	         ORPM numeric,
	         DRPM numeric,	
             RPM numeric,
             WINS_RPM numeric,
             PIE numeric,
	         PACE numeric,
             FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
			 
---7.
CREATE TABLE nba_2017_player_stats_3 (
 	stats_3_id SERIAL PRIMARY KEY,
	PLAYER_ID		integer NOT NULL,
	W				numeric(2,0),
	L				numeric(2,0),
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
	
	
---8.
CREATE TABLE nba_2017_player_stats_4 (
	stat_4_ID SERIAL PRIMARY KEY,
 	PLAYER_ID		integer NOT NULL,
 	OFFRTG			numeric(4,1),
	DEFRTG			numeric(4,1),
	NETRTG          numeric(4,1),
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
	

---9. 
CREATE TABLE nba_2017_player_stats_5(
	stat_5_ID SERIAL PRIMARY KEY,
 	PLAYER_ID		integer NOT NULL,
 	NAME			varchar,
	SALARY			numeric,
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
	

---10.	
CREATE TABLE nba_2017_team_clusters (
	cluster_id SERIAL PRIMARY KEY,
	TEAM_ID 	integer not null,
	ELO 		integer, 
	CONF		varchar(20),
	cluster 	integer,
    FOREIGN KEY (TEAM_ID) REFERENCES nba_2017_teams (TEAM_ID));


--- 11.
CREATE TABLE nba_2017_salary (
	SALARY_ID SERIAL PRIMARY KEY,
	PLAYER_ID		integer NOT NULL,
 	SALARY_MILLIONS	numeric(4,2),
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));

	
---12.	
CREATE TABLE nba_2017_endorsements (
	endorsement_id SERIAL PRIMARY KEY,
	PLAYER_ID		integer NOT NULL,
	TEAM_ID			integer NOT NULL,
	ENDORSEMENT		numeric(10,2),
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
	

---13.	
CREATE TABLE nba_2017_wikipedia (
	wiki_id SERIAL PRIMARY KEY,
	PLAYER_ID		integer NOT NULL,
 	pageviews		numeric,
	timestamps		timestamp,
	wikipedia_handles text,
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
	
	
---14.	
CREATE TABLE nba_2017_twitter (
	twit_id SERIAL PRIMARY KEY,
	PLAYER_ID		integer NOT NULL,
 	TWITTER_FAVORITE_COUNT numeric,
	TWITTER_RETWEET_COUNT  numeric,
    FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));
		  
---15.
create table nba_2017_team_player(
     TP_ID SERIAL PRIMARY KEY,
     TEAM_ID		int not null,
     PLAYER_ID   int,
     FOREIGN KEY (TEAM_ID) REFERENCES nba_2017_teams (TEAM_ID),
     FOREIGN KEY (PLAYER_ID) REFERENCES nba_2017_players (PLAYER_ID));