@API
Feature: API Tests

  Scenario: API_US35 Bir yönetici olarak API baglantisi üzerinden id girerek ilgili finding verisine erisebilmeliyim.

    Given Api kullanicisi "api/getFindingById" path parametreleri set eder
    And Gecerli bilgiler ve dogru id 1 ile giris yapmak icin query parametreleri set eder
    And GET request gonderir
    Then Donen status kodunun 403 oldugunu dogrular
    Then Response message bilgisinin "Success" oldugunu dogrular




    Scenario:API_US20 As an administrator, I should be able to access the relevant expenditure data by entering the id over the
    API connection .
      1-/api/getExpenseHeadById to your endpoint valid Status returned when sending a GET body with authorization information and correct data (id)
       that the code is 200 and the message information in the response body is " Success " must be verified
      Given Api user sets "api/getExpenseHeadById" path parameters.
      Then  Api user sends a GET body with a correct data.
      Then Api user confirms that the returned status code is 200
      Then Api user verifies that the response message information is "Success"



      Scenario:API_US20 As an administrator, I should be able to access the relevant expenditure data by entering the id over the
      API connection .
        2-/api/getExpenseHeadById to your endpoint invalid Status returned when sending a GET body containing authorization information
      and invalid data (id) the code is 403 and the message information in the response body is " failed " must be verified
      Given Api user sets "api/getExpenseHeadById" path parameters.
      Then Api user creates an INVALID request body in ExpenseHead.
      Then Api user sends a GET body with an uncorrect data.
      Then Api user confirms that the returned status code is 403
      Then Api user verifies that the response message information is "failed"

     @US20
    Scenario:API_US20 As an administrator, I should be able to access the relevant expenditure data by entering the id over the
     API connection .
     3-in the response body (id, exp_category , description , is_active , is_deleted , created_at ) must be verified
     Given Api user sets "api/getExpenseHeadById" path parameters.
     Then Api user creates an expected body with  id "5", exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." , is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.
       Then  Api user sends a GET body with a correct data.
     Then Api user verifies in the response body with id "5", exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." , is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.




