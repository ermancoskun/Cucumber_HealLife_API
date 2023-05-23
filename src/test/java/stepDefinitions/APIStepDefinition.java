package stepDefinitions;

import hooks.HooksAPI;
import io.cucumber.java.en.Given;
import io.restassured.response.Response;
import org.json.JSONObject;
import pojos.Pojo_RegisterCustomer;

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
}
