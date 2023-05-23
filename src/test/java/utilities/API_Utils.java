package utilities;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class API_Utils {
    public static RequestSpecification spec;
    public static String generateToken() {

        spec = new RequestSpecBuilder().setBaseUri(URI.create("https://xyz.com/api/login")).build();
        RequestSpecification requestSpec = spec;

        Map<String, Object> expectedData = new HashMap<>();
        expectedData.put("email", "test@test.com");
        expectedData.put("password", "123123123");

        Response response = given().spec(requestSpec).contentType(ContentType.JSON).
                body(expectedData).when().post();

        JsonPath json = response.jsonPath();

        return json.getString("token");

    }


    public static Response getRequest(String token, String endpoint) {

        Response response = given().headers(
                "Authorization",
                "Bearer " + token,
                "Content-Type",
                ContentType.JSON,
                "Accept",
                ContentType.JSON).when().get(endpoint);


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
        return  response;
    }

}
