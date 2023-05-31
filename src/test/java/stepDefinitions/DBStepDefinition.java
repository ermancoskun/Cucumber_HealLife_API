package stepDefinitions;

import java.sql.*;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import utilities.API_Utils;
import utilities.DB_Utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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

        resultset.absolute(0);
        for (int i = 0; i < columnsArr.length; i++) {

            while (resultset.next()){
                Assert.assertEquals(message,resultset.getString(columnsArr[i]), valuesArr[i]);
            }
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

    @And("Verify that the appointments made for the morning are less than the appointments for the afternoon")
    public void verifyThatTheAppointmentsMadeForTheMorningAreLessThanTheAppointmentsForTheAfternoon() throws SQLException {
        resultset.absolute(0);
        resultset.next();
        boolean control = resultset.getBoolean(1);
        Assert.assertTrue(control);
    }

    @And("Verify the first five")
    public void verifyTheFirstFive(List<Integer> list) throws SQLException {
        resultset.absolute(0);

        boolean control = true;
        int index=0;
        while (resultset.next()){
            int data = resultset.getInt(1);

            if (data != list.get(index)){
                control = false;
                break;
            }
            index++;
        }
        Assert.assertTrue(control);
    }

    @Given("Creates update query with {string}")
    public void creates_update_query_with(String query) {

        DB_Utils.updateQuery(query);

    }

    @Given("It should be verified that multiple data entries can be made")
    public void ıt_should_be_verified_that_multiple_data_entries_can_be_made() throws SQLException {
        resultset.absolute(0);
        boolean control = false;
        while (resultset.next()){

            if (resultset.getString("note").equals("deneme text")){
                control = true;
                break;
            }
        }
        Assert.assertTrue(control);
    }

}
