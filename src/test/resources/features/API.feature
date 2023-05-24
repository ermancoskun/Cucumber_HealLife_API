@API
Feature: API Tests

  Scenario: API_US35 Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given Api kullanicisi "api/getFindingById" path parametreleri set eder
    And Gecerli bilgiler ve dogru id 1 ile giris yapmak icin query parametreleri set eder
    And GET request gonderir
    Then Donen status kodunun 403 oldugunu dogrular
    Then Response message bilgisinin "Success" oldugunu dogrular







