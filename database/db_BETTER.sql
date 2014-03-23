-- ==========================================================================================
-- 
-- Adrian Brown, Ashley Coleman, Alex Ketley
-- Student No: c3145942, c3145268, c3164386
-- INFT3050 Assignment Three
-- 08 / 11 / 2013
-- 
--===========================================================================================
-- CREATE AND USE DATABASE --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--===========================================================================================
CREATE DATABASE db_BETTER;
GO
USE db_BETTER;
GO

--===========================================================================================
-- CREATE TABLES --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--===========================================================================================
CREATE TABLE tbl_USERS (
	intId						INT			IDENTITY		PRIMARY KEY,
	strUsername					VARCHAR(50) 	NOT NULL,
	strEmail					VARCHAR(100) 	NOT NULL,
	strParentEmail				VARCHAR(100) 	NOT NULL,
	strHashedPassword			VARCHAR(50) 	NOT NULL,
	dteRegistrationDate			DATETIME 	DEFAULT getdate() NOT NULL,
	isActivated					BIT			DEFAULT 1,
	isVisible					BIT			DEFAULT 1,
	isPublic					BIT			DEFAULT 1,
	intTotalXP					INT			DEFAULT 0,
	intExerciseXP				INT			DEFAULT 0 NOT NULL		CHECK(intExerciseXP >= 0)
);
CREATE TABLE tbl_ELEMENT (
	intId						INT			IDENTITY		PRIMARY KEY,
	strName						VARCHAR(50) 	NOT NULL,
	strDescription				VARCHAR(128),
	dblDamagePoints				FLOAT		DEFAULT 0 NOT NULL		CHECK(dblDamagePoints >= 0.0),
	dblDefencePoints			FLOAT		DEFAULT 0 NOT NULL		CHECK(dblDefencePoints >= 0.0),
	dblDamageVariation			FLOAT		DEFAULT 0 NOT NULL		CHECK(dblDamageVariation >= 0.0),
	dblDefenceVariation			FLOAT		DEFAULT 0 NOT NULL		CHECK(dblDefenceVariation >= 0.0),
	intXpPerLevel				INT			DEFAULT 0 NOT NULL,
	intOpposite					INT			DEFAULT NULL	REFERENCES tbl_ELEMENT(intId) -- NULLABLE IN ORDER TO CREATE ELEMENTS INITIALLY BEFORE OPPOSITES
);
GO
CREATE TABLE tbl_FIXED_CHARACTER (
	intId						INT			IDENTITY		PRIMARY KEY,
	strName						VARCHAR(128)	NOT NULL,
	strDescription				VARCHAR(128),
	strImageFileName			VARCHAR(128)	NOT NULL,
	intElement					INT			NOT NULL		REFERENCES tbl_ELEMENT(intId), 
	dblDamagePointsOverride		FLOAT		DEFAULT NULL	CHECK(dblDamagePointsOverride IS NULL OR dblDamagePointsOverride >= 0.0),
	dblDefencePointsOverride	FLOAT		DEFAULT NULL	CHECK(dblDefencePointsOverride IS NULL OR dblDefencePointsOverride >= 0.0),
	dblDamageVariationOverride	FLOAT		DEFAULT NULL	CHECK(dblDamageVariationOverride IS NULL OR dblDamageVariationOverride >= 0.0),
	dblDefenceVariationOverride	FLOAT		DEFAULT NULL	CHECK(dblDefenceVariationOverride IS NULL OR dblDefenceVariationOverride >= 0.0),
	intXpPerLevelOverride		INT			DEFAULT NULL	CHECK(intXpPerLevelOverride IS NULL OR intXpPerLevelOverride >= 0)
);
CREATE TABLE tbl_EXERCISE ( 
	intId						INT			IDENTITY				PRIMARY KEY,
	intUsersId					INT			NOT NULL				REFERENCES tbl_USERS(intId), 
	dteDate						DATETIME	DEFAULT getdate() NOT NULL,
	intShakes					INT			DEFAULT 0 NOT NULL		CHECK(intShakes > 0), 
	isValid						BIT			DEFAULT 0
);
GO
CREATE TABLE tbl_USER_CHARACTER ( 
	intId						INT			IDENTITY				PRIMARY KEY,
	strName						VARCHAR(50)	NOT NULL,
	intXp						INT			DEFAULT 0 NOT NULL		CHECK(intXp >= 0),
	dteBirth					DATETIME	DEFAULT getdate() NOT NULL, 
	strImageFileName			VARCHAR(128)	DEFAULT NULL, -- Used to override default image, users can upload their own characters photo.
	intFixedCharacter			INT			NOT NULL				REFERENCES tbl_FIXED_CHARACTER(intId), 
	intUserOwner				INT			NOT NULL				REFERENCES tbl_USERS(intId),
	isActivated					BIT			DEFAULT 1,
	isVisible					BIT			DEFAULT 1
);
GO
CREATE TABLE tbl_BATTLE (
	intId						INT			IDENTITY				PRIMARY KEY,
	dteDate						DATETIME	DEFAULT getdate() NOT NULL,
	intOpponent					INT			NOT NULL				REFERENCES tbl_USER_CHARACTER(intId), 
	intChallenger				INT			NOT NULL				REFERENCES tbl_USER_CHARACTER(intId), 
	intWinner					INT			NOT NULL				REFERENCES tbl_USER_CHARACTER(intId), 
	intXp						INT			DEFAULT 0 NOT NULL		CHECK(intXp >= 0)
);
CREATE TABLE tbl_HALL_OF_FAME ( 
	intId						INT			IDENTITY		PRIMARY KEY,
	dteDate						DATETIME	DEFAULT getdate() NOT NULL,
	intUserCharacter			INT			NOT NULL		REFERENCES tbl_USER_CHARACTER(intId)
	-- We considered that if the business logic was changed for there to be more or less than 4 levels before retiring,
	-- we'd add a 'level' column to this table, make all of them 4, then from there record which level they reached on 
	-- retirement. In the business logic, we also thought, "What if the xp per level was changed?". Any character in the 
	-- hall of fame can be safely presumed as level 4 with this table structure.
);
GO

--===========================================================================================
-- STORED PROCEDURES --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--===========================================================================================
-- Procedure:			usp_getUser
-- About:				Gets users information minus the password
-- @param 	id 			Users id
-- @return 				Users information minus the password
CREATE PROCEDURE usp_getUser
    @id INT 
AS 
	SELECT intId, strUsername, dteRegistrationDate, isActivated, isVisible, isPublic, intExerciseXP FROM tbl_USERS WHERE intId = @id;
GO
-- Procedure:			usp_setUser
-- About:				Sets users information
-- @param 	username 	Users username
-- @param 	email 		Users username
-- @param 	parentEmail Users username
-- @param 	hashedPassword Users hashed password
-- @return 				New users id no.
CREATE PROCEDURE usp_setUser
    @username VARCHAR(50), 
    @email VARCHAR(100), 
    @parentEmail VARCHAR(100), 
	@hashedPassword VARCHAR(50)
AS 
	INSERT INTO tbl_USERS (strUsername, strEmail, strParentEmail, strHashedPassword)
	VALUES (@username, @email, @parentEmail, @hashedPassword);
	SELECT @@IDENTITY AS 'New Users ID No.';
GO
-- Procedure:			usp_checkPassword
-- About:				Checks if the password entered matches the one in the database.
-- @param 	userID 		Users id
-- @param 	hash 		Hashed password to compare
-- @return 				True if passwords matched
CREATE PROCEDURE usp_checkPassword
	@userID INT,
    @hash CHAR(32)
AS 
	DECLARE @match BIT; SET @match = 0;
	IF ((SELECT strHashedPassword FROM tbl_USERS WHERE intId = @userID) = @hash)
	BEGIN
		SET @match = 1;
	END
	SELECT @match AS 'Password Matched?';
GO
-- Procedure:			usp_checkUsername
-- About:				Checks if a username already exists.
-- @param 	username 	Username to search for
-- @return 				True if username exists
CREATE PROCEDURE usp_checkUsername 
    @username CHAR (50) 
AS 
	DECLARE @exists BIT; 
	SET @exists = (SELECT CONVERT(bit, COUNT(*)) FROM tbl_USERS WHERE strUsername = @username);
	SELECT @exists AS 'User Exists?';
GO

-- Procedure:			usp_getUsersExercise
-- About:				Gets exercise done by a user.
-- @param 	id 			Users id.
-- @return 				All exercise records.
CREATE PROCEDURE usp_getUsersExercise
    @id INT 
AS 
	SELECT * FROM tbl_EXERCISE WHERE intUsersId = @id;
GO
-- Procedure:			usp_getUsersCharacters
-- About:				Gets all characters owned by a user.
-- @param	id 			Users id.
-- @return 				All characters owned by the user.
CREATE PROCEDURE usp_getUsersCharacters
    @id INT 
AS 
	SELECT * FROM tbl_USER_CHARACTER WHERE intUserOwner = @id;
GO

-- This is needed for usp_getUsersCharactersHallOfFame
CREATE TYPE tbl_DEACTIVATED_LIST AS TABLE ( -- For usp_getUsersCharactersHallOfFame
	intId INT
);
GO
-- Procedure:			usp_getUsersCharactersHallOfFame
-- About:				Gets users characters that are in the hall of fame.
-- @param 	id 			Users ID
-- @return 				Users characters in the hall of fame.
CREATE PROCEDURE usp_getUsersCharactersHallOfFame
    @id INT 
AS 
	DECLARE @HOF tbl_DEACTIVATED_LIST;
	DECLARE HOF_Cursor CURSOR FOR 
		SELECT intId FROM tbl_USER_CHARACTER WHERE intUserOwner = @id AND isActivated = 0;
	OPEN HOF_Cursor
		DECLARE @deactivatedID INT;
		FETCH NEXT FROM HOF_Cursor INTO @deactivatedID;
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF ((SELECT CONVERT(bit, COUNT(*)) FROM tbl_HALL_OF_FAME WHERE intUserCharacter = @deactivatedID) = 1)
			BEGIN
				INSERT INTO @HOF VALUES (@deactivatedID); -- Add to HOF Matches Table
			END
			FETCH NEXT FROM HOF_Cursor INTO @deactivatedID;
		END
	CLOSE HOF_Cursor;
	DEALLOCATE HOF_Cursor;
	SELECT intId AS 'HOF Matches' FROM @HOF; -- Return matched hall of fame characters
GO

-- Procedure:			usp_getUserCharacterLevel
-- About:				Gets user characters level.
-- @param 	ucid		User Character ID
-- @return 				Characters level
CREATE PROCEDURE usp_getUserCharacterLevel
    @ucid INT 
AS 
	DECLARE @fcid INT; SET @fcid = (SELECT intFixedCharacter FROM tbl_USER_CHARACTER WHERE intId = @ucid);
	DECLARE -- Returning these variables
		@xp INT,
		@xpPerLevel	INT, 
		@characterLevel INT,
		@element INT;

	-- SET EASY TO GET VARIABLES
	SET @element = (SELECT intElement FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	SET @xp = (SELECT intXp FROM tbl_USER_CHARACTER WHERE intId = @ucid);
	SET @xpPerLevel = (SELECT intXpPerLevel FROM tbl_ELEMENT WHERE intId = @element);

	-- Find if battle point defaults have been overridden
	IF ((SELECT intXpPerLevelOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @xpPerLevel = (SELECT intXpPerLevelOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END

	-- Calculate Level
	SET @characterLevel = (@xp / @xpPerLevel); -- Calc level, (CASTS TO AN INT, SQL SERVER HANDLES DIVISION BY 0 TOO)

	SELECT @characterLevel AS 'Character Level';
GO

-- Procedure:			usp_getUserCharacterBattlePoints
-- About:				Gets user characters battle information.
-- @param 	ucid		User Character ID
-- @return 				Returns battle stat information in one neat tuple for the battle system.
CREATE PROCEDURE usp_getUserCharacterBattlePoints 
    @ucid INT 
AS 
	DECLARE @fcid INT; SET @fcid = (SELECT intFixedCharacter FROM tbl_USER_CHARACTER WHERE intId = @ucid);
	DECLARE -- Returning these variables
		@element INT, 
		@opposite INT, 
		@damagePoints FLOAT, 
		@defencePoints FLOAT, 
		@damageVariation FLOAT, 
		@defenceVariation FLOAT, 
		@xp INT,
		@xpPerLevel	INT, 
		@characterLevel INT;

	-- SET EASY TO GET VARIABLES
	SET @element = (SELECT intElement FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	SET @opposite = (SELECT intOpposite FROM tbl_ELEMENT WHERE intId = @element);
	SET @xp = (SELECT intXp FROM tbl_USER_CHARACTER WHERE intId = @ucid);

	-- Element Battle Point Defaults
	SET @damagePoints = (SELECT dblDamagePoints FROM tbl_ELEMENT WHERE intId = @element);
	SET @defencePoints = (SELECT dblDefencePoints FROM tbl_ELEMENT WHERE intId = @element);
	SET @damageVariation = (SELECT dblDamageVariation FROM tbl_ELEMENT WHERE intId = @element);
	SET @defenceVariation = (SELECT dblDefenceVariation FROM tbl_ELEMENT WHERE intId = @element);
	SET @xpPerLevel = (SELECT intXpPerLevel FROM tbl_ELEMENT WHERE intId = @element);
	
	-- Find if battle point defaults have been overridden
	IF ((SELECT dblDamagePointsOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @damagePoints = (SELECT dblDamagePointsOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END
	IF ((SELECT dblDefencePointsOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @defencePoints = (SELECT dblDefencePointsOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END
	IF ((SELECT dblDamageVariationOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @damageVariation = (SELECT dblDamageVariationOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END
	IF ((SELECT dblDefenceVariationOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @defenceVariation = (SELECT dblDefenceVariationOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END
	IF ((SELECT intXpPerLevelOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid) IS NOT NULL) 
	BEGIN 
		SET @xpPerLevel = (SELECT intXpPerLevelOverride FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	END

	-- Calculate Level
	SET @characterLevel = (@xp / @xpPerLevel); -- Calc level, (CASTS TO AN INT, SQL SERVER HANDLES DIVISION BY 0 TOO)

	SELECT -- Display all information needed for a character battle for queried character.
		@element AS 'Element', 
		@opposite AS 'Opposite', 
		@damagePoints AS 'Damage Points', 
		@defencePoints AS 'Defence Points', 
		@damageVariation AS 'Damage Variation', 
		@defenceVariation AS 'Defence Variation', 
		@xp AS 'XP',
		@xpPerLevel AS 'XP Per Level', 
		@characterLevel AS 'Character Level';
GO

-- Procedure:			usp_getPointsEarnedTodayByUser
-- About:				Gets the points the user earned today from battle
-- @param 	id 			Users ID
-- @return 				XP Earned today from battle
CREATE PROCEDURE usp_getPointsEarnedTodayByUser
    @id INT 
AS 
	DECLARE XPToday_Cursor CURSOR FOR 
		SELECT intXp FROM tbl_BATTLE WHERE intWinner = @id AND DATEDIFF(day, dteDate, getdate()) = 0;
	OPEN XPToday_Cursor
		DECLARE @xpToday INT; SET @xpToday = 0;
		DECLARE @xpBattle INT; SET @xpBattle = 0; 
		FETCH NEXT FROM XPToday_Cursor INTO @xpBattle;
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			SET @xpToday = @xpToday + @xpBattle;
			FETCH NEXT FROM XPToday_Cursor INTO @xpBattle;
		END
	CLOSE XPToday_Cursor;
	DEALLOCATE XPToday_Cursor;
	SELECT @xpToday AS 'XP Earned Today';
GO
-- Procedure:			usp_getCharacterExerciseToBattleXPRatio
-- About:				Finds out how much of the characters xp is from battle and how much is from exercise. 
-- 						There will be business logic preventing this ratio from being all exercise
-- @param 	ucid 		User Character ID
-- @return 				XP from battles, XP from exercise
CREATE PROCEDURE usp_getCharacterExerciseToBattleXPRatio 
    @ucid INT
AS 
	DECLARE @counter INT;
	DECLARE BATTLEXP_Cursor CURSOR FOR 
		SELECT intXp FROM tbl_BATTLE WHERE intWinner = @ucid;
	OPEN BATTLEXP_Cursor
		DECLARE @xpBattleTotal INT; SET @xpBattleTotal = 0;
		SET @counter = 0; 
		FETCH NEXT FROM BATTLEXP_Cursor INTO @counter;
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			SET @xpBattleTotal = @xpBattleTotal + @counter;
			FETCH NEXT FROM BATTLEXP_Cursor INTO @counter;
		END
	CLOSE BATTLEXP_Cursor;
	DEALLOCATE BATTLEXP_Cursor;

	DECLARE @xpExerciseTotal INT;
	SET @xpExerciseTotal = (SELECT intXp FROM tbl_USER_CHARACTER WHERE intId = @ucid) - @xpBattleTotal;
	SELECT @xpBattleTotal AS 'XP from Battles', @xpExerciseTotal AS 'XP from Exercise';
GO

-- Procedure:			usp_getCharactersImageFileName
-- About:				Works out the file name of the user characters picture (Whether it's the default or uploaded.)
-- 						Also works out the directory the image will be found in based on element or custom image.
-- @param 	ucid 		Users Character ID
-- @return 				Filename and Directory of characters image
CREATE PROCEDURE usp_getCharactersImageFileName 
    @ucid INT 
AS 
	DECLARE @filename CHAR(128), @directory CHAR(128), @fcid INT;
	SET @fcid = (SELECT intFixedCharacter FROM tbl_USER_CHARACTER WHERE intId = @ucid);
	SET @filename = (SELECT strImageFileName FROM tbl_FIXED_CHARACTER WHERE intId = @fcid);
	SET @directory = (SELECT strName FROM tbl_ELEMENT WHERE intId = (SELECT intElement FROM tbl_FIXED_CHARACTER WHERE intId = @fcid));
	IF ((SELECT strImageFileName FROM tbl_USER_CHARACTER WHERE intId = @ucid) IS NOT NULL) -- If image name is overridden
	BEGIN
		SET @filename = (SELECT strImageFileName FROM tbl_USER_CHARACTER WHERE intId = @ucid);
		SET @directory = 'custom';
	END
	SET @directory = LOWER(@directory); -- Make sure directory is lowercase

	SELECT @filename AS 'Filename', @directory AS 'Directory';
GO

-- Procedure:			usp_doBattle
-- About:				Creates a battle in the database and allocates points to the winning user.
-- @param 	challenger 	User Character ID of the challenger.
-- @param 	opponent 	User Character ID of the opponent.
-- @param 	winner	 	User Character ID of the winner.
-- @param 	xp 			XP for the winner.
-- @return 				Whether the procedure was succesful.
CREATE PROCEDURE usp_doBattle 
    @challenger INT, 
    @opponent 	INT, 
    @winner		INT, 
    @xp 		INT 
AS 
	DECLARE @willWork BIT; SET @willWork = 0;
	IF ((SELECT isActivated FROM tbl_USER_CHARACTER WHERE intId = @opponent) = 1 AND (SELECT isActivated FROM tbl_USER_CHARACTER WHERE intId = @challenger) = 1)
	BEGIN
		SET @willWork = 1;

		INSERT INTO tbl_BATTLE (intOpponent, intChallenger, intWinner, intXp) 
		VALUES (@opponent, @challenger, @winner, @xp);

		SELECT * FROM tbl_BATTLE WHERE intId = @@IDENTITY; -- SHOW THE CREATED BATTLE

		-- INCERMENT USERS XP
		UPDATE tbl_USER_CHARACTER 
		SET intXp = (SELECT intXp FROM tbl_USER_CHARACTER WHERE intId = @winner) + @xp
		WHERE intId = @winner;
	END
	SELECT @willWork AS 'Procedure Succesful?';
GO

--===========================================================================================
-- POPULATE TABLES --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--===========================================================================================
-- Add users
EXEC usp_setUser 'Admin Jessie', 'AdminJessie@BetterWebApp.com', 'none@none.com', '5B-DB-EC-26-4E-CD-2B-C8-0D-2C-5A-19-3F-32-1F-2B'; -- pokenot
EXEC usp_setUser 'Admin James', 'AdminJames@BetterWebApp.com', 'none@none.com', '5B-DB-EC-26-4E-CD-2B-C8-0D-2C-5A-19-3F-32-1F-2B'; -- pokenot
EXEC usp_setUser 'Tommy', 'tommy@gmail.com', 'bossy.mum@bigpond.com.au', '5F-4D-CC-3B-5A-A7-65-D6-1D-83-27-DE-B8-82-CF-99'; -- password
EXEC usp_setUser 'Chucky', 'chucky@gmail.com', 'bossy.dad@bigpond.com.au', '6E-EA-9B-7E-F1-91-79-A0-69-54-ED-D0-F6-C0-5C-EB'; -- qwertyuiop
EXEC usp_setUser 'Phil', 'phil@gmail.com', 'bossy.uncle@bigpond.com.au', '97-E9-6B-9B-63-0A-CD-15-77-25-FA-00-EF-F1-1A-80'; -- exercise
EXEC usp_setUser 'Lil', 'lil@gmail.com', 'bossy.geoff@bigpond.com.au', '42-D3-88-F8-B1-DB-99-7F-AA-F7-DA-B4-87-F1-12-90'; -- blahblah
EXEC usp_setUser 'Sally', 'sally@gmail.com', 'grumpy.grandpa@bigpond.com.au', '74-29-29-DC-B6-31-40-3D-7C-1C-1E-FA-D2-CA-27-00'; -- chicken
UPDATE tbl_USERS SET intTotalXP = 16304 WHERE intId = 1;
UPDATE tbl_USERS SET intTotalXP = 14979 WHERE intId = 2;
UPDATE tbl_USERS SET intTotalXP = 138 WHERE intId = 3;
UPDATE tbl_USERS SET intTotalXP = 400 WHERE intId = 4;
UPDATE tbl_USERS SET intTotalXP = 202 WHERE intId = 5;
UPDATE tbl_USERS SET intTotalXP = 175 WHERE intId = 6;
UPDATE tbl_USERS SET intTotalXP = 312 WHERE intId = 7;
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_EXERCISE (intUsersId, intShakes, isValid) 
	VALUES	 	 (2, 		  100, 		 1);
INSERT INTO 
	tbl_EXERCISE (intUsersId, intShakes, isValid) 
	VALUES	 	 (4, 		  500, 		 1); 
INSERT INTO 
	tbl_EXERCISE (intUsersId, intShakes, isValid) 
	VALUES	 	 (3, 		  20, 		 0);
INSERT INTO 
	tbl_EXERCISE (intUsersId, intShakes, isValid) 
	VALUES	 	 (5, 		  1000, 	 1);  
INSERT INTO 
	tbl_EXERCISE (intUsersId, intShakes, isValid) 
	VALUES	 	 (4, 		  25, 		 1); 					
								   -- TO DO: This is valid, therefore the 100 points (As given to user2), was allocated to him.
								   --		 When the business logic/algorithm is given to us, make a stored procedures to 
								   --		 1) Add exercise for user (As invalid)
								   --		 2) Validate exercise and convert pedometor steps to xp points, then add to users exerciseXP repository
								   --		 3) Let user allocate some of the users exercise point repository to one of their characters
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_ELEMENT (strName, strDescription, dblDamagePoints, dblDefencePoints, dblDamageVariation, dblDefenceVariation, intXpPerLevel) 
	VALUES  	('Water', NULL,		   	  4.0,			   7.0,				 5.0,			 	 10.0,			   	  350);
INSERT INTO 
	tbl_ELEMENT (strName, strDescription, dblDamagePoints, dblDefencePoints, dblDamageVariation, dblDefenceVariation, intXpPerLevel) 
	VALUES  	('Earth', NULL,		   	  8.0,			   4.0,				 15.0,			 	 10.0,			   	  650);
INSERT INTO 
	tbl_ELEMENT (strName, strDescription, dblDamagePoints, dblDefencePoints, dblDamageVariation, dblDefenceVariation, intXpPerLevel) 
	VALUES  	('Fire',  NULL,		   	  6.0,			   3.0,				 15.0,			 	 2.0,			   	  450);
INSERT INTO 
	tbl_ELEMENT (strName, strDescription, dblDamagePoints, dblDefencePoints, dblDamageVariation, dblDefenceVariation, intXpPerLevel) 
	VALUES  	('Air',   NULL,		   	  3.0,			   10.0,			 20.0,			 	 0.0,			   	  300);
GO
UPDATE tbl_ELEMENT 
	SET intOpposite = (SELECT intId FROM tbl_ELEMENT WHERE strName = 'Fire')
	WHERE strName = 'Water';
UPDATE tbl_ELEMENT 
	SET intOpposite = (SELECT intId FROM tbl_ELEMENT WHERE strName = 'Water')
	WHERE strName = 'Fire';
UPDATE tbl_ELEMENT 
	SET intOpposite = (SELECT intId FROM tbl_ELEMENT WHERE strName = 'Air')
	WHERE strName = 'Earth';
UPDATE tbl_ELEMENT 
	SET intOpposite = (SELECT intId FROM tbl_ELEMENT WHERE strName = 'Earth')
	WHERE strName = 'Air';
GO
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_FIXED_CHARACTER (strName, 		strDescription, strImageFileName,	intElement) 
	VALUES				('Water Man',   NULL,			'00000001.png', 	1 );
INSERT INTO 
	tbl_FIXED_CHARACTER (strName,		strDescription, strImageFileName,	intElement) 
	VALUES				('Earth Girl',  NULL,	    	'00000001.png', 	2 );
INSERT INTO 
	tbl_FIXED_CHARACTER (strName,		strDescription, strImageFileName, 	intElement) 
	VALUES				('Fire Dude',   NULL,			'00000001.png', 	3 );
INSERT INTO 
	tbl_FIXED_CHARACTER (strName,		strDescription, strImageFileName, 	intElement) 
	VALUES				('Air Guy',     NULL,			'00000001.png', 	4 );
GO
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, intXp, strImageFileName) 
	VALUES		   	   ('Rocky', 2, 				3,			  300,   '00000001.png'); -- 100 XP FROM BATTLES, REST FROM EXERCISE
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated,		intXp, strImageFileName) -- User has deactivated this character
	VALUES		   	   ('Rambo', 3, 				4,			  1,				200,   '00000002.png');
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated, intXp, strImageFileName) -- In the hall of fame
	VALUES		   	   ('Bobby', 1, 				4,			  1,		   100,  '00000003.png'); -- Level 4 character who earned their way into the hall of fame
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated, intXp, strImageFileName) -- In the hall of fame
	VALUES		   	   ('George', 2, 				4,			  1,		   100 , '00000004.png'); -- Level 4 character who earned their way into the hall of fame
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated, intXp, strImageFileName) -- In the hall of fame
	VALUES		   	   ('James', 3, 				5,			  0,		   100 , '00000005.png'); -- Level 4 character who earned their way into the hall of fame
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated, intXp) -- In the hall of fame
	VALUES		   	   ('Jimmy', 2, 				6,			  0,		   1800); -- Level 4 character who earned their way into the hall of fame
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner, isActivated, intXp) -- In the hall of fame
	VALUES		   	   ('Billy', 4, 				7,			  1,		   800); -- Level 4 character who earned their way into the hall of fame
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Leonardo', '00000008.png', 1, 				1,			  1,		   201); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Raphael', '00000009.png', 2, 				1,			  1,		   2401); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName,intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Michelangelo', '000000010.png', 3, 				1,			  1,		   3701); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName,  strImageFileName,intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Donatello', '000000011.png', 4, 				1,			  1,		   10001); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Splinter', '000000012.png', 1, 				2,			  1,		   676); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('April', '000000013.png', 2, 				2,			  1,		   1401); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName, strImageFileName,intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Casey', '000000014.png', 3, 				2,			  1,		   5401); 
GO
INSERT INTO 
	tbl_USER_CHARACTER (strName,  strImageFileName,intFixedCharacter, intUserOwner, isActivated, intXp) 
	VALUES		   	   ('Shredder', '000000015.png', 4, 				2,			  1,		   7501); 
GO
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_BATTLE  (dteDate,   intChallenger, intOpponent, intWinner, intXp) 
	VALUES 		(getdate(), 1, 			  2,		   1,		  100);
INSERT INTO 
	tbl_BATTLE  (dteDate,   intChallenger, intOpponent, intWinner, intXp) 
	VALUES 		(getdate(), 1, 			  3,		   3,		  100);
INSERT INTO 
	tbl_BATTLE  (dteDate,   intChallenger, intOpponent, intWinner, intXp) 
	VALUES 		(getdate(), 2, 			  3,		   2,		  100);
INSERT INTO 
	tbl_BATTLE  (dteDate,   intChallenger, intOpponent, intWinner, intXp) 
	VALUES 		(getdate(), 3, 			  1,		   1,		  100);
INSERT INTO 
	tbl_BATTLE  (dteDate,   intChallenger, intOpponent, intWinner, intXp) 
	VALUES 		(getdate(), 4, 			  5,		   5,		  100);
---------------------------------------------------------------------------------------------
INSERT INTO 
	tbl_HALL_OF_FAME (intUserCharacter) 
	VALUES		 	 (5);
INSERT INTO 
	tbl_HALL_OF_FAME (intUserCharacter) 
	VALUES		 	 (6);
GO

--===========================================================================================
-- QUERY DATABASE --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--=
--===========================================================================================
SELECT * FROM tbl_BATTLE;
SELECT * FROM tbl_USERS;
SELECT * FROM tbl_EXERCISE;
SELECT * FROM tbl_ELEMENT;
SELECT * FROM tbl_FIXED_CHARACTER;
SELECT * FROM tbl_USER_CHARACTER;
SELECT * FROM tbl_BATTLE;
SELECT * FROM tbl_HALL_OF_FAME;
EXEC usp_checkUsername 'user1';
EXEC usp_checkPassword 1, '5f4dcc3b5aa765d61d8327deb882cf99';
EXEC usp_checkPassword 1, 'WRONGPASS';
EXEC usp_getUser 2;
EXEC usp_getUsersCharactersHallOfFame 2;
EXEC usp_getUserCharacterBattlePoints 4;
EXEC usp_getPointsEarnedTodayByUser 1;
EXEC usp_getCharacterExerciseToBattleXPRatio 1;
EXEC usp_getCharacterExerciseToBattleXPRatio 2;
EXEC usp_getCharacterExerciseToBattleXPRatio 4;
EXEC usp_getCharactersImageFileName 2;
EXEC usp_getCharactersImageFileName 3;
EXEC usp_getCharactersImageFileName 4;
GO

--===========================================================================================
-- DROP TABLES AND DATABASE --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-
--===========================================================================================
-- DROP TABLE tbl_HALL_OF_FAME;
-- DROP TABLE tbl_BATTLE;
-- DROP TABLE tbl_USER_CHARACTER;
-- DROP TABLE tbl_FIXED_CHARACTER;
-- DROP TABLE tbl_ELEMENT;
-- DROP TABLE tbl_EXERCISE;
-- DROP TABLE tbl_USERS;
-- GO -- MAKE SURE DROP TABLE COMMANDS ARE EXECUTED

-- USE MASTER; -- STOP USING BETTER_DB DATABASE
-- GO
-- DROP DATABASE db_BETTER; -- DROP BETTER_DB DATABASE
-- GO
