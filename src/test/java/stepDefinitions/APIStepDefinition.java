package stepDefinitions;

import hooks.HooksAPI;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

import io.restassured.http.ContentType;

import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;

import io.restassured.response.Response;
import org.hamcrest.Matchers;
import org.json.JSONObject;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import org.w3c.dom.stylesheets.LinkStyle;
import pojos.Pojo_RegisterCustomer;
import utilities.API_Utils;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;



public class APIStepDefinition {
    SoftAssert softAssert= new SoftAssert();
    public static String fullPath;
    public static Pojo_RegisterCustomer reqBody;
    public static JSONObject reqBodyJson;
    public static JSONObject expBodyJson;
    public static Response response;
    public static String addId;

    int basariliStatusCode=200;


    @Given("Api kullanicisi {string} path parametreleri set eder")
    public void api_kullanicisi_path_parametreleri_set_eder(String rawPaths) {

        String [] paths = rawPaths.split("/"); // ["api","register"]

        StringBuilder tempPath = new StringBuilder("/{");

        for (int i = 0; i < paths.length ; i++) {

            String key = "pp" + (i+1); // pp1 pp2 pp3
            String value = paths[i].trim();

            HooksAPI.spec.pathParam(key,value);

            tempPath.append(key + "}/{");
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));


        fullPath = tempPath.toString(); // /{pp0}/{pp1}/{pp2}

        System.out.println("fullPath = " + fullPath);
    }

    @Given("Api user sets {string} path parameters.")
    public void apiUserSetsPathParameters(String rawPaths) {

        // HooksAPI.spec.pathParams("pp0","api","pp1","opdList");

        // api/opdList
        String[] paths=rawPaths.split("/"); // [ "api","register"]

        StringBuilder tempPath=new StringBuilder("{");

        for (int i = 0; i <paths.length ; i++) {
            String key="pp"+ i; //pp0 pp1 pp2
            String value=paths[i].trim(); //solunda sagında bosluk varsa silmek icibn trim kulandık
            HooksAPI.spec.pathParam(key,value);
            tempPath.append(key +"}/{");
            System.out.println("value = " + value);
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));

        fullPath=tempPath.toString();
    }




    @Then("Gecerli bilgiler ve dogru id {int} ile giris yapmak icin query parametreleri set eder")
    public void gecerliBilgilerVeDogruIdIleGirisYapmakIcinQueryParametreleriSetEder(int id) {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("id",id);
    }

    @Then("GET request gonderir")
    public void getRequestGonderir() {
        response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                .when()
                     .body(reqBodyJson.toString())
                     .get(fullPath);
        response.prettyPrint();
    }

    @Then("Donen status kodunun {int} oldugunu dogrular")
    public void donenStatusKodununOldugunuDogrular(int statusCode) {
        assertEquals("Wrong status code",statusCode,response.getStatusCode());
    }

    @Then("Response message bilgisinin {string} oldugunu dogrular")
    public void responseMessageBilgisininOldugunuDogrular(String expextedStr) {
        JsonPath resJP = response.jsonPath();
        assertEquals(expextedStr,resJP.getString("message"));

    }

    @Given("exp data")
    public void exp_data() {

        /*
             {
             "status": 200,
             "message": "Success",
             "Token_remaining_time": 353,
             "details": {
             "id": "1",
             "category": "Fever",
             "created_at": "2021-10-25 02:02:48"
                }
              }
         */

        JSONObject details=new JSONObject();
        details.put("id","1");
        details.put("category","Fever");
        details.put("created_at","2021-10-25 02:02:48");

        expBodyJson=new JSONObject();
        expBodyJson.put("status",200);
        expBodyJson.put("message","Success");
        expBodyJson.put("Token_remaining_time",353);
        expBodyJson.put("details",details);

    }











    @Given("Creates a request body with the name {string}, isBloodGroup {string} parameters to create Blood Group Data")
    public void creates_a_request_body_with_the_name_is_blood_group_parameters_to_create_blood_group_data(String name, String bloodGroup) {
        reqBodyJson=new JSONObject();
        reqBodyJson.put("name",name);
        reqBodyJson.put("is_blood_group",bloodGroup);

        System.out.println(reqBodyJson.toString());
    }
    @Given("Saves the response body of the POST method.")
    public void saves_the_response_body_of_the_post_method() {

        response= given()
                .spec(HooksAPI.spec)
                .header("Authorization","Bearer "+HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .post(fullPath);

        response.prettyPrint();
    }
    @Given("Verifies that the status code value is {int} in the returned response body.")
    public void verifies_that_the_status_code_value_is_in_the_returned_response_body(int statusCode) {
        softAssert.assertEquals(response.getStatusCode(),statusCode,"Status code value is NOT 200");
    }
    @Given("Verifies that the message value is {string} in the returned response body.")
    public void verifies_that_the_message_value_is_in_the_returned_response_body(String message) {
        JsonPath respJS= response.jsonPath();
        softAssert.assertEquals(message,respJS.getString("message"));
    }


    @Given("Creates an INVALID request body")
    public void creates_an_invalid_request_body() {
        reqBodyJson=new JSONObject();
        reqBodyJson.put("ID","name");

    }

    @Given("Access all blood group data with GET method")
    public void access_all_blood_group_data_with_get_method() {
        response= given()
                .spec(HooksAPI.spec)
                .header("Authorization","Bearer "+HooksAPI.token)

                .contentType(ContentType.JSON)
                .when()
                .get(fullPath);


        // response.prettyPrint();

    }


    @Given("Verifies that the blood group record created with the API has been created")
    public void verifies_that_the_blood_group_record_created_with_the_api_has_been_created() {

        response
                .then()
                .assertThat()
                .body("lists[.id",Matchers.hasItem(addId));

    }

    public void addAndSaveAddIdNumber(){
        creates_a_request_body_with_the_name_is_blood_group_parameters_to_create_blood_group_data("Jane Doe", "0 Rh +");
        saves_the_response_body_of_the_post_method();
        JsonPath respJS= response.jsonPath();
        addId= respJS.getString("addId");
        System.out.println("addId :" + addId);
    }

    @Given("Creates a request body with id {string} parameter to get finding category data")
    public void creates_a_request_body_with_id_parameter_to_get_finding_category_data(String id) {
        reqBodyJson=new JSONObject();
        reqBodyJson.put("id",id);
    }


    @Then("Api user sends a GET body with a correct data.")
    public void apiUserSendsAGETBodyWithACorrectData() {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("id","5");
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + HooksAPI.token)
                .header("Accept","application/json")
                .contentType("application/json")
                .when()
                .body(reqBodyJson.toString())
                .get(fullPath);
        response.prettyPrint();

    }


    @Then("Api user confirms that the returned status code is {int}")
    public void apiUserConfirmsThatTheReturnedStatusCodeIs(int statusCode) {
        assertEquals(statusCode,response.getStatusCode());
    }

    @Then("Api user verifies that the response message information is {string}")
    public void apiUserVerifiesThatTheResponseMessageInformationIs(String expectedStr) {
        JsonPath resJP = response.jsonPath();
        assertEquals(expectedStr,resJP.getString("message"));
    }
}
