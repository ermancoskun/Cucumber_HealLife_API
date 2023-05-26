package stepDefinitions;

import hooks.HooksAPI;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;

import io.restassured.response.Response;
import org.hamcrest.Matchers;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import org.w3c.dom.stylesheets.LinkStyle;
import pojos.Pojo_RegisterCustomer;
import utilities.API_Utils;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;



public class APIStepDefinition {
    SoftAssert softAssert = new SoftAssert();
    public static String fullPath;
    public static Pojo_RegisterCustomer reqBody;
    public static JSONObject reqBodyJson;
    public static JSONObject expBodyJson;
    public static Response response;
    public static String addId;

    int basariliStatusCode = 200;
    String message;


    @Given("Api kullanicisi {string} path parametreleri set eder")
    public void api_kullanicisi_path_parametreleri_set_eder(String rawPaths) {

        String[] paths = rawPaths.split("/"); // ["api","register"]

        StringBuilder tempPath = new StringBuilder("/{");

        for (int i = 0; i < paths.length; i++) {

            String key = "pp" + (i + 1); // pp1 pp2 pp3
            String value = paths[i].trim();

            HooksAPI.spec.pathParam(key, value);

            tempPath.append(key + "}/{");
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));


        fullPath = tempPath.toString(); // /{pp0}/{pp1}/{pp2}

        System.out.println("fullPath = " + fullPath);
    }

    @Given("Api user sets {string} path parameters.")
    public void apiUserSetsPathParameters(String rawPaths) {

        // api/opdList
        String[] paths = rawPaths.split("/"); // [ "api","register"]

        StringBuilder tempPath = new StringBuilder("/{");

        for (int i = 0; i < paths.length; i++) {
            String key = "pp" + i; //pp0 pp1 pp2
            String value = paths[i].trim(); //solunda sagında bosluk varsa silmek icibn trim kulandık
            HooksAPI.spec.pathParam(key, value);
            tempPath.append(key + "}/{");
            System.out.println("value = " + value);
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));

        fullPath = tempPath.toString();
    }


    @Given("Creates a request body with the name {string}, isBloodGroup {string} parameters to create Blood Group Data")
    public void creates_a_request_body_with_the_name_is_blood_group_parameters_to_create_blood_group_data(String name, String bloodGroup) {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("name", name);
        reqBodyJson.put("is_blood_group", bloodGroup);

        System.out.println(reqBodyJson.toString());
    }

    @Given("Saves the response body of the POST method.")
    public void saves_the_response_body_of_the_post_method() {

        response = given()
                .spec(HooksAPI.spec)
                .header("Authorization", "Bearer " + HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .post(fullPath);

        response.prettyPrint();
    }

    @Given("Verifies that the status code value is {int} in the returned response body.")
    public void verifies_that_the_status_code_value_is_in_the_returned_response_body(int statusCode) {
        softAssert.assertEquals(response.getStatusCode(), statusCode, "Status code value is NOT " + statusCode);
    }

    @Given("Verifies that the message value is {string} in the returned response body.")
    public void verifies_that_the_message_value_is_in_the_returned_response_body(String message) {
        JsonPath respJS = response.jsonPath();
        softAssert.assertEquals(message, respJS.getString("message"));
    }


    @Given("Creates an INVALID request body")
    public void creates_an_invalid_request_body() {
        reqBodyJson = API_Utils.createABody(99);

    }

    @Given("Access all blood group data with GET method")
    public void access_all_blood_group_data_with_get_method() {
        response = given()
                .spec(HooksAPI.spec)
                .header("Authorization", "Bearer " + HooksAPI.token)

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
                .body("lists[.id", Matchers.hasItem(addId));

    }

    public void addAndSaveAddIdNumber() {
        creates_a_request_body_with_the_name_is_blood_group_parameters_to_create_blood_group_data("Jane Doe", "0 Rh +");
        saves_the_response_body_of_the_post_method();
        JsonPath respJS = response.jsonPath();
        addId = respJS.getString("addId");
        System.out.println("addId :" + addId);
    }

    @Given("Creates a request body with id {string} parameter to get finding category data")
    public void creates_a_request_body_with_id_parameter_to_get_finding_category_data(int id) {
        reqBodyJson = API_Utils.createABody(id);
    }


    @Then("Verifies that the returned status code is {int}")
    public void verifiesThatTheReturnedStatusCodeIs(int statusCode) {
        softAssert.assertEquals(response.getStatusCode(), statusCode, "Status code value is NOT " + statusCode);

    }

    @Then("Verifies that the response message is {string}")
    public void verifiesThatTheResponseMessageIs(String message) {
        JsonPath respJS = response.jsonPath();
        softAssert.assertEquals(respJS.getString("message"), message, "Returned message is not true");
    }


    @And("Sets query parameters as id {int}")
    public void setsQueryParametersAsId(int id) {
        reqBodyJson = API_Utils.createABody(id);

    }

    @And("Sends GET request with Body and valid Authorization")
    public void sendsGETRequestWithBodyAndValidAuthorization() {
        response = API_Utils.getRequestWithBody(fullPath, reqBodyJson);
    }

    @And("Sends GET request with Body with invalid Authorization")
    public void sendsGETRequestWithBodyWithInvalidAuthorization() {
        String invalidToken = "H3h3VhOQvXU8Ql83V6kgSeKQ6hREZk";
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .get(fullPath);
        response.prettyPrint();
    }

    @Given("Sends POST request with Body and valid Authorization")
    public void sends_post_request_with_body_and_valid_authorization() {
        response = API_Utils.postRequest(fullPath, reqBodyJson);
    }

    @And("Sends POST request with Body and invalid Authorization")
    public void sendsPOSTRequestWithBodyAndInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        Response response = given().headers("Authorization",
                        "Bearer " + invalidToken,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBodyJson.toString())
                .post(fullPath);
        response.prettyPrint();
    }

    @And("Sends PATCH request with Body and valid Authorization")
    public void sendsPATCHRequestWithBodyAndValidAuthorization() {
        response = API_Utils.patchRequest(fullPath, reqBodyJson);
    }

    @And("Sends PATCH request with Body and invalid Authorization")
    public void sendsPATCHRequestWithBodyAndInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        Response response = given().headers("Authorization",
                        "Bearer " + invalidToken,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBodyJson.toString())
                .patch(fullPath);
        response.prettyPrint();
    }

    @And("Sends DELETE request with Body and valid Authorization")
    public void sendsDELETERequestWithBodyAndValidAuthorization() {
        response = API_Utils.deleteRequest(fullPath, reqBodyJson);
    }

    @And("Sends DELETE request with Body and invalid Authorization")
    public void sendsDELETERequestWithBodyAndInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        Response response = given().headers("Authorization",
                        "Bearer " + invalidToken,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBodyJson.toString())
                .body(reqBodyJson)
                .delete(fullPath);
        response.prettyPrint();
    }


    @Then("Creates an expected body with id {int}, exp_category {string},description {string} ,is_active {string}, is_deleted {string}, created_at {string}  in ExpenseHead.")
    public void createsAnExpectedBodyWithIdExp_categoryDescriptionIs_activeIs_deletedCreated_atInExpenseHead(int id, String exp_category, String description, String is_active, String is_deleted, String created_at) {
        reqBodyJson = API_Utils.createABody(id, exp_category, description, is_active, is_deleted, created_at);
      /*
        {
    "status": 200,
    "message": "Success",
    "Token_remaining_time": 25,
    "details": {
        "id": "5",
        "exp_category": "Power Generator Fuel Charge",
        "description": "They can utilise a variety of fuel options including natural gas, LPG and diesel.",
        "is_active": "yes",
        "is_deleted": "no",
        "created_at": "2021-10-29 01:35:42"
    }
}
         */
    }

    @And("Verifies in the response body with id {string}, exp_category {string},description {string} , is_active {string}, is_deleted {string}, created_at {string}  in ExpenseHead.")
    public void verifiesInTheResponseBodyWithIdExp_categoryDescriptionIs_activeIs_deletedCreated_atInExpenseHead(String id, String exp_category, String description, String is_active, String is_deleted, String created_at) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("details.id"));
        assertEquals(exp_category, resJp.get("details.exp_category"));
        assertEquals(description, resJp.get("details.description"));
        assertEquals(is_active, resJp.get("details.is_active"));
        assertEquals(is_deleted, resJp.get("details.is_deleted"));
        assertEquals(created_at, resJp.get("details.created_at"));
    }

    @And("Verifies in the response body with id {string}, name {string},is_blood_group {string} , created_at {string}")
    public void verifiesInTheResponseBodyWithIdNameIs_blood_groupCreated_at(String id, String name, String is_blood_group, String created_at) {


        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists.id"));
        assertEquals(name, resJp.get("lists.name"));
        assertEquals(is_blood_group, resJp.get("lists.is_blood_group"));
        assertEquals(created_at, resJp.get("lists.details.created_at"));
    }

    @And("Verifies in the response body with id {string}")
    public void verifiesInTheResponseBodyWithId(String id) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists.id"));
    }

    @Then("Verifies in the response body with id {string}, name {string},description {string} , finding_category_id {string}, created_at {string}, category {string}  in ExpenseHead.")
    public void resverifiesInTheResponseBodyWithIdNameDescriptionFinding_category_idCreated_atCategoryInExpenseHead(String id, String name, String description, String finding_category_id, String created_at, String category) {
        JsonPath respJp = response.jsonPath();
        assertEquals(id, respJp.getString("details.id"));
        assertEquals(name, respJp.getString("details.name"));
        assertEquals(description, respJp.getString("details.description"));
        assertEquals(finding_category_id, respJp.getString("details.finding_category_id"));
        assertEquals(created_at, respJp.getString("details.created_at"));
        assertEquals(category, respJp.getString("details.category"));
    }

    @And("Sends GET request with valid Authorization")
    public void sendsGETRequestWithValidAuthorization() {
        response = API_Utils.getRequest(fullPath);
    }

    @And("Creates an expected body with id {int}, is visitors_ purpose  {string}, description {string}, created_at {string}")
    public void createsAnExpectedBodyWithIdIsVisitors_PurposeDescriptionCreated_at(int id, String
            visitors_purpose, String description, String creat_at) {
        JSONObject data1 = new JSONObject();
        data1.put("id", "19");
        data1.put("visitors_purpose", "feridun bey");
        data1.put("description", "bayram 123 111");
        data1.put("created_at", "2023-04-12 08:34:56");

        JSONObject data2 = new JSONObject();
        data2.put("status", 200);
        data2.put("message", "Success");
        data2.put("Token_remaining_time", 871);

        JSONArray jsonArray = new JSONArray();
        jsonArray.put(data1);

        JSONObject finalData = new JSONObject();
        finalData.put("lists", jsonArray);
        finalData.put("otherData", data2);

        System.out.println(finalData.toString());
    }


    @And("Verifies in the response body with id {string}, is visitors_ purpose  {string}, description {string}, created_at {string}  must be verified .")
    public void verifiesInTheResponseBodyWithIdIsVisitors_PurposeDescriptionCreated_atMustBeVerified(String id, String visitors_purpose, String description, String created_at) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists[6].id"));
        assertEquals(visitors_purpose, resJp.get("lists[6].visitors_purpose"));
        assertEquals(description, resJp.get("lists[6].description"));
        assertEquals(created_at, resJp.get("lists[6].created_at"));
    }


    @And("Sends GET request valid Authorization")
    public void sendsGETRequestValidAuthorization() {
        response = API_Utils.getRequest(fullPath);
    }


    @And("Sends GET request invalid Authorization")
    public void sendsGETRequestInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .get(fullPath);
        response.prettyPrint();
    }

    @Then("Verifies that the returned status codee is {int}")
    public void verifiesThatTheReturnedStatusCodeeIs(int arg0) {
        Assert.assertTrue(message.contains("403"));


    }

    @And("Sends GET request with invalid Authorization")
    public void sendsGETRequestWithInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        response = given().spec(HooksAPI.spec).
                headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .get(fullPath);
        response.prettyPrint();


    }


    @Then("Verifies in the response body with id {string}, name {string}, is_blood_group {string}, created_at {string}")
    public void verifiesInTheeResponseBodyWithIdNameIs_blood_groupCreated_at(String id, String name, String is_blood_group, String created_at) {
        JsonPath respJp = response.jsonPath();
        assertEquals(id,respJp.get("lists.[2].id"));
        assertEquals(name,respJp.get("lists.[2].name"));
        assertEquals(is_blood_group,respJp.get("lists.[2].is_blood_group"));
        assertEquals(created_at,respJp.get("lists.[2].created_at"));



    }

    @Given("Get query is generated with valid information")
    public void getQueryIsGeneratedWithValidInformation() {

        response= given()
                .spec(HooksAPI.spec)
                .header("Authorization","Bearer "+HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .get(fullPath);


    }


}


