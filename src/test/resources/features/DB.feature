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


