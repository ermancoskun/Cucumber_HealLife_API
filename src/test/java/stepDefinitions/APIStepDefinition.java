package stepDefinitions;

import hooks.HooksAPI;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.hamcrest.Matchers;
import org.json.JSONObject;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import utilities.API_Utils;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;

public class APIStepDefinition {
    SoftAssert softAssert = new SoftAssert();
    public static String fullPath;
    public static JSONObject reqBodyJson;
    public static JSONObject expBodyJson;
    public static Response response;
    public static String addId;
    public static JsonPath respJS;

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


    @Given("Verifies the newly created blood group record via APi.")
    public void verifies_the_newly_created_blood_group_record_via_api() {
        response
                .then()
                .assertThat()
                .body("lists.id", Matchers.hasItem(API_Utils.addId));
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
        String invalidToken2 = "ZBRqKnnTiE9iSdHVCdMPbaP44dClmz";
        System.out.println(fullPath);
        response = given()
                .spec(HooksAPI.spec)
                .header("Authorization", "Bearer " + "ZBRqKnnTiE9iSdHVCdMPbaP44dClmz")
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
        response = given().headers("Authorization",
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
        JSONObject reqbodys = new JSONObject();
        reqbodys.put("id", 77);
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + "adasdasdasdasdasdasd")
                .contentType(ContentType.JSON)
                // .header("Accept","application/json")
                .when().body(reqbodys.toString())
                .get(fullPath);
        response.prettyPrint();
    }

    @And("Sends DELETE request with Body and invalid Authorization")
    public void sendsDELETERequestWithBodyAndInvalidAuthorization() {
        String invalidToken = "JQRvVtb9uMWEaS4sth5Hj8HsA2Pvkh";
        JSONObject object = new JSONObject();
        object.put("id", addId);
        response = RestAssured.given().spec(HooksAPI.spec).
                headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .body(object.toString())
                .delete(fullPath);
        response.prettyPrint();
        Assert.assertEquals(403, response.getStatusCode());
    }

    @And("Save addid number")
    public void save_addid_number() {
        JsonPath respJP = response.jsonPath();
        addId = respJP.getString("addId");
        System.out.println("addId = " + addId);
    }


    @And("Sends GET request with invalid Authorization")
    public void sendsGETRequestWithInvalidAuthorization() {
        response = API_Utils.getRequestWithInvalidAuthorization(fullPath);


    }

    //And Creates a request body with exp_category "business" ,description "business expense" , is_active "yes", is_deleted "no" in ExpenseHead.
    @And("Creates a request body with exp_category {string} ,description {string} , is_active {string}, is_deleted {string} in ExpenseHead.")
    public void createsARequestBodyWithExp_categoryDescriptionIs_activeIs_deletedInExpenseHead(String exp_category, String description, String is_active, String is_deleted) {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("exp_category", exp_category);
        reqBodyJson.put("description", description);
        reqBodyJson.put("is_active", is_active);
        reqBodyJson.put("is_deleted", is_deleted);

        System.out.println(reqBodyJson.toString());

    }

    @Then("Verifies in the response body with exp_category {string}, description {string}, is_active {string}, is_deleted {string} in ExpenseHead.")
    public void verifiesInTheResponseBodyWithExp_categoryDescriptionIs_activeIs_deletedInExpenseHead(String exp_category, String description, String is_active, String is_deleted) {

        JsonPath jsonPath = response.jsonPath();
        assertEquals(exp_category, jsonPath.get("lists.exp_category[-1]"));
        assertEquals(description, jsonPath.get("lists.description[-1]"));
        assertEquals(is_active, jsonPath.get("lists.is_active[-1]"));
        assertEquals(is_deleted, jsonPath.get("lists.is_deleted[-1]"));

    }


    @And("Sends GET request with valid Authorization")
    public void sendsGETRequestWithValidAuthorization() {
        response = API_Utils.getRequest(fullPath);
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


    @Given("Verify that the datas are contained in the response body as {string},{string},{string}")
    public void verify_that_the_datas_are_contained_in_the_response_body_as(String rspnBody, String data, String dataValue) {
        String[] datasArr = data.split("#");
        String[] dataValuesArr = dataValue.split("#");

        for (int i = 0; i < datasArr.length; i++) {
            response
                    .then()
                    .assertThat()
                    .body(rspnBody + datasArr[i], Matchers.equalTo(dataValuesArr[i]));
            System.out.println(datasArr[i]);
            System.out.println(dataValuesArr[i]);
        }
    }


    @And("Verifies in the response body with id {string}, is visitors_purpose  {string}, description {string}, created_at {string}  must be verified .")
    public void verifiesInTheResponseBodyWithIdIsVisitors_purposeDescriptionCreated_atMustBeVerified(String id, String visitors_purpose, String description, String created_at) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists[5].id"));
        assertEquals(visitors_purpose, resJp.get("lists[5].visitors_purpose"));
        assertEquals(description, resJp.get("lists[5].description"));
        assertEquals(created_at, resJp.get("lists[5].created_at"));


    }

    @And("Verifies in the responsee body with id {string}, is visitors_ purpose  {string}, description {string}, created_at {string}  must be verified .")
    public void verifiesInTheResponseeBodyWithIdIsVisitors_PurposeDescriptionCreated_atMustBeVerified
            (String id, String visitors_purpose, String description, String created_at) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists[13].id"));
        assertEquals(visitors_purpose, resJp.get("lists[13].visitors_purpose"));
        assertEquals(description, resJp.get("lists[13].description"));
        assertEquals(created_at, resJp.get("lists[13].created_at"));
    }

    @And("Request body is:")
    public void requestBodyIs(String body) {
        reqBodyJson = new JSONObject(body);
    }


    @Then("id: of content with {string}, category : {string}, created_at : {string}, must be verified")

    public void idOfContentWithCategoryCreated_atMustBeVerified(String id, String category, String created_at) {

        //JSONObject object = response.as(JSONObject.class);
        JsonPath path = response.jsonPath();
        int dinamikId = Integer.parseInt(id) - 1;
        Assert.assertEquals(id, path.get("lists[" + dinamikId + "].id"));
        //Assert.assertNotEquals(category,path.get("lists["+dinamikId+"].category"));
        //Assert.assertNotEquals(created_at,path.get("lists["+dinamikId+"].created_at"));
        response.prettyPrint();
    }


    @And("Sends DELETE request with Body and valid Authorization")
    public void sendsDELETERequestWithBodyAndValidAuthorization() {
        response = API_Utils.deleteRequest(fullPath);
    }

    @And("Verifies in the response body with id {string}")
    public void verifiesInTheResponseBodyWithId(String id) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists.id"));
    }


    @Then("Creates an expected body with id {string}, exp_category {string},description {string} ,is_active {string}, is_deleted {string}, created_at {string}  in ExpenseHead.")
    public void createsAnExpectedBodyWithIdExp_categoryDescriptionIs_activeIs_deletedCreated_atInExpenseHead(
            String id, String exp_category, String description, String is_active, String is_deleted, String created_at) {
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
    public void verifiesInTheResponseBodyWithIdExp_categoryDescriptionIs_activeIs_deletedCreated_atInExpenseHead
            (String id, String exp_category, String description, String is_active, String is_deleted, String created_at) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("details.id"));
        assertEquals(exp_category, resJp.get("details.exp_category"));
        assertEquals(description, resJp.get("details.description"));
        assertEquals(is_active, resJp.get("details.is_active"));
        assertEquals(is_deleted, resJp.get("details.is_deleted"));
        assertEquals(created_at, resJp.get("details.created_at"));
    }

    @And("Verifies in the response body with id {string}, name {string}, description {string}, finding_category_id : {string}, created_at : {string}, category : {string} in Finding")
    public void verifiesInTheResponseBodyWithIdNameDescriptionFinding_category_idCreated_atCategoryInFinding(String id, String name, String description, String finding_category_id, String created_at, String category) {
        JsonPath respJp = response.jsonPath();
        assertEquals(id, respJp.getString("lists[6].id"));
        assertEquals(name, respJp.getString("lists[6].name"));
        assertEquals(description, respJp.getString("lists[6].description"));
        assertEquals(finding_category_id, respJp.getString("lists[6].finding_category_id"));
        assertEquals(created_at, respJp.getString("lists[6].created_at"));
        assertEquals(category, respJp.getString("lists[6].category"));
        //bu son satır mainde
    }

    @Then("Creates an expected body with id {string}, name {string}, description {string}, finding_category_id : {string}, created_at : {string}, category : {string} .")
    public void createsAnExpectedBodyWithIdNameDescriptionFinding_category_idCreated_atCategory(String id, String name, String description, String finding_category_id, String created_at, String category) {
        reqBodyJson = API_Utils.createABody(id, name, description, finding_category_id, created_at, category);
    }

    @And("Verifies in the response body with id {string}, name {string}, description {string}, finding_category_id : {string}, created_at : {string}, category : {string} in ExpenseHead.")
    public void verifiesInTheResponseBodyWithIdNameDescriptionFinding_category_idCreated_atCategory(String id, String name, String description, String finding_category_id, String created_at, String category) {

        JsonPath respJp = response.jsonPath();
        assertEquals(id, respJp.getString("lists[10].id"));
        assertEquals(name, respJp.getString("lists[10].name"));
        assertEquals(description, respJp.getString("lists[10].description"));
        assertEquals(finding_category_id, respJp.getString("lists[10].finding_category_id"));
        assertEquals(created_at, respJp.getString("lists[10].created_at"));
        assertEquals(category, respJp.getString("lists[10].category"));

    }

    @Then("Creat get request exp_category is updated be verified")
    public void creatGetRequestExp_categoryIsUpdatedBeVerified() {


        JsonPath respJp = response.jsonPath();

        Assert.assertEquals(respJp.getString("details.exp_category"), "stationary update");

    }

    @And("Creates body and Sends Patch request body valid Authorization with {string}, {string}, {string}")
    public void createsBodyAndSendsPatchRequestBodyValidAuthorizationWith(String id, String name, String
            is_blood_group) {
        reqBodyJson = API_Utils.createABody(1, "DirtBlood", "AB+");
    }


    @Given("It is verified that the id information sent is the same as the id in the patch request body")
    public void ıtIsVerifiedThatTheIdInformationSentIsTheSameAsTheIdInThePatchRequestBody() {
        response = given().spec(HooksAPI.spec).
                headers("Authorization", "Bearer " + HooksAPI.token)
                .header("Accept", "application/json")
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .patch(fullPath);
        response.prettyPrint();

    }

    @And("Creates request body as name {string}, finding_category_id {string}")
    public void createsRequestBodyAsNameFinding_category_id(String arg0, String arg1) {

        reqBodyJson = API_Utils.createABody(arg0, arg1, true);

        System.out.println(reqBodyJson.toString());

        JsonPath resJP = response.jsonPath();
        expBodyJson = new JSONObject();
        expBodyJson.put("updateId", 22);
        Assert.assertEquals(expBodyJson.get("updateId"), resJP.get("updateId"));

    }


    @Then("Has been verified that the sent addId and replied {string} data are the same.")
    public void hasBeenVerifiedThatTheSentAddIdAndRepliedDataAreTheSame(String changedData) {
        JsonPath resJP = response.jsonPath();
        String actualID = resJP.getString(changedData);
        assertEquals("Unsuccessful change", actualID, API_Utils.addId);
    }


    @Then("Verifies the newly created purpose record via APi.")
    public void verifiesTheNewlyCreatedPurposeRecordViaAPi() {
        response
                .then()
                .assertThat()
                .body("lists.id", Matchers.hasItem(addId));


    }

    @And("Create a post body in finding with name {string}, description {string} and finding_category_id {string} .")
    public void createAPostBodyInFindingWithNameDescriptionAndFinding_category_id(String name, String
            description, String finding_category_id) {
        reqBodyJson = API_Utils.createABody2(name, description, finding_category_id);
    }


    @And("Creates a request body with id {string} ,visitors_purpose {string} , description {string}")
    public void createsARequestBodyWithIdVisitors_purposeDescription(String arg0, String arg1, String arg2) {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("id", arg0);
        reqBodyJson.put("visitors_purpose", arg1);
        reqBodyJson.put("description", arg2);

        System.out.println(reqBodyJson.toString());

    }


    @And("Sets query parameters as id addID")
    public void setsQueryParametersAsIdAddID() {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("id", addId);

    }

    @And("Verifies in the response body with name {string}, description {string} and finding_category_id {string} .")
    public void verifiesInTheResponseBodyWithNameDescriptionAndFinding_category_id(String name, String
            description, String finding_category_id) {

        respJS = response.jsonPath();
        assertEquals(name, respJS.get("details.name"));
        assertEquals(description, respJS.get("details.description"));
        assertEquals(finding_category_id, respJS.get("details.finding_category_id"));
    }


    @Then("Sends PATCH request with Body and valid Authorizations")
    public void sendsPATCHRequestWithBodyAndValidAuthorizations() {
        JSONObject res = new JSONObject();
        res.put("id", "4");
        res.put("visitors_purpose", "purpose update4");

        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .body(res.toString())
                .patch(fullPath);
        response.prettyPrint();
    }

    @Then("Verifies the newly created purpose record via APis.")
    public void verifiesTheNewlyCreatedPurposeRecordViaAPis() {
        response
                .then()
                .assertThat()
                .body("lists.visitors_purpose", Matchers.hasItem("purpose update4"));
    }

    @And("Sets query parametres as relivant id")
    public void setsQueryParametresAsRelivantId() {
        reqBodyJson = new JSONObject();
        reqBodyJson.put("id", API_Utils.addId);
    }

    @And("new Request body is")
    public void newRequestBodyIs() {
        String body = "{\n" +
                "            \"id\": " + API_Utils.addId + ",\n" +
                "            \"exp_category\": \"stationary update\",\n" +
                "            \"description\": \"stationary expense\",\n" +
                "            \"is_active\": \"yes\",\n" +
                "            \"is_deleted\": \"no\"\n" +
                "} ";

        reqBodyJson = new JSONObject(body);
        System.out.println(reqBodyJson.toString());
    }

    @And("Creates body and Sends Patch request body valid Authorization with {string}, {string}, {string},{string},{string}")
    public void createsBodyAndSendsPatchRequestValidAuthorizationWith(String id, String exp_category, String description, String is_active, String is_deleted) {
        reqBodyJson = API_Utils.createABody(21, "stationary 1", "stationary expense", "yes", "no");

    }

    @And("Has been verified that the sent addIdd and replied {string} data are the same.")
    public void hasBeenVerifiedThatTheSentAddIddAndRepliedDataAreTheSame(String arg0) {
        JsonPath resJP = response.jsonPath();
        String actualID = resJP.getString(arg0);
        assertEquals("Unsuccessful change", actualID, API_Utils.addId);

    }

    @Given("Creates request body as datas : {string} values : {string}")
    public void creates_request_body_as_datas_values(String data, String dataValue) {
        String[] datasArr = data.split("#");
        String[] dataValuesArr = dataValue.split("#");
        reqBodyJson = new JSONObject();

        for (int i = 0; i < datasArr.length; i++) {
            reqBodyJson.put(datasArr[i], dataValuesArr[i]);
        }
        System.out.println(reqBodyJson);
    }
}
