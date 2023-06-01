Feature: DB_Testing


  Scenario Outline: Email query of the user whose first_name and last_name are given

    Given Database connection established
    And From the Users table,"email" data of the user whose "<first_name>" and "<last_name>" information is entered are retrieved
    Then User's "<email>" data is verified
    And Database connection is closed


    Examples:
      | first_name | last_name | email           |
      | Admin      | User      | admin@gmail.com |



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




