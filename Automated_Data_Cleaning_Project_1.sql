#-------------- AUTOMATED DATA CLEANING PROJECT --------------#

SELECT *
FROM bakeryadv.ushouseholdincome_adv;

#-------------- CREATING A SEPARATE TABLE --------------#

CREATE TABLE IF NOT EXISTS bakeryadv.ushouseholdincome_adv_cleaned1 (
	 `row_id` int DEFAULT NULL,
	  `id` int DEFAULT NULL,
	  `State_Code` int DEFAULT NULL,
	  `State_Name` text,
	  `State_ab` text,
	  `County` text,
	  `City` text,
	  `Place` text,
	  `Type` text,
	  `Primary` text,
	  `Zip_Code` int DEFAULT NULL,
	  `Area_Code` int DEFAULT NULL,
	  `ALand` int DEFAULT NULL,
	  `AWater` int DEFAULT NULL,
	  `Lat` double DEFAULT NULL,
	  `Lon` double DEFAULT NULL,
	  `TimeStamp` TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM bakeryadv.ushouseholdincome_adv_cleaned1;

#-------------- MAIN CLEANING STORED PROCEDURE --------------#

DELIMITER $$
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data1;
CREATE PROCEDURE Copy_and_Clean_Data1()
BEGIN
	-- COPY DATA TO CLEANED TABLE
	INSERT INTO bakeryadv.ushouseholdincome_adv_cleaned1
	SELECT *, CURRENT_TIMESTAMP
	FROM bakeryadv.ushouseholdincome_adv;

	-- REMOVE DUPLICATES
	DELETE FROM bakeryadv.ushouseholdincome_adv_cleaned1
	WHERE row_id IN (
		SELECT row_id FROM (
			SELECT row_id, id,
				ROW_NUMBER() OVER (
					PARTITION BY id, TimeStamp
					ORDER BY id
				) AS row_num
			FROM bakeryadv.ushouseholdincome_adv_cleaned1
		) AS duplicates
		WHERE row_num > 1
	);

	-- DATA CLEANING UPDATES
	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET County = UPPER(County);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET City = UPPER(City);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET Place = UPPER(Place);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET State_Name = UPPER(State_Name);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET Type = 'CDP'
	WHERE Type = 'CPD';

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned1
	SET Type = 'Borough'
	WHERE Type = 'Boroughs';
END $$
DELIMITER ;

CALL Copy_and_Clean_Data1();

#-------------- CREATING ANOTHER CLEANING STORED PROCEDURE FOR TRIGGERS --------------#

DELIMITER $$
DROP PROCEDURE IF EXISTS Clean_New_Data;
CREATE PROCEDURE Clean_New_Data()
BEGIN
	-- Just run updates on the cleaned table after insert
	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET County = UPPER(County);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET City = UPPER(City);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET Place = UPPER(Place);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET State_Name = UPPER(State_Name);

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET Type = 'CDP'
	WHERE Type = 'CPD';

	UPDATE bakeryadv.ushouseholdincome_adv_cleaned
	SET Type = 'Borough'
	WHERE Type = 'Boroughs';
END $$
DELIMITER ;

CALL Clean_New_Data();

#-------------- CREATING TRIGGER --------------#

DELIMITER $$
DROP TRIGGER IF EXISTS Transfer_Clean_Data;
CREATE TRIGGER Transfer_Clean_Data
	AFTER INSERT ON bakeryadv.ushouseholdincome_adv
	FOR EACH ROW
BEGIN
	CALL Clean_New_Data();
END $$
DELIMITER ;

#-------------- CREATING EVENT FOR EVERY 30 DAYS --------------#

DROP EVENT IF EXISTS run_data_cleaning;
CREATE EVENT run_data_cleaning
	ON SCHEDULE EVERY 30 DAY
	DO CALL Copy_and_Clean_Data1();

#-------------- DEBUGGING STORED PROCEDURE WORKS --------------#

SELECT row_id, id, row_num
FROM (
	SELECT row_id, id,
		ROW_NUMBER() OVER (
			PARTITION BY id, `TimeStamp`
			ORDER BY id) AS row_num
	FROM 
		ushouseholdincome_adv_cleaned1
) duplicates
WHERE row_num > 1;

SELECT COUNT(row_id)
FROM bakeryadv.ushouseholdincome_adv_cleaned1;

SELECT State_Name, COUNT(State_Name)
FROM bakeryadv.ushouseholdincome_adv_cleaned1
GROUP BY State_Name;