package stepDefinitions;

import java.sql.*;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import utilities.ConfigReader;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static utilities.DB_Utils.*;

public class DBStepDefinition {

    ResultSet resultset;
    Statement st;
    Connection con;
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



























































































































































    @Then("soutkkkk")
    public void  soutkkkk() throws SQLException {

        //createConnection();
        // Database üzerinden appointment_queue tablosunda
        // 2023 yilinda olusturulan iceriklerden mayis ayinda olusturulanlari listeleyip dogrulayiniz.
        /*
            SELECT date
            FROM heallife_hospitaltraining.appointment_queue
            WHERE date >= '2023-05-01'
            AND date < '2023-06-01';

            SELECT date
            FROM heallife_hospitaltraining.appointment_queue
            WHERE YEAR(date) = 2023
            AND MONTH(date) = 5;
         */



        // Database üzerinden death_report tablosundaki
        // ölüm tarihlerine göre en son ölen hastanin guardian_name bilgisinin Kane Stark oldugunu dogrulayiniz.
        /*
        SELECT guardian_name
        FROM heallife_hospitaltraining.death_report
        WHERE death_date =(
        SELECT MAX(death_date)
        FROM heallife_hospitaltraining.death_report );

         */

        // Database üzerinden patients tablosundaki
        // en eski hastanin known_allergies bilgisinin "Fast food" oldugunu dogrulayin.
        /*
        SELECT known_allergies
        FROM heallife_hospitaltraining.patients
        WHERE created_at =(
        SELECT MIN(created_at)
        FROM heallife_hospitaltraining.patients );
         */

        // Database üzerinden birth_report tablosunda kardes olan bebekleri  listeleyip isimlerini dogrulayiniz.

        /*
        select father_name
        FROM heallife_hospitaltraining.birth_report;
         */

        String query = "SELECT father_name FROM heallife_hospitaltraining.birth_report;";
        System.out.println(query);

        resultset=st.executeQuery(query);
        System.out.println(resultset.getRow());
        /*

        while(resultset.next()){

            for (int i = 0; i <resultset.getRow() ; i++) {
                resultset.getInt(i+1);
            }
            System.out.println(iscilerTablosu.getInt(1) + " " +
                    iscilerTablosu.getString(2) + " " +
                    iscilerTablosu.getInt(3));
        }


         */



    }

}
