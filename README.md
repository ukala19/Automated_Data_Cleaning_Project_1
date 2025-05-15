# Automated_Data_Cleaning_Project_1

Automated MySQL project that cleans and maintains a U.S. household income dataset using stored procedures, scheduled events every 30 days, and triggers; ensuring clean, consistent, and up-to-date data for analysis.

## Project Overview

This project automates data cleaning for a dataset containing U.S. household income and geographic information. It uses MySQL features like **stored procedures**, **triggers**, and **events** to keep the data clean, consistent, and up-to-date with minimal manual intervention.

---

## Key Features

- **Stored Procedure (`Copy_and_Clean_Data`)**:
  - Creates a cleaned copy of the raw data table if it doesn't exist.
  - Copies data from the raw table to the cleaned table.
  - Removes duplicate rows based on `id` and `TimeStamp`.
  - Corrects spelling mistakes and makes all text UPPERCASE for consistency.
  - Fixes known issues (like 'georia' → 'Georgia').
  - **Adds a `TimeStamp` column** to track when each row was cleaned — useful for logging and audits.

- **Event Scheduler (`run_data_cleaning`)**:
  - Automatically runs the cleaning procedure every **30 days** to keep your data in tip-top shape.

- **Trigger (`Transfer_Clean_Data`)**:
  - Whenever new data is inserted into the raw table, the cleaning procedure runs instantly, so your cleaned table is always ready to use.

---

## Data Sample

| row_id | id    | State_Code | State_Name | State_ab | County         | City        | Place       | Type  | Primary | Zip_Code | Area_Code | ALand    | AWater   | Lat        | Lon         |
|--------|-------|------------|------------|----------|----------------|-------------|-------------|-------|---------|----------|-----------|----------|----------|------------|-------------|
| 1      | 1026  | 1          | Alabama    | AL       | Autauga County | Elmore      | Autaugaville| Track | Track   | 36025    | 334       | 8020338  | 60048    | 32.4473511 | -86.4768097 |
| 2      | 10216 | 1          | Alabama    | AL       | Autauga County | Robertsdale | Autaugaville| Track | Track   | 36567    | 251       | 737211648| 3860933  | 30.7200267 | -87.6245437 |
| 3      | 10226 | 1          | Alabama    | AL       | Autauga County | Silverhill  | Autaugaville| Track | Track   | 36576    | 251       | 71113244 | 190587   | 30.5345606 | -87.7548736 |
| 4      | 10236 | 1          | Alabama    | AL       | Autauga County | Orange Beach| Autaugaville| Track | Track   | 36561    | 251       | 15491986 | 20427550 | 30.3005856 | -87.5417985 |

---

## How to Use

1. **Import the CSV File**  
   First, import the `ushouseholdincome(1).csv` file into your MySQL database. This will create and fill the `ushouseholdincome_adv` table with raw data.

2. **Run the SQL Script**  
   After importing, run the SQL script from this project. It will:
   - Create a new table called `ushouseholdincome_adv_cleaned1`  
   - Copy data from the raw table into the cleaned table  
   - Clean the data by fixing typos, converting names to uppercase, fixing data types  
   - Add a `TimeStamp` column that records when each row was cleaned

3. **Automatic Cleaning Every 30 Days**  
   An event is set up to automatically clean the data every 30 days. No need to run it manually!

4. **Live Cleaning on New Data**  
   A trigger ensures that every time new data is added to the raw table, it’s immediately cleaned and pushed into the cleaned table — no delay.

---

## Why This Matters

Keeping data clean is critical for accurate analysis and decision-making. Automating the cleaning saves time, reduces errors, and keeps everything organized; especially when the dataset is big or gets frequent updates.

---

## Technologies Used

- MySQL Stored Procedures  
- MySQL Triggers & Events  
- SQL Data Cleaning Techniques  
- Timestamping for version tracking
