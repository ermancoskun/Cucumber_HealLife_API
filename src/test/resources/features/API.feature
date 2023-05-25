@API
Feature: API Tests

  Scenario: API_US35 Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given Api kullanicisi "api/getFindingById" path parametreleri set eder
    And Gecerli bilgiler ve dogru id 1 ile giris yapmak icin query parametreleri set eder
    And GET request gonderir
    Then Donen status kodunun 403 oldugunu dogrular
    Then Response message bilgisinin "Success" oldugunu dogrular





    Scenario: As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

      Given Api user sets "api/getExpenseHeadById" path parameters.
      Then  Api user sends a GET body with a correct data.
      Then Api user confirms that the returned status code is 200
      Then Api user verifies that the response message information is "Success"






