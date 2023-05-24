Feature: API Tests

  Scenario: API_US20 Bir yönetici olarak API baglantisi üzerinden Staff List'e erisebilmeliyim.

    Given Api kullanicisi "api/opdList" path parametreleri set eder
    Then Exp data hazırlar
    Then .....Gecerli giris
    And GET request gönderildiginde dönen status code'un 200 oldugu ve response message bilgisinin "Success"


  Scenario:  API_US20 Bir yönetici olarak API baglantisi üzerinden Staff List'e erisebilmeliyim.

    Given Kullanıcı path params hazırlar
    Then Exp data hazırlar
    Then .....Gecersiz giris
    And GET request gönderildiginde dönen status code'un 403 oldugu ve response message bilgisinin "Failed"


