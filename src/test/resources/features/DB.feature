Feature: DB_Testing


  @DB06 @dg
  Scenario: DB_US06
    * User sets the database connection
    * Creates query with "SELECT date FROM heallife_hospitaltraining.appointment_queue WHERE YEAR(date) = 2023 AND MONTH(date) = 5;"
    * Verifies that it CONTAINS datas : "date" values : "2023-05" message : "false"
    * Database connection is closed

  @DB16 @dg
  Scenario: DB_US16
    * User sets the database connection
    * Creates query with "SELECT guardian_name FROM heallife_hospitaltraining.death_report WHERE death_date =( SELECT MAX(death_date)  FROM heallife_hospitaltraining.death_report );"
    * Verifies that datas : "guardian_name" values : "Kane Stark" message : "false"
    * Database connection is closed

  @DB26 @dg
  Scenario: DB_US26
    * User sets the database connection
    * Creates query with "SELECT known_allergies FROM heallife_hospitaltraining.patients WHERE created_at =( SELECT MIN(created_at) FROM heallife_hospitaltraining.patients );"
    * Verifies that datas : "known_allergies" values : "Fast food" message : "false"
    * Database connection is closed


  Scenario: DB_US10 List the sibling babies in the birth_report table on the database and verify their names.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.birth_report where father_name = 'Mahesh'"
    * Verifies that datas : "child_name#child_name#child_name" values : "Rohit#Reyana#child" message : "Was not siblings"
    * Database connection is closed

  Scenario: DB_US20 Verify that data can be deleted from the events table via the database.
    * User sets the database connection
    * Creates query with ""
    * Verifies that datas : "" values : "" message : ""
    * Database connection is closed

  Scenario: DB_US30 Verify that the name of the visitor who came to visit Maria Fernandis from the data in the visitors_book table on the database is Jhon.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.visitors_book where name = 'Jhon' and related_to = 'Maria Fernandis (4) (OPDN24)'"
    * Verifies that datas : "name" values : "Jhon" message : "false"
    * Database connection is closed


  Scenario:
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.birth_report WHERE weight >= 2.5;"
    * Verifies that the result number of query is 6
    * Database connection is closed

  @ay
  Scenario:
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.department"
    * Verifies that datas belowed
      | Admin,2021-10-25 00:52:21              |
      | BURN CARE,2021-10-25 00:55:11          |
      | Blood Bank,2021-10-25 00:53:07         |
      | Cardiology,2021-10-25 00:54:54         |
      | Doctor,2021-10-25 00:51:22             |
      | Emergency,2021-10-25 00:54:42          |
      | Finance,2021-10-25 00:54:22            |
      | Gynecology,2021-10-25 00:54:10         |
      | Human Resource,2021-10-25 00:53:59     |
      | ICU,2021-10-25 00:52:55                |
      | IPD,2021-10-25 00:52:34                |
      | NICU,2021-10-25 00:56:13               |
      | Nursing Department,2021-10-25 03:02:57 |
      | OPD,2021-10-25 00:52:38                |
      | OT,2021-10-25 00:50:49                 |
      | Pathology,2021-10-25 00:53:20          |
      | Pharmacy,2021-10-25 00:53:33           |
      | Radiology,2021-10-25 00:53:27          |
      | Reception,021-10-25 00:53:46           |
    * Database connection is closed

  Scenario: DB_US04 In the appointment table on the database, verify that the appointments made for the morning are less than the appointments for the afternoon.

    * User sets the database connection
    * Creates query with "SELECT IF(ogleden_once_sayisi < ogleden_sonra_sayisi, 'true', 'false') AS sonuc FROM ( SELECT (SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) < '12:00:00') AS ogleden_once_sayisi,(SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) >= '12:00:00') AS ogleden_sonra_sayisi) AS counts;"
    * Verify that the appointments made for the morning are less than the appointments for the afternoon
    * Database connection is closed

  Scenario: DB_US14 Sort the data in the charges table via the database from smallest to largest, and verify the first 5 (100, 100,100,110,120).

    * User sets the database connection
    * Creates query with "SELECT standard_charge FROM heallife_hospitaltraining.charges ORDER BY standard_charge ASC LIMIT 5;"
    * Verify the first five
      | 100 |
      | 100 |
      | 100 |
      | 110 |
      | 120 |
    * Database connection is closed

  Scenario: DB_US24 It should be verified that multiple data entries can be made to the nurse_note table through the database.

    * User sets the database connection
    * Creates update query with "INSERT INTO heallife_hospitaltraining.nurse_note (date, ipd_id, staff_id, note, comment, updated_at) VALUES ('2022-05-01', 1, 15, 'deneme text', 'new comment', '2023-05-30 20:50');"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.nurse_note;"
    # * Verifies that it CONTAINS datas : "note" values : "deneme text" message : "false"
    * It should be verified that multiple data entries can be made
    * Database connection is closed

  @said
  Scenario: DB_US01 Verify that the patient with patient_id = 1 in the ambulance call table on the database has been dispatched 2 times by the ambulance whose driver is Smith.

    * User sets the database connection
    * Creates query with "select patient_id, driver from heallife_hospitaltraining.ambulance_call where patient_id=1 and driver = 'Smith';"
    * Verify that number of result is two
    * Database connection is closed

  Scenario: DB_US21 List the IDs of the X-RAY laboratories from the laboratories in the lab table. Verify that the largest of the ids is (3) by the database.
    * User sets the database connection
    * Creates query with "SELECT max(id) AS max_id FROM heallife_hospitaltraining.lab WHERE lab_name LIKE '%X-RAY%';"
    * Verify that max id is three
    * Database connection is closed

  Scenario: DB_US11 Verify on the database that the donor_name of the donor with id= 7 in the blood_donor table is Maria, date_of_birth=2001-03-02, gender=Female, father_name=Jhonson, address=England.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.blood_donor where id=7;"
    * Verifies that datas : "donor_name#date_of_birth#gender#father_name#address" values : "Maria#2001-03-02#Female#Jhonson#England" message : "invalid data"
