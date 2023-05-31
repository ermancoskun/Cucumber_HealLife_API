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

