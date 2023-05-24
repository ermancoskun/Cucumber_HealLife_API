package stepDefinitions;

import hooks.HooksAPI;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.json.JSONObject;
import pojos.Pojo_RegisterCustomer;
import utilities.API_Utils;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;

public class APIStepDefinition {
    public static String fullPath;
    public static Pojo_RegisterCustomer reqBody;
    int basariliStatusCode=200;
    JSONObject reqBodyJson;
    Response response;
    @Given("Api kullanicisi {string} path parametreleri set eder")
    public void api_kullanicisi_path_parametreleri_set_eder(String rawPaths) {

       // HooksAPI.spec.pathParams("pp0","api","pp1","opdList");

        // api/opdList
        String[] paths=rawPaths.split("/"); // [ "api","register"]

        StringBuilder tempPath=new StringBuilder("/{");

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
        System.out.println("fullPath = " + fullPath);
    }

    @Then("Gecerli bilgiler ve dogru id {int} ile giris yapmak icin query parametreleri set eder")
    public void gecerliBilgilerVeDogruIdIleGirisYapmakIcinQueryParametreleriSetEder(int id) {

        JSONObject reqBodyJson = new JSONObject();
        reqBodyJson.put("id","1");


    }

    @Then("GET request gonderir")
    public void getRequestGonderir() {

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

    @Then("Donen status kodunun {int} oldugunu dogrular")
    public void donenStatusKodununOldugunuDogrular(int statusCode) {
        assertEquals(statusCode,response.getStatusCode());
    }

    @Then("Response message bilgisinin {string} oldugunu dogrular")
    public void responseMessageBilgisininOldugunuDogrular(String expextedStr) {
        JsonPath resJP = response.jsonPath();
        assertEquals(expextedStr,resJP.getString("message"));
    }
}
