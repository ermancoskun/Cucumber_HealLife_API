@API
Feature: API Tests
  #Scenario: isimlendirme notasyonu [API_US35_TC01]-(1A) pozitif negatif senaryolar icin 1A ve 1B yazılabilir
  # Hepimiz path parametrelerini "Api user sets "endpointler" path parameters." yazarak baslayalim
  # Eger get request ile id gondereceksek "Sets query parameters as id 1 with valid Authorization" yazarak devam edelim
  # Body ile ID gonderilecekse "Sends GET request with Body"
  # Status code testleri icin "Verifies that the returned status code is 200"
  # Response daki message testi icin "Verifies that the response message is "Success"
  # Body oluşturulacak ise API_Utils'deki createABody() metoduna parametre girilerek olusturulur
  #      And Sends GET request with Body and valid Authorization
  #      And Sends GET request with Body with invalid Authorization
  #      And Sends POST request with Body and valid Authorization
  #      And Sends POST request with Body and invalid Authorization
  #      And Sends PATCH request with Body and valid Authorization
  #      And Sends PATCH request with Body and invalid Authorization
  #      And Sends DELETE request with Body and valid Authorization
  #      And Sends DELETE request with Body and invalid Authorization

  Scenario: [API_US35_TC01]-(1A) Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

      Given Api user sets "api/staffList" path parameters.
      And Sets query parameters as id 1
      And Sends GET request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"

  Scenario: [API_US35_TC01]-(1B) Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given Api user sets "api/staffList" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"


    Scenario: [API_US20]-(TC01_A) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

      Given Api user sets "api/getExpenseHeadById" path parameters.
      Then Sets query parameters as id 5
      And Sends GET request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"

    Scenario: [API_US06_TC01







