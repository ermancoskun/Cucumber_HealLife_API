@ALL
Feature: API Tests
  #Scenario: isimlendirme notasyonu [API_US35_TC01]-(1A) pozitif negatif senaryolar icin 1A ve 1B yazılabilir
  # Hepimiz path parametrelerini "Api user sets "endpointler" path parameters." yazarak baslayalim
  # Eger get request ile id gondereceksek "Sets query parameters as id 1 with valid Authorization" yazarak devam edelim
  # Body ile ID gonderilecekse "Sends GET request with Body"
  # Status code testleri icin "Verifies that the returned status code is 200"
  # Response daki message testi icin "Verifies that the response message is "Success"
  # Body oluşturulacak ise API_Utils'deki createABody() metoduna parametre girilerek olusturulur
  # ******STEPLERIMIZDE ASAGIDAKI GHERKIN IFADELERI KULLANALIM***************************************************
  #      Given Api user sets "api/visitorsPurposeList" path parameters.
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
  #      Then Verifies that the returned status code is 200
  #      Then Verifies that the response message is "Success"
  #      And Sets query parameters as id 1  (body sadece id den olusuyorsa)

  @Get
  Scenario: [API_US35_TC01]-(1A) As an administrator, I should be able to access the relevant finding data by entering the id over the API connection .
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US35_TC01]-(1B) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US35_TC01]-(1C) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US35_TC01]-(1D) As an administrator, I should not be able to access the relevant finding data by entering the id over the API connection .
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @GetEx
  Scenario: [API_US35_TC01]-(2) As an administrator, I should be able to access the relevant finding data by entering the id over the API connection .
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"
    Then Verify that the datas are contained in the response body as "details.","id#name#description#finding_category_id#created_at#category","1#Stomach pain#Typhoid fever and paratyphoid fever have similar symptoms̵. People usually have a sustained fever (one that doesn’t come and go) that can be as high as 103–104°F (39–40°C).#2#2021-10-25 02:05:10#ill category 2"


  @Get
  Scenario: [API_US20]-(TC01_A) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Sets query parameters as id 5
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US20]-(TC01_B) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Sets query parameters as id 5
    And  Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US20]-(TC01_C) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Creates an expected body with id "5", exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." ,is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "5", exp_category "Power Generator Fuel Charge",description "They can utilise a variety of fuel options including natural gas, LPG and diesel." , is_active "yes", is_deleted "no", created_at "2021-10-29 01:35:42"  in ExpenseHead.


  @Get
  Scenario: [API_US14_TC01]-(1A)  As an administrator, I should be able to access the
  blood group list with valid authorization registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US34]-(1A) As an administrator I should be able to access the find list via the API link
    Given Api user sets "api/getFinding" path parameters.
    Then Sets query parameters as id 12
    And  Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US34]-(1B) As an administrator I should not be able to access the find list via the API link
    Given Api user sets "api/getFinding" path parameters.
    And Sets query parameters as id 12
    And  Sends GET request with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US15_TC01]-(1A) As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
    Given Api user sets "api/getBloodGroupById" path parameters.
    Then Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US15_TC01]-(1B)As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
    Given Api user sets "api/getBloodGroupById" path parameters.
    And Sets query parameters as id 123456
    And Sends GET request invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"


  @Get
  Scenario: [API_US34]-(1C) As an administrator I should be able to access the find list via the API link
    Given Api user sets "api/getFinding" path parameters.
    And Request body is:
    """
    {
            "id": "12",
            "name": "Refractive Errors.",
            "description": "A refractive error is a very common eye disorder. It occurs when the eye cannot clearly focus the images from the outside world. The result of refractive errors is blurred vision, which is sometimes so severe that it causes visual impairment",
            "finding_category_id": "6",
            "created_at": "2023-06-01 08:31:00",
            "category": "Eye Diseases"
        }
    """
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "12", name "Refractive Errors.", description "A refractive error is a very common eye disorder. It occurs when the eye cannot clearly focus the images from the outside world. The result of refractive errors is blurred vision, which is sometimes so severe that it causes visual impairment", finding_category_id : "6", created_at : "2023-06-01 08:31:00", category : "Eye Diseases" in ExpenseHead.

  @Get
  Scenario: [API_US34]-(1D) As an administrator I should be able to access the find list via the API link
    Given Api user sets "api/getFinding" path parameters.
    Then Creates an expected body with id "7", name "Rosacea", description "Rosacea (roe-ZAY-she-uh) is a common skin condition that causes blushing or flushing and visible blood vessels in your face. It may also produce small, pus-filled bumps. These signs and symptoms may flare up for weeks to months and then go away for a while.", finding_category_id : "3", created_at : "2023-05-26 09:36:06", category : "" .
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with id "7", name "Rosacea", description "Rosacea (roe-ZAY-she-uh) is a common skin condition that causes blushing or flushing and visible blood vessels in your face. It may also produce small, pus-filled bumps. These signs and symptoms may flare up for weeks to months and then go away for a while.", finding_category_id : "3", created_at : "2023-05-26 09:36:06", category : "" in Finding

  @Post
  Scenario: [API_US06]-(1A) A new visitor via API link as an administrator purpose registration I want to be able to create .
    Given Api user sets "api/visitorsPurposeAdd" path parameters.
    And Request body is:
    """
  {
    "visitors_purpose":"refakat",
    "description":"ekstra refakatci ihtiyaci"
  }
    """
    Then Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Post
  Scenario: [API_US06]-(1B) A new visitor via API link as an administrator purpose registration I want to be able to create .
    Given Api user sets "api/visitorsPurposeAdd" path parameters.
    And Request body is:
    """
  {
    "visitors_purpose":"ozel sebep",
    "description":"ekstra ozel bir durum"
  }
    """
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @GetEx
  Scenario: [API_US15_TC01]-(2)As an administrator, I should be able to access the relevant blood data by entering the id over the API connection .
    Given Api user sets "api/getBloodGroupById" path parameters.
    Then Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    And Verify that the datas are contained in the response body as "lists.","id#name#is_blood_group#created_at","1#DirtBlood#0#2023-05-27 07:39:47"

  @Post
  Scenario: [API_US06]-(1C) A new visitor via API link as an administrator purpose registration I want to be able to create .
    Given Api user sets "api/visitorsPurposeAdd" path parameters.
    And Request body is:
    """
  {
    "visitors_purpose":"Special Help Need",
    "description":"Special Help Need by Specialist"
  }
    """
    Then Sends POST request with Body and valid Authorization
    Then Save addid number
    Then Api user sets "api/visitorsPurposeList" path parameters.
    Then Sends GET request valid Authorization
    Then Verifies the newly created purpose record via APi.


  @Patch
  Scenario: [API_US07_TC01]-(1A) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "api/visitorsPurposeUpdate" path parameters.
    And Creates a request body with id "27" ,visitors_purpose "purpose update" , description "purpose update details"
    And Sends PATCH request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Patch
  Scenario: [API_US07_TC01]-(1B) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "api/visitorsPurposeUpdate" path parameters.
    And Creates a request body with id "123456" ,visitors_purpose "alo" , description "aloo"
    And Sends PATCH request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Patch
  Scenario: [API_US07_TC01]-(2) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "api/visitorsPurposeAdd" path parameters.
    And Request body is:
   """
   {
    "visitors_purpose":"special work",
    "description":"special word details"
   }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/visitorsPurposeUpdate" path parameters.
    And Sets query parametres as relivant id
    And  Sends PATCH request with Body and valid Authorization
    And Has been verified that the sent addIdd and replied "updateId" data are the same.


  @Patch
  Scenario: [API_US07_TC01]-(3) Link as an administrator registered to the system via visitor I should be able to update the purpose information .
    Given Api user sets "api/visitorsPurposeUpdate" path parameters.
    And Creates a request body with id "27" ,visitors_purpose "purpose update" , description "purpose update details"
    And Sends PATCH request with Body and valid Authorizations
    Then Api user sets "api/visitorsPurposeList" path parameters.
    Then Sends GET request valid Authorization
    Then Verifies the newly created purpose record via APis.

  @Get
  Scenario: [API_US14_TC01]-(1A)  As an administrator, I should be able to access the blood group list with valid authorization registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario:[API_US14_TC01]-(1B)  As an administrator, I should be able to access the blood group list with invalid authorization registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And  Sends GET request with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US14_TC01]-(1C)  As an administrator, I should be able to verify the content of blood group list registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verify that the datas are contained in the response body as "lists[2].","id#name#is_blood_group#created_at","3#AB-#1#2021-10-25 02:32:41"
  #  Then Verifies in the response body with id "3", name "AB-", is_blood_group "1", created_at "2021-10-25 02:32:41"


  @Get
  Scenario: [API_US14_TC01]-(1D)  As an administrator, I should be able to verify the content of blood group list registered in the system via API connection.
    Given Api user sets "api/getBloodGroup" path parameters.
    And Sends GET request with valid Authorization
    Then Verify that the datas are contained in the response body as "lists[7].","id#name#is_blood_group#created_at","8#O+#1#2021-10-25 02:33:28"
#   Then Verifies in the response body with id "8", name "O+", is_blood_group "1", created_at "2021-10-25 02:33:28"


  @Get
  Scenario: [API_US04]-(TC01_A) Visitor via API connection as an administrator purpose List I should be able to reach .
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Sends GET request valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US04_TC01]-(1B) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And  Sends GET request invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US04_TC01]-(2) As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Sends GET request valid Authorization
    And Verifies in the response body with id "19", is visitors_purpose  "feridun bey", description "bayram 123 111", created_at "2023-04-12 08:34:56"  must be verified .

  @Get
  Scenario: [API_US04_TC01]-(3)  As an administrator, I should be able to access the relevant expenditure data by entering the id over the API connection .
    Given Api user sets "api/visitorsPurposeList" path parameters.
    And Sends GET request valid Authorization
    And Verifies in the responsee body with id "29", is visitors_ purpose  "special work", description "special word details", created_at "2023-05-18 17:00:26"  must be verified .

  @Get
  Scenario: [API_US29->TC01] /api/getFindingCategory to your endpoint valid a GET request with authorization information status when sent the code is 200 and the response the message information is " Success " should be verified .
    Then Api user sets "api/getFindingCategory" path parameters.
    Given Sends GET request valid Authorization
    And Verifies that the returned status code is 200
    And Verifies that the response message is "Success"

  @Get
  Scenario: [API_US29->TC02] /api/getFindingCategory to your endpoint invalid A GET Request with authorization information status when sent that the code is 403 and the response the message information is " failed " must be verified
    Given Api user sets "api/getFindingCategory" path parameters.
    Then Sends GET request invalid Authorization
    Then Verifies that the returned status code is 403

  @Get
  Scenario: [API_US29->TC03] inside the response body list content (id: of content with "1" category : "Fever", created_at : "2021-10-25 02:02:48" ) must be verified.
    Given Api user sets "api/getFindingCategory" path parameters.
    Given Sends GET request valid Authorization
    Then id: of content with "1", category : "Fever", created_at : "2021-10-25 02:02:48", must be verified

  @Get
  Scenario: [API_US29->TC04] Response body icindeki list icerigi (id:"2" olan icerigin category: "Typhidot (or Widal Test)", created_at: "2021-10-25 02:03:35"   oldugu) dogrulanmali.
    Given Api user sets "api/getFindingCategory" path parameters.
    Given Sends GET request valid Authorization
    Then id: of content with "2", category : "Typhidot (or Widal Test)", created_at : "2021-10-25 02:03:35", must be verified

  @Get
  Scenario: [API_US29->TC05] Response body icindeki list icerigi (id:"2" olan icerigin category: "Typhidot (or Widal Test)", created_at: "2021-10-25 02:03:35"   oldugu) dogrulanmali.
    Given Api user sets "api/getFindingCategory" path parameters.
    Given Sends GET request valid Authorization
    Then id: of content with "2", category : "Skin Problem", created_at : "2021-10-25 02:14:41", must be verified

  @Delete
  Scenario: [API_US23->TC01] /api/deleteExpenseHead to your endpoint valid Status returned when sending a DELETE body with authorization information and correct data (id) that the code is 200 and the message information in the response body is " Success " must be verified
    Given Api user sets "api/addExpenseHead" path parameters.
    And Request body is:
    """
    {
            "exp_category": "stationary",
            "description": "stationary expense",
            "is_active": "yes",
            "is_deleted": "no"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteExpenseHead" path parameters.
    And Sends DELETE request with Body and valid Authorization

  @Post
  Scenario: [API_US37_TC01](1A) As an administrator, you can make a new finding via API connection . registration I want to be able to creat
    Given Api user sets "api/addFinding" path parameters.
    And Create a post body in finding with name "Humeyra U", description "headache" and finding_category_id "25" .
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Post
  Scenario: [API_US37_TC01](1B) As an administrator, you can make a new finding via API connection . registration I want to be able to creat
    Given Api user sets "api/addFinding" path parameters.
    And Create a post body in finding with name "Hume", description "headache56" and finding_category_id "2" .
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Post
  Scenario: [API_US37_TC01](1C) As an administrator, you can make a new finding via API connection . registration I want to be able to creat
    Given Api user sets "api/addFinding" path parameters.
    And Create a post body in finding with name "Dogrulama", description "deneme" and finding_category_id "2" .
    And Sends POST request with Body and valid Authorization
    And Save addid number
    Given Api user sets "api/getFindingById" path parameters.
    And Sets query parameters as id addID
    And Sends GET request with Body and valid Authorization
    And Verifies in the response body with name "Dogrulama", description "deneme" and finding_category_id "2" .

  @Delete
  Scenario: [API_US23->TC02] /api/deleteExpenseHead to your endpoint invalid Status returned when sending a DELETE body containing authorization information or wrong data (id) the code is 403 and the message information in the response body is " failed " must be verified
    Given Api user sets "api/addExpenseHead" path parameters.
    And Request body is:
    """
    {
            "exp_category": "stationary",
            "description": "stationary expense",
            "is_active": "yes",
            "is_deleted": "no"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteExpenseHead" path parameters.
    And Sends DELETE request with Body and invalid Authorization

  @Delete
  Scenario: [API_US23->TC03] inside the response body of deletedId info /api/deleteExpenseHead delete sent to endpoint It is the same as the id information in the request body . should be verified .
    Given Api user sets "api/addExpenseHead" path parameters.
    And Request body is:
    """
    {
            "exp_category": "stationary",
            "description": "stationary expense",
            "is_active": "yes",
            "is_deleted": "no"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteExpenseHead" path parameters.
    And Sends DELETE request with Body and valid Authorization

  @Post
  Scenario: [API_US16_TC01]-(1A) /api/addBloodGroup to your endpoint valid Status returned
  when sending a POST body containing authorization information
  and correct data ( name,is _blood_group ) that the code is 200
  and the message information in the response body is " Success " must be verified
    * Api user sets "api/addBloodGroup" path parameters.
    * Creates request body as datas : "name#is_blood_group" values : "Jane Doe#A Rh +"
    * Sends POST request with Body and valid Authorization
    * Verifies that the returned status code is 200
    * Verifies that the response message is "Success"


  @Post
  Scenario: [API_US16_TC01]-(1B) /api/addBloodGroup to your endpoint invalid Status returned
  when sending a POST body containing authorization information
  or wrong data ( name,is _blood_group ) the code is 403
  and the message information in the response body is " failed " must be verified
    * Api user sets "api/addBloodGroup" path parameters.
    * Creates request body as datas : "id" values : "9999"
    * Sends POST request with Body and invalid Authorization
    * Verifies that the returned status code is 403
    * Verifies that the response message is "failed"


  @Get
  Scenario: [API_US16_TC01]-(1C) Via API of the new blood group record to be created created , via API should be verified .
    * Api user sets "api/addBloodGroup" path parameters.
    * Creates request body as datas : "name#is_blood_group" values : "Jane Doe#A Rh +"
    * Sends POST request with Body and valid Authorization
    * Api user sets "api/getBloodGroup" path parameters.
    * Sends GET request valid Authorization
    * Verifies the newly created blood group record via APi.


  @Get
  Scenario: [API_US30_TC01]-(1A) /api/getFindingCategoryById to your endpoint valid Status returned
  when sending a GET body with authorization information
  and correct data (id) that the code is 200
  and the message information in the response body is " Success " must be verified
    * Api user sets "api/getFindingCategoryById" path parameters.
    * Creates request body as datas : "id" values : "1"
    * Sends GET request with Body and valid Authorization
    * Verifies that the returned status code is 200
    * Verifies that the response message is "Success"


  @Get
  Scenario: [API_US30_TC01]-(1B) /api/getFindingCategoryById to your endpoint invalid Status returned
  when sending a GET body containing authorization information
  and invalid data (id) the code is 403
  and the message information in the response body is " failed " must be verified
    * Api user sets "api/getFindingCategoryById" path parameters.
    * Creates request body as datas : "id" values : "9999"
    * Sends GET request with Body with invalid Authorization
    * Verifies that the returned status code is 403
    * Verifies that the response message is "failed"

  @GetEx
  Scenario: [API_US30_TC01]-(1C) Inside the response body The data ( id, category , created_at ) must be validated.
    * Api user sets "api/getFindingCategoryById" path parameters.
    * Creates request body as datas : "id" values : "1"
    * Sends GET request with Body and valid Authorization
    * Verify that the datas are contained in the response body as "details.","id#category#created_at","1#ill category 2#2023-05-25 09:33:53"

  @Patch
  Scenario: [API_US22_TC01]-(1A) Being able to update the expenditure information registered in the system via API connection as an administrator. I want..
    Given Api user sets "api/updateExpenseHead" path parameters.
    And Creates body and Sends Patch request body valid Authorization with "id", "exp category", "description","is_active","is_deleted"
    And Sends PATCH request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Patch
  Scenario: [API_US22_TC01]-(1B) Being able to update the expenditure information registered in the system via API connection as an administrator. I want..
    Given Api user sets "api/updateExpenseHead" path parameters.
    And Sends PATCH request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"


  @Patch
  Scenario: [API_US22_TC01]-(2) Being able to update the expenditure information registered in the system via API connection as an administrator. I want..
    Given Api user sets "api/updateExpenseHead" path parameters.
    And Request body is:
    """
    {
            "id": 22,
            "exp_category": "stationary 1",
            "description": "stationary expense",
            "is_active": "yes",
            "is_deleted": "no"
    }
    """
    Then It is verified that the id information sent is the same as the id in the patch request body


  @Patch
  Scenario: [API_US22_TC01]-(3)Being able to update the expenditure information registered in the system via API connection as an administrator. I want..
    Given Api user sets "api/addExpenseHead" path parameters.
    And Request body is:
   """
    {
            "exp_category": "stationary",
            "description": "stationary expense",
            "is_active": "yes",
            "is_deleted": "no"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/updateExpenseHead" path parameters.
    And new Request body is
    And  Sends PATCH request with Body and valid Authorization
    And  Api user sets "api/getExpenseHeadById" path parameters.
    And Sets query parametres as relivant id
    And  Sends GET request with Body and valid Authorization
    Then Creat get request exp_category is updated be verified

  @Delete
  Scenario: [API_US18_TC01]-(1) As an administrator, I should be able to delete the blood group record in the system via the API link .
    Given Api user sets "api/addBloodGroup" path parameters.
    And Request body is:
    """
    {
            "name": "Metot yolluyom duyuyonnu",
            "is_blood_group": "2"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteBloodGroup" path parameters.
    And Sends DELETE request with Body and valid Authorization

  @Get
  Scenario: [API_US25_TC01]-(1A) As an administrator, I should be able to access the relevant announcement data by entering the id over the API connection.
    Given Api user sets "api/getNoticeById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US25_TC01]-(1B) As an administrator, I should not be able to access the relevant announcement data by entering the id over the API connection.
    Given Api user sets "api/getNoticeById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US25_TC01]-(1C) As an administrator, I should not be able to access the relevant announcement data by entering the id over the API connection.
    Given Api user sets "api/getNoticeById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US25_TC01]-(1D) As an administrator, I should not be able to access the relevant announcement data by entering the id over the API connection.
    Given Api user sets "api/getNoticeById" path parameters.
    And Sets query parameters as id 9999999
    And Sends GET request with Body with invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @GetEx
  Scenario: [API_US25_TC01]-(2) As an administrator, I should be able to access the relevant announcement data by entering the id over the API connection.
    Given Api user sets "api/getNoticeById" path parameters.
    And Sets query parameters as id 1
    And Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"
    Then Verify that the datas are contained in the response body as "lists","id#type#slug#url#title#date#event_start#event_end#event_venue#description#is_active#created_at#meta_title#meta_description#meta_keyword#feature_image#publish_date#publish#sidebar","1#banner#null#null#Banner Images#null#null#null#null#null#no#2018-07-13 13:27:19#####0000-00-00#0#0"

  @Patch
  Scenario: [API_US17_TC01]-(1A) As an administrator, I should be able to update the blood information registered in the system via the API connection .
    Given Api user sets "api/updateBloodGroup" path parameters.
    And Creates body and Sends Patch request body valid Authorization with "id", "name", "is _blood_group"
    And Sends PATCH request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Patch
  Scenario: [API_US17_TC01]-(1B) As an administrator, I should not be able to update the blood information registered in the system via the API connection .
    Given Api user sets "api/updateBloodGroup" path parameters.
    And Sends PATCH request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Patch
  Scenario: [API_US17_TC01]-(2) As an administrator, I should be able to verify the blood information registered in the system via the API connection .
    Given Api user sets "api/updateBloodGroup" path parameters.
    And Creates body and Sends Patch request body valid Authorization with "id", "name", "is _blood_group"
    And Sends PATCH request with Body and valid Authorization
    Given It is verified that the id information sent is the same as the id in the patch request body

  @Patch
  Scenario: [API_US17_TC01]-(3) As an administrator, I should be able to verify the blood information registered in the system via the API connection .
    Given Api user sets "api/updateBloodGroup" path parameters.
    And Creates body and Sends Patch request body valid Authorization with "id", "name", "is _blood_group"
    And Sends PATCH request with Body and valid Authorization
    Given It is verified that the id information sent is the same as the id in the patch request body

  @Delete
  Scenario: [API_US18_TC01]-(2) As an administrator, I should not be able to delete the blood group record in the system via the API link .
    Given Api user sets "api/addBloodGroup" path parameters.
    And Request body is:
    """
    {
            "name": "Metot yolluyom duyuyonnu",
            "is_blood_group": "2"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteBloodGroup" path parameters.
    And Sends DELETE request with Body and invalid Authorization

  @Get
  Scenario: [API_US19->TC01]-(1A) As an administrator to hospital expenses via API connection I should be able to reach .
    Given Api user sets "api/getExpenseHead" path parameters.
    Then Sends GET request valid Authorization
    And Verifies that the returned status code is 200
    And Verifies that the response message is "Success"

  @Post
  Scenario: [API_US21_TC01]-(1A) As an administrator, I want to be able to create a new expense with valid
  Authorization over the API connection .
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Post
  Scenario: [API_US21_TC01]-(1B) As an administrator, I want to be able to create a new expense with invalid
  Authorization over the API connection .
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Post
  Scenario: [API_US21_TC01]-(1C) As an administrator, I want to be able to verify via API of the new expense record
  to be created with valid Authorization.
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"
    And Sends GET request valid Authorization


  @Get
  Scenario: [API_US19->TC01]-(1B) As an administrator to hospital expenses via API connection I should be able to reach .
    Given Api user sets "api/getExpenseHead" path parameters.
    Then Sends GET request invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario:[API_US19->TC02] As an administrator to hospital expenses via API connection I should be able to reach.
    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Sets query parameters as id 5
    Then Sends GET request with Body and valid Authorization
    And Verify that the datas are contained in the response body as "details.","id#exp_category#description#is_active#is_deleted#created_at","5#Power Generator Fuel Charge#They can utilise a variety of fuel options including natural gas, LPG and diesel.#yes#no#2021-10-29 01:35:42"

  @Get
  Scenario:[API_US19->TC03] As an administrator to hospital expenses via API connection I should be able to reach.
    Given Api user sets "api/getExpenseHeadById" path parameters.
    Then Sets query parameters as id 4
    Then Sends GET request with Body and valid Authorization
    And Verify that the datas are contained in the response body as "details.","id#exp_category#description#is_active#is_deleted#created_at","4#Telephone Bill#Recently, some private insurance companies have begun to pay for patient-to-provider phone calls, especially when the calls are prolonged and when medical decisions are made. Nevertheless, you may be billed for the whole cost, or you may have to pay a co-pay.#yes#no#2021-10-29 01:36:02"

  @Patch
  Scenario:[API_US38->TC01]-(1A) Registered to the system via API connection as an administrator I should be able to update the finding information .
    Given Api user sets "api/updateFinding" path parameters.
    Then Sets query parameters as id 1
    And Sends PATCH request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Patch
  Scenario:[API_US38->TC01]-(1B) Registered to the system via API connection as an administrator I should be able to update the finding information .
    Given Api user sets "api/updateFinding" path parameters.
    And Sets query parameters as id 123456
    And Sends PATCH request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @PatchEx2
  Scenario:[API_US38->TC02] As an administrator to hospital expenses via API connection I should be able to reach .
    Given Api user sets "api/updateFinding" path parameters.
    Then Sets query parameters as id 81
    And  Sends PATCH request with Body and valid Authorization
    And Verify that the datas are contained in the response body as "","updateId","81"

  @PatchEx
  Scenario:[API_US38->TC03] As an administrator to hospital expenses via API connection I should be able to reach .
    Given Api user sets "api/updateFinding" path parameters.
    And Creates request body as name "mouth sore", finding_category_id "2"
    And Sends PATCH request with Body and valid Authorization
    And Save addid number
    And Api user sets "api/updateFinding" path parameters.
    And Sends GET request valid Authorization
    And Verifies the newly created blood group record via APi.

  @Post
  Scenario: [API_US21_TC01]-(1A) As an administrator, I want to be able to create a new expense with valid
  Authorization over the API connection .
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"

  @Get
  Scenario: [API_US21_TC01]-(1B) As an administrator, I want to be able to create a new expense with invalid
  Authorization over the API connection .
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 403
    Then Verifies that the response message is "failed"

  @Get
  Scenario: [API_US21_TC01]-(1C) As an administrator, I want to be able to verify via API of the new expense record
  to be created with valid Authorization.
    Given Api user sets "api/addExpenseHead" path parameters.
    And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response message is "Success"
    And Api user sets "api/getExpenseHead" path parameters.
    And Sends GET request valid Authorization
    Then Verifies in the response body with exp_category "business", description "business expense", is_active "yes", is_deleted "no" in ExpenseHead.

  @Delete
  Scenario: [API_US18_TC01]-(3) It is verified that the delete ID information and the endpoint sent ID information are the same.
    Given Api user sets "api/addBloodGroup" path parameters.
    And Request body is:
    """
    {
            "name": "Metot yolluyom duyuyonnu",
            "is_blood_group": "2"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteBloodGroup" path parameters.
    And Sends DELETE request with Body and valid Authorization
    Then Has been verified that the sent addId and replied "deletedId" data are the same.

  @Delete
  Scenario: [API_US18_TC01]-(4) It is verified via API that the blood group record to be deleted via API is deleted.
    Given Api user sets "api/addBloodGroup" path parameters.
    And Request body is:
    """
    {
            "name": "Metot yolluyom duyuyonnu",
            "is_blood_group": "2"
    }
    """
    Then Sends POST request with Body and valid Authorization
    Given Api user sets "api/deleteBloodGroup" path parameters.
    And Sends DELETE request with Body and valid Authorization
    And Sets query parametres as relivant id
    Then Sends GET request with Body and valid Authorization
    Then Verifies that the returned status code is 403

