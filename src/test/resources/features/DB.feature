Feature: DB_Testing

  Scenario Outline: Email query of the user whose first_name and last_name are given

    Given Database connection established
    And   From the Users table,"email" data of the user whose "<first_name>" and "<last_name>" information is entered are retrieved
    Then  User's "<email>" data is verified
    And   Database connection is closed


    Examples:
      | first_name |last_name|email|
      |  Admin     | User    |admin@gmail.com|



