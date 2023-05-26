
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
  @API
  Scenario: [API_US35_TC01]-(1A) As an administrator, I should be able to access the relevant finding data by entering the id over the API connection .

      Given Api user sets "api/getFindingById" path parameters.
      And Sets query parameters as id 1
      And Sends GET request with Body and valid Authorization
      Then Verifies that the returned status code is 200
      Then Verifies that the response message is "Success"

  Scenario: [API_US35_TC01]-(1B) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .

    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  Scenario: [API_US35_TC01]-(1C) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .

    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  Scenario: [API_US35_TC01]-(1D) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .

    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  Scenario: [API_US35_TC01]-(2) As an administrator, I should be able to access the relevant finding data by entering the id over the API connection .

    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"



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

  Scenario: [API_US34]-(TC01_A) As an administrator I should be able to access the find list via the API link

    Given Api user sets "api/getFinding" path parameters.
    Then Sets query parameters as id 12
    And  Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  Scenario: [API_US34]-(TC01_B) As an administrator I should not be able to access the find list via the API link

    Given Api user sets "api/getFinding" path parameters.
    And Sets query parameters as id 12
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  Scenario: [API_US34]-(TC01_C) As an administrator I should be able to access the find list via the API link

    Given Api user sets "api/getFinding" path parameters.
    Then Creates an expected body with id 12, name "Refractive Errors.", description "A refractive error is a very common eye disorder. It occurs when the eye cannot clearly focus the images from the outside world. The result of refractive errors is blurred vision, which is sometimes so severe that it causes visual impairment", finding_category_id : "6", created_at : "2021-10-25 02:20:29", category : "Eye Diseases"
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "12", name "Refractive Errors.", description "A refractive error is a very common eye disorder. It occurs when the eye cannot clearly focus the images from the outside world. The result of refractive errors is blurred vision, which is sometimes so severe that it causes visual impairment", finding_category_id : "6", created_at : "2021-10-25 02:20:29", category : "Eye Diseases"

  Scenario: [API_US34]-(TC01_D) As an administrator I should be able to access the find list via the API link

    Given Api user sets "api/getFinding" path parameters.
    Then Creates an expected body with id 7, name "Rosacea", description "Rosacea (roe-ZAY-she-uh) is a common skin condition that causes blushing or flushing and visible blood vessels in your face. It may also produce small, pus-filled bumps. These signs and symptoms may flare up for weeks to months and then go away for a while. ", finding_category_id : "3", created_at : "2021-10-25 02:15:36", category : "Skin Problem"
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "7", name "Rosacea", description "Rosacea (roe-ZAY-she-uh) is a common skin condition that causes blushing or flushing and visible blood vessels in your face. It may also produce small, pus-filled bumps. These signs and symptoms may flare up for weeks to months and then go away for a while. ", finding_category_id : "3", created_at : "2021-10-25 02:15:36", category : "Skin Problem"



