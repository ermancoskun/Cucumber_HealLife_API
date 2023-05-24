Feature: US_16


  Scenario: 1 Bir yönetici olarak API baglantisi üzerinden yeni bir kan grubu olusturabilmek istiyorum.
            /api/addBloodGroup endpoint'ine gecerli authorization bilgileri ve
            dogru datalar (name,is_blood_group) iceren bir POST body gönderildiginde
            dönen status code'in 200 oldugu ve response body'deki message bilgisinin "Success" oldugu dogrulanmali

    * Api kullanicisi "api/addBloodGroup" path parametreleri set eder
    * Creates a request body with the name "Jane Doe", isBloodGroup "A Rh +" parameters to create Blood Group Data
    * Saves the response body of the POST method.
    * Verifies that the status code value is 200 in the returned response body.
    * Verifies that the message value is "Success" in the returned response body.


  Scenario: 2 /api/addBloodGroup endpoint'ine gecersiz authorization bilgileri
            veya yanlis datalar (name,is_blood_group) iceren bir POST body gönderildiginde
            dönen status code'in 403 oldugu ve response body'deki message bilgisinin "failed" oldugu dogrulanmali

    * Api kullanicisi "api/addBloodGroup" path parametreleri set eder
    * Creates an INVALID request body
    * Saves the response body of the POST method.
    * Verifies that the status code value is 403 in the returned response body.
    * Verifies that the message value is "failed" in the returned response body.



  Scenario: 3 API uzerinden olusturulmak istenen yeni kan grubu kaydinin olustugu, API uzerinden dogrulanmali.

    * Api kullanicisi "api/getBloodGroup" path parametreleri set eder
    * Access all blood group data with GET method
    * Verifies that the blood group record created with the API has been created




  Scenario: 1
  /api/getFindingCategoryById endpoint'ine gecerli authorization bilgileri
  ve dogru data (id) iceren bir GET body gönderildiginde dönen status code'in 200 oldugu
  ve response body'deki message bilgisinin "Success" oldugu dogrulanmali


    * Api kullanicisi "api/getFindingCategoryById" path parametreleri set eder
    * Creates a request body with id "1" parameter to get finding category data
    * Saves the response body of the POST method.
    * Verifies that the status code value is 200 in the returned response body.
    * Verifies that the message value is "Success" in the returned response body.


  Scenario: 2
  /api/getFindingCategoryById endpoint'ine gecersiz authorization bilgileri
  ve gecersiz data (id) iceren bir GET body gönderildiginde dönen status code'in 403 oldugu
  ve response body'deki message bilgisinin "failed" oldugu dogrulanmali



    * Api kullanicisi "api/getFindingCategoryById" path parametreleri set eder
    * Creates an INVALID request body
    * Saves the response body of the POST method.
    * Verifies that the status code value is 403 in the returned response body.
    * Verifies that the message value is "failed" in the returned response body.


  Scenario: 3
  Response body icindeki datalar(id, category, created_at) dogrulanmali.