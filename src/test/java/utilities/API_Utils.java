package utilities;

import hooks.HooksAPI;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.json.JSONObject;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static stepDefinitions.APIStepDefinition.fullPath;
import static stepDefinitions.APIStepDefinition.reqBodyJson;

public class API_Utils {
    public static RequestSpecification spec;
    public static String generateToken() {

        spec = new RequestSpecBuilder().setBaseUri(URI.create(ConfigReader.getProperty("base_url"))).build();
        RequestSpecification requestSpec = spec;

        Map<String, Object> expectedData = new HashMap<>();
        expectedData.put("email", ConfigReader.getProperty("email"));
        expectedData.put("password", ConfigReader.getProperty("password"));

        Response response = given().spec(requestSpec).contentType(ContentType.JSON).
                body(expectedData).when().post();

        JsonPath json = response.jsonPath();
        return json.getString("token");

    }


    public static Response getRequest(String endpoint) {

        Response response = given().headers(
                "Authorization",
                "Bearer " + HooksAPI.token,
                "Content-Type",
                ContentType.JSON,
                "Accept",
                ContentType.JSON).when().get(endpoint);
        response.prettyPrint();
        return response;
    }

    public static Response deleteRequest(String token, String endpoint){
        Response response = given().headers(
                "Authorization",
                "Bearer " + token,
                "Content-Type",
                ContentType.JSON,
                "Accept",
                ContentType.JSON).when().delete(endpoint);
        response.prettyPrint();
        return  response;
    }
    public static Response getRequestWithBody(String endpoint, JSONObject reqBodyJson){
        Response response= given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .get(endpoint);
        response.prettyPrint();
        return response;
    }
    public static  Response postRequest(String endPoint, JSONObject reqBodyJson){

        Response response=given().headers("Authorization",
                        "Bearer " + HooksAPI.token,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBodyJson.toString())
                .post(endPoint);
        response.prettyPrint();
        return response;
    }
    public  static  Response patchRequest(String endPoint,JSONObject reqBody){
     Response response=given().headers("Authorization",
                        "Bearer " + HooksAPI.token,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBody.toString()).patch(endPoint);

     response.prettyPrint();
        return  response;
    }

}
