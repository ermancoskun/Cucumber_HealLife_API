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




    Scenario: As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

    Scenario: [API_US20]-(TC01_A) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .


      Given Api user sets "api/getExpenseHeadById" path parameters.
      Then Sets query parameters as id 5
      And Sends GET request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"

  Scenario: [API_US20]-(TC01_B) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Sets query parameters as id 5
    And  Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @US20
  Scenario: [API_US20]-(TC01_C) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Creates an expected body with id 5, exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." ,is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "5", exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." , is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.


    Scenario: [API_US15_TC01]-(1A) As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
      Given Api user sets "/api/getBloodGroupById" path parameters.
      Then Sets query parameters as id 1
      And Sends GET request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"


  Scenario: [API_US15_TC01]-(1B)As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
    Given Api user sets "/api/getBloodGroupById" path parameters.
    And Sets query parameters as id 123456
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"


  Scenario: [API_US15_TC01]-(2)As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
    Given Api user sets "/api/getBloodGroupById" path parameters.
    Then Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "1", name "B+",is_blood_group "1" , created_at "2021-10-25 01:54:10"

    Scenario: [API_US07_TC01]-(1A) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
      Given Api user sets "/api/visitorsPurposeUpdate" path parameters.
      Then Sets query parameters as id 1
      And Sends POST request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"


  Scenario: [API_US07_TC01]-(1B) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "/api/visitorsPurposeUpdate" path parameters.
    Then Sets query parameters as id 123456
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"
  @US15
    Scenario: [API_US07_TC01]-(2) Link as an administrator registered to the system via visitor I should be able to update the purpose information .

      Given Api user sets "/api/visitorsPurposeUpdate" path parameters.
      Then Sets query parameters as id 1
      And Sends POST request with Body and valid Authorization
      And Verifies in the response body with id "1"

  Scenario: [API_US07_TC01]-(3) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "/api/visitorsPurposeUpdate" path parameters.





