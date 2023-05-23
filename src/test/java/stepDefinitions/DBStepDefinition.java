package stepDefinitions;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static utilities.DB_Utils.*;

public class DBStepDefinition {
    List<Object> UserEmailList= new ArrayList<>();

    @Given("Database connection established")
    public void database_connection_established() {
        createConnection();
    }
    @Given("From the Users table,{string} data of the user whose {string} and {string} information is entered are retrieved")
    public void from_the_users_table_data_of_the_user_whose_and_information_is_entered_are_retrieved(String email, String firstName, String lastName) {
        String query= "SELECT email FROM u480337000_tlb_training.users where first_name='"+firstName+"' and last_name= '"+lastName+"';";
        UserEmailList=getColumnData(query,email);
    }

    @Then("User's {string} data is verified")
    public void user_s_data_is_verified(String email) {
        assertTrue(UserEmailList.get(0).equals(email));

    }
    @Then("Database connection is closed")
    public void database_connection_is_closed() {
            closeConnection();
    }

}
