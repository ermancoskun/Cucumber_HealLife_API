package utilities;

import hooks.HooksAPI;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.json.JSONObject;
import org.junit.Assert;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class API_Utils {

    private static Response response;
    public static String addId;
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

        public static Response deleteRequest (String endPoint){
            JSONObject object = new JSONObject();
            object.put("id", addId);
            response = RestAssured.given().spec(HooksAPI.spec).headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when().body(object.toString())
                    .delete(endPoint);
            response.prettyPrint();
            Assert.assertEquals(200, response.getStatusCode());

            return response;
        }
        public static Response getRequest (String endpoint){
            Response response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .get(endpoint);
            response.prettyPrint();
            return response;
        }
        public static Response getRequestWithBody (String endpoint, JSONObject reqBodyJson){
            Response response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBodyJson.toString())
                    .get(endpoint);
            response.prettyPrint();
            return response;
        }
        public static Response postRequest (String endpoint, JSONObject reqBodyJson){
            response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBodyJson.toString())
                    .post(endpoint);
            response.prettyPrint();
            JsonPath path = response.jsonPath();
            addId = path.getString("addId");
            return response;
        }

        public static Response patchRequest (String endPoint, JSONObject reqBody){
           response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBody.toString())
                    .patch(endPoint);
            response.prettyPrint();
            return response;
        }

        public static JSONObject createABody ( int id){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", id);
            return jsonObject;
        }


        public static JSONObject createABody ( int id, String name, String is_blood_group, String created_at ){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", id);
            jsonObject.put("name", name);
            jsonObject.put("is_blood_group", is_blood_group);
            jsonObject.put("created_at", created_at);
            return jsonObject;
        }


        public static JSONObject createABody ( String id, String exp_category, String description, String is_active, String
        is_deleted, String created_at ){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", id);
            jsonObject.put(" exp_category", exp_category);
            jsonObject.put("description", description);
            jsonObject.put("is_active", is_active);
            jsonObject.put("is_deleted", is_deleted);
            jsonObject.put("created_at", created_at);
            return jsonObject;
        }

    public static Response addNewRecord(String body,String endPoint){

        response = RestAssured.given().spec(HooksAPI.spec).header("Authorization","Bearer "+HooksAPI.token)
                .contentType(ContentType.JSON)
                .when().body(body)
                .post(endPoint);

        JsonPath path = response.jsonPath();

        addId = path.getString("addId");

        return response;
    }



    public static JSONObject createABody(String id){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("id",id);
        return jsonObject;
    }
    public static JSONObject createABody(String name, String is_blood_group, Boolean w){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("is_blood_group",is_blood_group);
        return jsonObject;
    }
    public static JSONObject createABody(String visitors_purpose,String description){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("visitors_purpose",visitors_purpose);
        jsonObject.put("description",description);
        return jsonObject;
    }
    public static JSONObject createABody2(String name, String description, String finding_category_id ){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("name",name);
        jsonObject.put("description",description);
        jsonObject.put("finding_category_id",finding_category_id);
        return jsonObject;
    }
    public static JSONObject createABody(int id ,String name, String is_blood_group ){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("name",name);
        jsonObject.put("is_blood_group",is_blood_group);
        return jsonObject;
    }
    public static JSONObject createABody(String id ,String name, String is_blood_group,String created_at ){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("name",name);
        jsonObject.put("is_blood_group",is_blood_group);
        jsonObject.put("created_at",created_at);
        return jsonObject;
    }
    public static JSONObject createABody(int id , String  exp_category, String description, String is_active, String is_deleted ){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put(" exp_category", exp_category);
        jsonObject.put("description",description);
        jsonObject.put("is_active",is_active);
        jsonObject.put("is_deleted",is_deleted);
        return jsonObject;



    }

    public static JSONObject createABody(int id ,String  exp_category, String description,String is_active,String is_deleted,String created_at ){
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put(" exp_category", exp_category);
        jsonObject.put("description",description);
        jsonObject.put("is_active",is_active);
        jsonObject.put("is_deleted",is_deleted);
        jsonObject.put("created_at",created_at);
        return jsonObject;
    }
    public static Response getRequestWithInvalidAuthorization(String endpoint) {

        String invalidToken=HooksAPI.token+"invalid";
        response = given().spec(HooksAPI.spec).
                headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .get(endpoint);
        response.prettyPrint();

        return response;
    }


}

