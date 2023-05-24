@API
Feature: API Tests

  Scenario: 1 API_US35 Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given Api kullanicisi "api/staffList" path parametreleri set eder
    And Gecerli bilgiler ve id 1 ile giris yapmak icin query parametreleri set eder
    And GET request gonderir
    Then Donen status kodunun 200 oldugunu dogrular
    Then Response message bilgisinin "Success" oldugunu dogrular

  Scenario: 1 API_US35 Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given API user sets "api/staffList" path parameters
    And Sets query parameters as id 1 with valid Authorization
    And Sends GET request with Body
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"




