Feature: US_16
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

  Scenario: [API_US30_TC01]-(1A)
            /api/getFindingCategoryById to your endpoint valid Status returned
            when sending a GET body with authorization information
            and correct data (id) that the code is 200
            and the message information in the response body is " Success " must be verified


    * Api kullanicisi "api/getFindingCategoryById" path parametreleri set eder
    * Creates a request body with id "1" parameter to get finding category data
    * Saves the response body of the POST method.
    * Verifies that the status code value is 200 in the returned response body.
    * Verifies that the message value is "Success" in the returned response body.


  Scenario: [API_US30_TC01]-(1B)
            /api/getFindingCategoryById to your endpoint invalid Status returned
            when sending a GET body containing authorization information
            and invalid data (id) the code is 403
            and the message information in the response body is " failed " must be verified



    * Api kullanicisi "api/getFindingCategoryById" path parametreleri set eder
    * Creates an INVALID request body
    * Saves the response body of the POST method.
    * Verifies that the status code value is 403 in the returned response body.
    * Verifies that the message value is "failed" in the returned response body.


  Scenario: [API_US30_TC01]-(1C)
            Inside the response body The data( id, category , created_at ) must be validated.










  @US16 @US16A
  Scenario: [API_US16_TC01]-(1A)
  /api/addBloodGroup to your endpoint valid Status returned
  when sending a POST body containing authorization information
  and correct data ( name,is _blood_group ) that the code is 200
  and the message information in the response body is " Success " must be verified

    * Api user sets "api/addBloodGroup" path parameters.
    * Creates request body as name "Jane Doe", isBloodGroup "A Rh +"
    * Sends POST request with Body and valid Authorization
    * Verifies that the returned status code is 200
    * Verifies that the response message is "Success"


  @US16 @US16B
  Scenario: [API_US16_TC01]-(1B)
  /api/addBloodGroup to your endpoint invalid Status returned
  when sending a POST body containing authorization information
  or wrong data ( name,is _blood_group ) the code is 403
  and the message information in the response body is " failed " must be verified

    * Api user sets "api/addBloodGroup" path parameters.
    * Creates an INVALID request body
    * Sends POST request with Body and invalid Authorization
    * Verifies that the returned status code is 403
    * Verifies that the response message is "failed"


  @US16 @US16C
  Scenario: [API_US16_TC01]-(1C)
  Via API of the new blood group record to be created created , via API should be verified .

    * Api user sets "api/addBloodGroup" path parameters.
    * Creates request body as name "Jane Doe", isBloodGroup "A Rh +"
    * Sends POST request with Body and valid Authorization
    * Save addid number
    * Api user sets "api/getBloodGroup" path parameters.
    * Sends GET request
    * Verifies that the blood group record created with the API has been created
    * Verifies the newly created blood group record via API.

