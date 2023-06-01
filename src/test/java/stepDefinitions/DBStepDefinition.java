package stepDefinitions;

import java.sql.*;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import utilities.DB_Utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static utilities.DB_Utils.*;

public class DBStepDefinition {

    public  static ResultSet resultset;
    Statement statement;
    Connection connection;
    String query;
    SoftAssert softAssert = new SoftAssert();
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
            Assert.assertEquals(message, resultset.getString(columnsArr[i - 1]), valuesArr[i - 1]);
        }
    }

    @Given("Verifies that it CONTAINS datas : {string} values : {string} message : {string}")
    public void verifies_that_it_contains_datas_values_message(String actualValueColumn, String expectedValue, String message) throws SQLException {

        // bu stepte CONTAINS asserti yapılıyor, assertEquals icin ayrı method var.

        String[] columnsArr = actualValueColumn.split("#");
        String[] valuesArr = expectedValue.split("#");

        resultset.absolute(0);
        for (int i = 0; i < columnsArr.length; i++) {

            while (resultset.next()) {
                Assert.assertTrue(message, resultset.getString(columnsArr[i]).contains(valuesArr[i]));
            }
        }
    }


    @Then("Verifies that datas : {string} values : {string}")
    public void verifiesThatDatasValues(String name, String value) throws SQLException {
        resultset.absolute(1);
        System.out.println(resultset.getString(name));
        Assert.assertEquals(value, resultset.getString(name));
    }

    @Given("Verifies that the result number of query is {int}")
    public void verifies_that_the_result_number_of_query_is(int sayi) throws Exception {
        int actualData = DB_Utils.getRowCount();
        Assert.assertEquals("Wrong number", sayi, actualData);
    }

    @Given("Verifies that datas belowed")
    public void verifies_that_datas_belowed(List<String> allList) throws SQLException {

        List<Object> actualDepList = getColumnData(query, "department_name");
        List<Object> actualDateList = getColumnData(query, "created_at");
        Map<Object, Object> actualMap = new HashMap<>();
        Map<Object, Object> expMap = new HashMap<>();

        System.out.println("actualDepList = " + actualDepList);
        System.out.println("actualDateList = " + actualDateList);
        System.out.println("allList = " + allList);
        for (int i = 0; i < actualDepList.size() - 1; i = i + 2) {
            actualMap.put(actualDepList.get(i), actualDateList.get(i));
            expMap.put(allList.get(i), allList.get(i + 1));
            resultset.absolute(1);
            Assert.assertEquals("something went wrong", expMap, actualMap);
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
        int index = 0;
        while (resultset.next()) {
            int data = resultset.getInt(1);

            if (data != list.get(index)) {
                control = false;
                break;
            }
            index++;
        }
        Assert.assertTrue(control);
    }

    @Given("Creates update query with {string}")

    public void creates_update_query_with(String query) throws SQLException {
        DB_Utils.updateQuery(query);
    }

    @Given("It should be verified that multiple data entries can be made")
    public void ıt_should_be_verified_that_multiple_data_entries_can_be_made() throws SQLException {
        resultset.absolute(0);
        boolean control = false;
        while (resultset.next()) {


            if (resultset.getString("note").equals("deneme text") & resultset.getString("comment").equals("new comment")) {

                control = true;
                break;
            }
        }
        Assert.assertTrue(control);
    }


    @Given("Verify that number of result is two")
    public void verify_that_number_of_result_is_two() throws SQLException {
        int count = 0;
        while (resultset.next()) {
            count++;

        }
        System.out.println(count);
        assertTrue(count == 2);
    }

    @Given("Verify that max id is three")
    public void verify_that_max_id_is_three() throws SQLException {
        int expectedMaxresult = 3;
        resultset.absolute(0);
        resultset.next();
        Assert.assertEquals("", expectedMaxresult, resultset.getInt("max_id"));


    }
    @Given("Verify gender and mail information of patients whose patient name contains {string}")
    public void verify_gender_and_mail_information_of_patients_whose_patient_name_contains(String string) throws SQLException {
        resultset.absolute(0);

        List<String> patientsList = new ArrayList<>();
        while (resultset.next()) {
            patientsList.add(resultset.getString("gender"));
            patientsList.add(resultset.getString("email"));
        }
        System.out.println(patientsList);

        Assert.assertTrue(patientsList.contains("Female"));//[Female, reshu@gmail.com, Male, umair@gmail.com]
        Assert.assertTrue(patientsList.contains("reshu@gmail.com"));
        Assert.assertTrue(patientsList.contains("Male"));
        Assert.assertTrue(patientsList.contains("umair@gmail.com"));
    }
    @Given("Verify that the patient IDs below selected as offline as the payment type")
    public void verify_that_the_patient_i_ds_below_selected_as_offline_as_the_payment_type(List<Integer> list) throws SQLException {
        resultset.absolute(0);

        boolean control = true;
        int index = 0;
        while (resultset.next()) {
            int data = resultset.getInt(1);

            if (data != list.get(index)) {
                control = false;
                break;
            }
            index++;
        }
        Assert.assertTrue(control);
    }

    @Given("Add a new record to the consultant_register table")
    public void add_a_new_record_to_the_consultant_register_table() throws SQLException {

        try {
            String sql = "INSERT INTO consultant_register (id, ipd_id, date, ins_date, instruction, cons_doctor, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            Connection connection= getConnection();
            PreparedStatement preparedStatement= connection.prepareStatement(sql);
            preparedStatement.setString(1,"101");
            preparedStatement.setString(2,"101");
            preparedStatement.setString(3,"2023-06-04 15:06:03");
            preparedStatement.setString(4,"2023-05-16");
            preparedStatement.setString(5,"new req");
            preparedStatement.setString(6,"2");
            preparedStatement.setString(7,"2023-06-01 19:46:03");
            preparedStatement.close();
            System.out.println("data added");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}


