Feature: API Tests
  #Scenario: isimlendirme notasyonu [API_US35_TC01]-(1A) pozitif negatif senaryolar icin 1A ve 1B yazılabilir
  # Hepimiz path parametrelerini "Api user sets "endpointler" path parameters." yazarak baslayalim
  # Eger get request ile id gondereceksek "Sets query parameters as id 1 with valid Authorization" yazarak devam edelim
  # Body ile ID gonderilecekse "Sends GET request with Body"
  # Status code testleri icin "Verifies that the returned status code is 200"
  # Response daki message testi icin "Verifies that the response message is "Success"
  # Body oluşturulacak ise API_Utils'deki createABody() metoduna parametre girilerek olusturulur
  # ******STEPLERIMIZDE ASAGIDAKI GHERKIN IFADELERI KULLANALIM***************************************************
  #      And Sends GET request with Body and valid Authorization
  #      And Sends GET request with Body with invalid Authorization
  #      And Sends POST request with Body and valid Authorization
  #      And Sends POST request with Body and invalid Authorization
  #      And Sends PATCH request with Body and valid Authorization
  #      And Sends PATCH request with Body and invalid Authorization
  #      And Sends DELETE request with Body and valid Authorization
  #      And Sends DELETE request with Body and invalid Authorization
  #      And Sends GET request valid Authorization
  #      And Sends GET request invalid Authorization

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

  @API
  Scenario: [API_US35_TC01]-(2) As an administrator, I should be able to access the relevant finding data by entering the id over the API connection .

    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"
    Then Verifies in the response body with id "1", name "Stomach pain",description "Typhoid fever and paratyphoid fever have similar symptoms̵. People usually have a sustained fever (one that doesn’t come and go) that can be as high as 103–104°F (39–40°C)." , finding_category_id "2", created_at "2021-10-25 02:05:10", category "Typhidot (or Widal Test)"  in ExpenseHead.
   # Then Verifies in the response body with id "7", name "",description "null" , finding_category_id "null", created_at "2023-05-25 12:08:07", category "null"  in ExpenseHead.

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






@said
  Scenario: [API_US14_TC01]-(1A)  As an administrator, I should be able to access the
  blood group list with valid authorization registered in the system via API connection.

    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"



  Scenario:[API_US14_TC01]-(1B)  As an administrator, I should be able to access the blood group list with
  invalid authorization registered in the system via API connection.

    Given Api user sets "api/getBloodGroup" path parameters.
    And  Sends GET request with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @US14
  Scenario: [API_US14]-(TC01_C)  As an administrator, I should be able to verify the
  content of blood group list registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies in the response body with id "3", name "AB-", is_blood_group "1", created_at "2021-10-25 02:32:41"

  Scenario: [API_US14]-(TC01_D)  As an administrator, I should be able to verify
  the content of blood group list registered in the system via API connection.

    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with Body and valid Authorization
    Then Verifies in the response body with id "8", name "O+", is_blood_group "1", created_at "2021-10-25 02:33:28"

  Scenario Outline: [API_US14]-(TC01_C)  As an administrator, I should be able to verify the content of blood group
  list registered in the system via API connection.

    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with Body and valid Authorization
    Then Verifies in the response body with "<id>" , "<name>" , "<is_blood_group>" , "<created_at>"

    Examples:
      | id | name | is_blood_group | created_at          |
      | 3  | AB-  | 1              | 2021-10-25 02:32:41 |
      | 8  | O+   | 1              | 2021-10-25 02:33:28 |



  Scenario: [API_US04]-(TC01_A) Visitor via API connection as an administrator purpose List I should be able to reach .
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Sends GET request valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  Scenario: [API_US04]-(TC01_B) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .

    Given Api user sets "api/visitorsPurposeList" path parameters.
    And  Sends GET request invalid Authorization
    Then Verifies that the returned status codee is 403
    Then Verifies that the response message is "Forbidden"
  @API
  Scenario: [API_US04]-(TC01_C)
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Sends GET request valid Authorization
    And Verifies in the response body with id "19", is visitors_ purpose  "feridun bey", description "bayram 123 111", created_at "2023-04-12 08:34:56"  must be verified .

  Scenario: [API_US04]-(TC01_D)

    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Creates an expected body with id 29, is visitors_ purpose  "special work", description "special word details"", created_at ""2023-05-18 17:00:26"
    And Sends GET request valid Authorization
    And Verifies in the response body with id "29", is visitors_ purpose  "special work", description "special word details"", created_at ""2023-05-18 17:00:26""  must be verified .

  Scenario: [API_US29->TC01] /api/getFindingCategory to your endpoint valid a GET request with authorization information status when sent the code is 200 and the response the message information is " Success " should be verified .

    Then Api kullanicisi "api/getFindingCategory" path parametreleri set eder
    Given Get query is generated with valid information
    And Verifies that the returned status code is 200
    And Verifies that the response message is "Success"

  Scenario: [API_US29->TC02] /api/getFindingCategory to your endpoint invalid A GET Request with authorization information status when sent that the code is 403 and the response the message information is " failed " must be verified

    Given Api kullanicisi "api/getFindingCategory" path parametreleri set eder
    Then Sends GET request invalid Authorization
    Then Verifies that the returned status codee is 403



  Scenario: [API_US19->TC01]-(1A) As an administrator to hospital expenses via API connection I should be able to reach .

    Given Api user sets "api/getExpenseHead" path parameters.
    Then Sends GET request valid Authorization
    And Verifies that the returned status code is 200
    And Verifies that the response message is "Success"






  Scenario: [API_US19->TC01]-(1B) As an administrator to hospital expenses via API connection I should be able to reach .
     Given Api user sets "api/getExpenseHead" path parameters.
     Then Sends GET request invalid Authorization
     Then Verifies that the returned status code is 403
     Then Verifies that the response message is "failed"


  Scenario:[API_US19->TC02] As an administrator to hospital expenses via API connection I should be able to reach .

