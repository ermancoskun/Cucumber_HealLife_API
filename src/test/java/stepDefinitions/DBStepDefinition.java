package stepDefinitions;

import java.sql.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import utilities.DB_Utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import static org.junit.Assert.assertTrue;
import static utilities.DB_Utils.*;

public class DBStepDefinition {

    ResultSet resultset;
    Statement statement;
    Connection connection;
    String query;
    SoftAssert softAssert =new SoftAssert();
    List<Object> UserEmailList = new ArrayList<>();

    @Given("Database connection established")
    public void database_connection_established() {
        createConnection();
    }

    @Given("From the Users table,{string} data of the user whose {string} and {string} information is entered are retrieved")
    public void from_the_users_table_data_of_the_user_whose_and_information_is_entered_are_retrieved(String email, String firstName, String lastName) {
        String query = "SELECT email FROM u480337000_tlb_training.users where first_name='" + firstName + "' and last_name= '" + lastName + "';";
        UserEmailList = getColumnData(query, email);
    }

    @Then("User's {string} data is verified")
    public void user_s_data_is_verified(String email) {
        assertTrue(UserEmailList.get(0).equals(email));

    }

    @Then("Database connection is closed")
    public void database_connection_is_closed() {
        closeConnection();
    }

    @Given("User sets the database connection")
    public void user_sets_the_database_connection() {
        createConnection();
    }

    @Given("Creates query with {string}")
    public void creates_query_with(String query) throws SQLException {
        this.query = query;
        resultset = getStatement().executeQuery(query);
    }

    @Given("Verifies that datas : {string} values : {string} message : {string}")
    public void verifies_that_datas_values_message(String actualValueColumn, String expectedValue, String message) throws SQLException {

        String[] columnsArr = actualValueColumn.split("#");
        String[] valuesArr = expectedValue.split("#");
        for (int i = 1; i <= columnsArr.length; i++) {
            resultset.absolute(i);
            Assert.assertEquals(message,resultset.getString(columnsArr[i-1]), valuesArr[i-1]);
        }
    }

    @Given("Verifies that it CONTAINS datas : {string} values : {string} message : {string}")
    public void verifies_that_it_contains_datas_values_message(String actualValueColumn, String expectedValue, String message) throws SQLException {

        // bu stepte CONTAINS asserti yapılıyor, assertEquals icin ayrı method var.

        String[] columnsArr = actualValueColumn.split("#");
        String[] valuesArr = expectedValue.split("#");

        resultset.absolute(0);
        for (int i = 0; i < columnsArr.length; i++) {


            while (resultset.next()){
                Assert.assertTrue(message,resultset.getString(columnsArr[i]).contains(valuesArr[i]));
            }
        }
    }
    @Given("Verifies that the result number of query is {int}")
    public void verifies_that_the_result_number_of_query_is(int sayi) throws Exception {
        int actualData= DB_Utils.getRowCount();
        Assert.assertEquals("Wrong number",sayi,actualData);
    }

    @Given("Verifies that datas belowed")
    public void verifies_that_datas_belowed(List<String> allList) throws SQLException {
      List<Object> actualDepList= getColumnData(query,"department_name");
      List<Object> actualDateList=getColumnData(query,"created_at");
      Map<Object,Object> actualMap=new HashMap<>();
      Map<Object,Object> expMap=new HashMap<>();
        System.out.println("actualDepList = " + actualDepList);
        System.out.println("actualDateList = " + actualDateList);
        System.out.println("allList = " + allList);
        for (int i = 0; i <actualDepList.size()-1 ; i=i+2) {
            actualMap.put(actualDepList.get(i),actualDateList.get(i));
            expMap.put(allList.get(i),allList.get(i+1));
        }
      resultset.absolute(1);
       Assert.assertEquals("something went wrong",expMap,actualMap);

    }
}
