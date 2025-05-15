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
  - Corrects common typos and standardizes text fields by converting values to uppercase.
  - Fixes specific known data inconsistencies (e.g., 'georia' → 'Georgia').
  
- **Event Scheduler (`run_data_cleaning`)**:
  - Automatically triggers the stored procedure every **30 days** to refresh and clean the data regularly.

- **Trigger (`Transfer_Clean_Data`)**:
  - Ensures that every time new data is inserted into the raw table, the cleaning procedure is run immediately to keep the cleaned table up to date.

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

1. **Import the SQL script** into your MySQL database.
2. The stored procedure will create the cleaned data table and clean the data automatically.
3. The event scheduler will re-run the cleaning every 30 days.
4. The trigger keeps the cleaned table updated when new data is added.

---

## Why This Matters

Keeping data clean is critical for accurate analysis and decision-making. Automating cleaning reduces errors, saves time, and ensures consistency over time.

---

## Technologies Used

- MySQL Stored Procedures  
- Triggers and Events  
- SQL Data Cleaning Techniques  

