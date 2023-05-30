Feature: DB_Testing

  Scenario Outline: Email query of the user whose first_name and last_name are given

    Given Database connection established
    And From the Users table,"email" data of the user whose "<first_name>" and "<last_name>" information is entered are retrieved
    Then User's "<email>" data is verified
    And Database connection is closed


    Examples:
      | first_name |last_name|email|
      |  Admin     | User    |admin@gmail.com|


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