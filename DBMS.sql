CREATE SCHEMA IF NOT EXISTS `VSDB` DEFAULT CHARACTER SET utf8 ;
USE `VSDB` ;


CREATE TABLE IF NOT EXISTS `Movies_and_TV_Shows` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Realese_year` INT NOT NULL,
  `Distribute_cost` DECIMAL(10,2) NOT NULL,
  `Date_of_distribution` DATE NOT NULL,
  `Score` INT NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  `Cover_Picture` VARCHAR(45) NOT NULL,
  `Director` VARCHAR(45) NOT NULL,
  `Genre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`));



CREATE TABLE IF NOT EXISTS `Rating_components` (
  `ID` INT NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Rating_symbols` (
  `ID` INT NOT NULL,
  `Rating_symbol` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Actors` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Resolutions` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Client_accounts` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Payment_option` VARCHAR(45) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Status` TINYINT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Profiles` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Icon_path` VARCHAR(45) NOT NULL,
  `Client_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `Clients_idx` (`Client_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Profiles_Clients`
    FOREIGN KEY (`Client_ID`)
    REFERENCES `Client_accounts` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Subscriptions` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(5,2) NOT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  PRIMARY KEY (`ID`));



CREATE TABLE IF NOT EXISTS `Payments` (
  `ID` INT NOT NULL,
  `Payment_date` DATE NOT NULL,
  `Payment_information` VARCHAR(45) NOT NULL,
  `Payment_amount` DECIMAL(5,2) NOT NULL,
  `Client_ID` INT NOT NULL,
  `Subcsription_ID` INT NOT NULL,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  PRIMARY KEY (`ID`),
  INDEX `Clients_idx` (`Client_ID` ASC) VISIBLE,
  INDEX `Subscriptions_idx` (`Subcsription_ID` ASC) VISIBLE,
   CONSTRAINT `FK_Payments_Client_accounts`
    FOREIGN KEY (`Client_ID`)
    REFERENCES `Client_accounts` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Payments_Subscriptions`
    FOREIGN KEY (`Subcsription_ID`)
    REFERENCES `Subscriptions` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Roles` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);



CREATE TABLE IF NOT EXISTS `Stuff_accounts` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Role_ID` INT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `Roles_idx` (`Role_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Staff_Roles`
    FOREIGN KEY (`Role_ID`)
    REFERENCES `Roles` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Movies_resolutions` (
  `Movie_ID` INT NOT NULL,
  `Resolutions_ID` INT NOT NULL,
  `File_path` VARCHAR(45) NOT NULL,
  INDEX `Resolutions_idx` (`Resolutions_ID` ASC) VISIBLE,
   PRIMARY KEY (`Movie_ID`, `Resolutions_ID`),
  CONSTRAINT `FK_Movie_resolutions_Movies`
    FOREIGN KEY (`Resolutions_ID`)
    REFERENCES `Resolutions` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Movies_resolutions_resolutions`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Movies_and_TV_Shows_actors` (
  `Movies_and_TV_Shows_ID` INT NOT NULL,
  `Actor_ID` INT NOT NULL,
  INDEX `Actor_idx` (`Actor_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Actors_Movie`
    FOREIGN KEY (`Movies_and_TV_Shows_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Actor_Movis_actors`
    FOREIGN KEY (`Actor_ID`)
    REFERENCES `Actors` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Movies_and_TV_Shows_symbols` (
  `Movies_and_TV_Shows_ID` INT NOT NULL,
  `Rating_symbol_ID` INT NOT NULL,
  PRIMARY KEY (`Movies_and_TV_Shows_ID`, `Rating_symbol_ID`),
  INDEX `Ratings_idx` (`Rating_symbol_ID` ASC) VISIBLE,
   CONSTRAINT `FK_Movies_symbols`
    FOREIGN KEY (`Movies_and_TV_Shows_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Movies_Ratings`
    FOREIGN KEY (`Rating_symbol_ID`)
    REFERENCES `Rating_symbols` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Movies_and_TV_Shows_rating_components` (
  `Movie_ID` INT NOT NULL,
  `Rating_components_ID` INT NOT NULL,
  PRIMARY KEY (`Movie_ID`, `Rating_components_ID`),
  INDEX `Rating_components_idx` (`Rating_components_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Movies_rating_component`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Rating_components`
    FOREIGN KEY (`Rating_components_ID`)
    REFERENCES `Rating_components` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `TV_Show_seasons` (
  `ID` INT NOT NULL,
  `TV_Show_ID` INT NOT NULL,
  `Season_number` INT NOT NULL,
  PRIMARY KEY (`ID`, `TV_Show_ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `TV Shows_idx` (`TV_Show_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Seasons_TV Shows`
    FOREIGN KEY (`TV_Show_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `TV_shows_episodes` (
  `ID` INT NOT NULL,
  `Episode_Number` INT NOT NULL,
  `Season_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Seasons_idx` (`Season_ID` ASC) VISIBLE,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
   CONSTRAINT `FK_Seasons_TV Shows`
    FOREIGN KEY (`Season_ID`)
    REFERENCES `TV_Show_seasons` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `TV_Show_resolutions` (
  `Resolutions_ID` INT NOT NULL,
  `Episode_ID` INT NOT NULL,
  `File_path` VARCHAR(45) NOT NULL,
  INDEX `Resolutions_idx` (`Resolutions_ID` ASC) VISIBLE,
  INDEX `Episode_resolution_idx` (`Episode_ID` ASC) VISIBLE,
  CONSTRAINT `FK_TV_Shows_Resolutions`
    FOREIGN KEY (`Resolutions_ID`)
    REFERENCES `Resolutions` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_TV_Shows_Resolutions_Episode`
    FOREIGN KEY (`Episode_ID`)
    REFERENCES `TV_shows_episodes` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `Movies_sessions` (
  `ID` INT NOT NULL,
  `Movie_ID` INT NOT NULL,
  `Client_ID` INT NOT NULL,
  `Watched_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Movies_idx` (`Movie_ID` ASC) VISIBLE,
  INDEX `Users_idx` (`Client_ID` ASC) VISIBLE,
   CONSTRAINT `FK_Movies_sessions_Movies`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Movies_and_TV_Shows` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Movies_sessions_Profiles`
    FOREIGN KEY (`Client_ID` )
    REFERENCES `Profiles` (`ID` , `ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS `TV_Show_sessions` (
  `ID` INT NOT NULL,
  `TV_Show_episode_ID` INT NOT NULL,
  `Client_ID` INT NOT NULL,
  `Watched_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Users_idx` (`Client_ID` ASC) VISIBLE,
  INDEX `TV Shows_idx` (`TV_Show_episode_ID` ASC) VISIBLE,
   CONSTRAINT `FK_TV_Shows_sessions`
    FOREIGN KEY (`TV_Show_episode_ID`)
    REFERENCES `TV_shows_episodes` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Users_TV_Shows`
    FOREIGN KEY (`Client_ID`)
    REFERENCES `Profiles` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
	
	CREATE TABLE `clients_logins` (
  `ID` INT NOT NULL,
  `Client_ID` INT NOT NULL,
  `Logged_in` DATETIME NOT NULL,
  `Logged_out` DATETIME ,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `FK_Client_logins_Client_Accounts_idx` (`Client_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Client_logins_Client_Accounts`
    FOREIGN KEY (`Client_ID`)
    REFERENCES `client_accounts` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



CREATE TABLE IF NOT EXISTS data_history LIKE movies_and_tv_shows;
DROP TABLE data_history;
ALTER TABLE data_history MODIFY COLUMN ID int NOT NULL, 
   DROP PRIMARY KEY, ENGINE = MyISAM, ADD User VARCHAR(45) NOT NULL FIRST,   
   ADD action VARCHAR(8) DEFAULT 'insert' after User, 
   ADD revision INT NOT NULL AUTO_INCREMENT AFTER action,
   ADD dt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER revision,
   ADD PRIMARY KEY (ID, revision);



DROP procedure IF EXISTS `search_content`;
DELIMITER $$
CREATE PROCEDURE `search_content`(name VARCHAR(45),genre VARCHAR(45),year int, score int)
BEGIN
SELECT M.Title,M.Genre, M.Realese_year,M.Genre, M.Description,M.Director, A.Name, RC.Description, RS.Rating_symbol,
RS.Description 
FROM movies_and_tv_shows M, movies_and_tv_shows_actors MA, actors A, rating_components RC,rating_symbols RS,
  movies_and_tv_shows_rating_components MRC, movies_and_tv_shows_symbols MRS
WHERE M.ID = MA.Movies_and_TV_Shows_ID AND MA.Actor_ID = A.ID AND M.Title = IFNULL(name, M.Title) AND M.Genre = IFNULL(genre, M.Genre)
AND M.Realese_year = IFNULL(year,M.Realese_year ) AND M.Score = IFNULL(score, M.Score)
AND M.ID =MRC.Movie_ID AND MRC.Rating_components_ID=RC.ID AND M.ID = MRS.Movies_and_TV_Shows_ID AND MRS.Rating_symbol_ID = RS.ID;
END$$
DELIMITER ;

DROP procedure IF EXISTS `search_content_by_ID`;
DELIMITER $$
CREATE PROCEDURE `search_by_ID` (ID int)
BEGIN
SELECT * FROM movies_and_tv_shows M WHERE 
M.ID = IFNULL(ID,M.ID);
END$$
DELIMITER ;

DROP procedure IF EXISTS `insert_in_Movies`;
DELIMITER $$
CREATE PROCEDURE `insert_in_Movies` (ID int, Title VARCHAR(45),Realese_year int, 
  Distribute_cost DECIMAL(10,2) ,Date_of_distribution DATE ,Score INT ,Description VARCHAR(500) ,
  Cover_Picture VARCHAR(45) ,Director VARCHAR(45) ,Genre VARCHAR(45) )
BEGIN
INSERT INTO movies_and_tv_shows  (ID, Title, Realese_year, Distribute_cost, Date_of_distribution, Score, Description, Cover_Picture, Director, Genre)
VALUES (ID, Title, Realese_year, Distribute_cost, Date_of_distribution, Score, Description, Cover_Picture, Director, Genre);
END$$
DELIMITER ;


DROP procedure IF EXISTS `delete_by_ID`;
DELIMITER $$
CREATE PROCEDURE `delete_by_ID` (ID INT)
BEGIN
DELETE FROM movies_and_tv_shows M WHERE 
M.ID = ID;
END$$
DELIMITER ;

DROP procedure IF EXISTS `edit_movie_by_ID`;
DELIMITER $$
CREATE  PROCEDURE `edit_movie_by_ID`(ID int, Title VARCHAR(45),Realese_year int, 
  Distribute_cost DECIMAL(10,2) ,Date_of_distribution DATE ,Score INT ,Description VARCHAR(500) ,
  Cover_Picture VARCHAR(45) ,Director VARCHAR(45) ,Genre VARCHAR(45))
BEGIN
UPDATE movies_and_tv_shows M SET 
 M.Title = Title, M.Realese_year = Realese_year,M.Distribute_cost = Distribute_cost,
 M.Date_of_distribution = Date_of_distribution,M.Score = Score,M.Description = Description,
 M.Cover_Picture = Cover_Picture,M.Director = Director,M.Genre = Genre WHERE M.ID = ID;
END$$
DELIMITER ;






   
   
DROP TRIGGER IF EXISTS movies_and_tv_shows__ai;
DROP TRIGGER IF EXISTS movies_and_tv_shows__au;
DROP TRIGGER IF EXISTS movies_and_tv_shows__bd;

CREATE TRIGGER movies_and_tv_shows__ai AFTER INSERT ON movies_and_tv_shows FOR EACH ROW
    INSERT INTO data_history SELECT current_user(), 'insert', NULL, NOW(), M.* 
    FROM movies_and_tv_shows AS M WHERE M.ID = NEW.ID;

CREATE TRIGGER movies_and_tv_shows__au AFTER UPDATE ON movies_and_tv_shows FOR EACH ROW
    INSERT INTO data_history SELECT current_user(),'update', NULL, NOW(), M.*
    FROM movies_and_tv_shows AS M WHERE M.ID = NEW.ID;

CREATE TRIGGER movies_and_tv_shows__bd BEFORE DELETE ON movies_and_tv_shows FOR EACH ROW
    INSERT INTO data_history SELECT current_user(),'delete', NULL, NOW(), M.* 
    FROM movies_and_tv_shows AS M WHERE M.ID = OLD.ID;




CREATE ROLE 'Administrator', 'Accountant', 'Manager';
GRANT ALL ON VSDB.* TO 'Administrator';
GRANT SELECT ON VSDB.* TO 'Accountant';
GRANT SELECT ON VSDB. *  TO 'Manager';
CREATE USER 'Lex_luter'@'localhost' IDENTIFIED BY 'superman7777';
CREATE USER 'Mia_Sorvino'@'localhost' IDENTIFIED BY 'Witch666';
CREATE USER 'Chris_Pratt'@'localhost' IDENTIFIED BY 'Guardian999';
GRANT 'Administrator' TO 'Lex_luter'@'localhost';
GRANT 'Accountant' TO 'Mia_Sorvino'@'localhost';
GRANT 'Manager' TO 'Chris_Pratt'@'localhost';




CREATE VIEW `current_month_payments` AS
    SELECT 
        SUM(`payments`.`Payment_amount`) AS `SUM of payments in current month`
    FROM
        `payments`
    WHERE
        ((MONTH(`payments`.`Payment_date`) = MONTH(CURDATE()))
            AND (YEAR(`payments`.`Payment_date`) = YEAR(CURDATE())));
			
			

CREATE  OR REPLACE VIEW `data_changes` AS
SELECT * FROM data_history;

CREATE  OR REPLACE VIEW `all_payments` AS
 SELECT 
        SUM(`payments`.`Payment_amount`) AS `SUM of all payments`
    FROM
        `payments`;

CREATE  OR REPLACE VIEW `balance_for_current_month` AS
SELECT 
        SUM(M.Distribute_cost)-SUM(P.Payment_amount) AS `Balance in current month`
    FROM
        payments P, movies_and_tv_shows M
    WHERE
        ((MONTH(P.Payment_date) = MONTH(CURDATE()))
            AND (YEAR(P.Payment_date) = YEAR(CURDATE()))
            AND  (MONTH(M.Date_of_distribution) = MONTH(CURDATE()))
             AND  (YEAR(M.Date_of_distribution) = YEAR(CURDATE())));


		
		
DROP procedure IF EXISTS `payments_for_month`;
DELIMITER $$
CREATE PROCEDURE `payments_for_month` (Month INT,Year INT)
BEGIN
SELECT 
        SUM(`payments`.`Payment_amount`) AS `SUM of payments `
    FROM
        `payments` 
    WHERE
        ((MONTH(`payments`.`Payment_date`) = Month)
            AND (YEAR(`payments`.`Payment_date`) = Year));
END$$
DELIMITER ;

DROP procedure IF EXISTS `balance_for_month`;

DELIMITER $$
CREATE PROCEDURE `balance_for_month`(Month INT, Year INT)
BEGIN
SELECT
(SELECT  SUM(Payment_amount)   
FROM      payments  
    WHERE
        ((MONTH(Payment_date) = Month)
            AND (YEAR(Payment_date) = Year)))
      -
(SELECT
      SUM(Distribute_cost)
      FROM      movies_and_tv_shows
       WHERE
             (MONTH(Date_of_distribution) = Month)
             AND  (YEAR(Date_of_distribution) = Year))
             AS `Balance in current month`;
END$$
DELIMITER ;



DROP procedure IF EXISTS `cost_of_distribution_for_month`;
DELIMITER $$
CREATE PROCEDURE `cost_of_distribution_for_month` (Month INT, Year INT)
BEGIN
SELECT 
       SUM(Distribute_cost) AS `Sum of distribution costs `
    FROM
         movies_and_tv_shows 
    WHERE
       
            MONTH(Date_of_distribution) = Month
             AND  YEAR(Date_of_distribution) = Year;
END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `most_viewed_movies`(Month INT, Day INT)
BEGIN
SELECT M.Title, (SELECT COUNT(MS.ID) FROM movies_sessions MS
WHERE MS.Movie_ID = M.ID  AND MONTH(MS.Watched_at)=Month AND  DAY(MS.Watched_at)=Day  ) AS views
FROM movies_and_tv_shows M 
WHERE M.Genre != 'TV Show'
ORDER BY views DESC  LIMIT 10;
END$$
DELIMITER ;

DROP procedure IF EXISTS `most_viewed_tv_shows`;
DELIMITER $$
USE `vsdb`$$
CREATE PROCEDURE `most_viewed_tv_shows`(Month INT, Day INT)
BEGIN
SELECT M.Title, (SELECT DISTINCT COUNT(TVS.ID) FROM tv_show_sessions TVS, tv_show_seasons TV, tv_shows_episodes TVE
WHERE TVS.TV_Show_episode_ID = TVE.ID AND TVE.Season_ID = TV.ID AND TV.TV_Show_ID = M.ID  
AND MONTH(TVS.Watched_at)=Month AND  DAY(TVS.Watched_at)=Day  ) AS views
FROM movies_and_tv_shows M 
WHERE M.Genre = 'TV Show'
ORDER BY views DESC  LIMIT 10;
END$$
DELIMITER ;

CREATE VIEW `history_of_tv_shows_view` AS
    SELECT 
        `p`.`Name` AS `Client_name`,
        `m`.`Title` AS `Movie_title`,
        `tv`.`Season_number` AS `Season_number`,
        `tve`.`Episode_Number` AS `Episode_Number`,
        `tvs`.`Watched_at` AS `Watched_at`
    FROM
        ((((`tv_show_sessions` `tvs`
        JOIN `movies_and_tv_shows` `m`)
        JOIN `profiles` `p`)
        JOIN `tv_show_seasons` `tv`)
        JOIN `tv_shows_episodes` `tve`)
    WHERE
        ((`m`.`ID` = `tv`.`TV_Show_ID`)
            AND (`tv`.`ID` = `tve`.`Season_ID`)
            AND (`tve`.`ID` = `tvs`.`TV_Show_episode_ID`)
            AND (`tvs`.`Client_ID` = `p`.`ID`));


CREATE VIEW `history_of_movies_views` AS
    SELECT 
        `p`.`Name` AS `Name_of_profile`,
        `m`.`Title` AS `Movie_title`,
        `ms`.`Watched_at` AS `Watched_at`
    FROM
        ((`movies_sessions` `ms`
        JOIN `movies_and_tv_shows` `m`)
        JOIN `profiles` `p`)
    WHERE
        ((`m`.`ID` = `ms`.`Movie_ID`)
            AND (`ms`.`Client_ID` = `p`.`ID`));


CREATE VIEW `movies_profitability` AS
    SELECT DISTINCT
        `m`.`Title` AS `Title`,
        ((SELECT 
                COUNT(`ms`.`ID`)
            FROM
                (`movies_sessions` `ms`
                JOIN `movies_and_tv_shows` `m`)
            WHERE
                (`m`.`ID` = `ms`.`Movie_ID`)) / `m`.`Distribute_cost`) AS `Movies_profability`
    FROM
        (`movies_and_tv_shows` `m`
        JOIN `movies_sessions` `ms`)
    WHERE
        (`m`.`ID` = `ms`.`Movie_ID`);


CREATE VIEW `tv_shows_profitability` AS
    SELECT DISTINCT
        `m`.`Title` AS `Title`,
        ((SELECT 
                COUNT(`tvs`.`ID`)
            FROM
                (((`tv_show_sessions` `tvs`
                JOIN `movies_and_tv_shows` `m`)
                JOIN `tv_show_seasons` `tv`)
                JOIN `tv_shows_episodes` `tve`)
            WHERE
                ((`m`.`ID` = `tv`.`TV_Show_ID`)
                    AND (`tv`.`ID` = `tve`.`Season_ID`)
                    AND (`tve`.`ID` = `tvs`.`TV_Show_episode_ID`))) / `m`.`Distribute_cost`) AS `Movies_profability`
    FROM
        (((`tv_show_sessions` `tvs`
        JOIN `movies_and_tv_shows` `m`)
        JOIN `tv_show_seasons` `tv`)
        JOIN `tv_shows_episodes` `tve`)
    WHERE
        ((`m`.`ID` = `tv`.`TV_Show_ID`)
            AND (`tv`.`ID` = `tve`.`Season_ID`)
            AND (`tve`.`ID` = `tvs`.`TV_Show_episode_ID`));
			
			
CREATE VIEW `clients_return_history` AS
     SELECT DISTINCT
        `c`.`ID` AS `Client ID`,
        `c`.`Name` AS `Client name`,
        (SELECT 
                COUNT(0)
            FROM
                `clients_logins` `cl`
            WHERE
                (`c`.`ID` = `cl`.`Client_ID`)
            GROUP BY `c`.`Name`) AS `log in times`
    FROM
        (`client_accounts` `c`
        JOIN `clients_logins` `cl`)
    WHERE
        (`c`.`ID` = `cl`.`Client_ID`)
			
			



GRANT EXECUTE ON PROCEDURE balance_for_month TO 'Accountant';
GRANT EXECUTE ON PROCEDURE cost_of_distribution_for_month TO 'Accountant';
GRANT EXECUTE ON PROCEDURE payments_for_month TO 'Accountant';

GRANT EXECUTE ON PROCEDURE most_viewed_movies TO 'Manager';
GRANT EXECUTE ON PROCEDURE most_viewed_tv_shows TO 'Manager';

