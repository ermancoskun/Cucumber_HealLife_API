Feature: DB_Testing
  Scenario Outline: Email query of the user whose first_name and last_name are given

    Given Database connection established
    And From the Users table,"email" data of the user whose "<first_name>" and "<last_name>" information is entered are retrieved
    Then User's "<email>" data is verified
    And Database connection is closed


    Examples:
      | first_name | last_name | email           |
      | Admin      | User      | admin@gmail.com |



  @DB06 @dg
  Scenario: DB_US06
    * User sets the database connection
    * Creates query with "SELECT date FROM heallife_hospitaltraining.appointment_queue WHERE YEAR(date) = 2023 AND MONTH(date) = 5;"
    * Verifies that it CONTAINS datas : "date" values : "2023-05" message : "false"
    * Database connection is closed

  @DB16 @dg
  Scenario: DB_US16
    * User sets the database connection
    * Creates query with "SELECT guardian_name FROM heallife_hospitaltraining.death_report WHERE death_date =( SELECT MAX(death_date)  FROM heallife_hospitaltraining.death_report );"
    * Verifies that datas : "guardian_name" values : "Kane Stark" message : "false"
    * Database connection is closed

  @DB26 @dg
  Scenario: DB_US26

      * User sets the database connection
      * Creates query with "SELECT known_allergies FROM heallife_hospitaltraining.patients WHERE created_at =( SELECT MIN(created_at) FROM heallife_hospitaltraining.patients );"
      * Verifies that datas : "known_allergies" values : "Fast food" message : "false"
      * Database connection is closed

@abd
  Scenario: DB_US08

    Given User sets the database connection
    Then Creates query with "SELECT name FROM heallife_hospitaltraining.bed where bed_group_id=4 and is_active ='no';"
    Then Verifies that datas : "name" values : "105"
    Then Database connection is closed

    * User sets the database connection
    * Creates query with "SELECT known_allergies FROM heallife_hospitaltraining.patients WHERE created_at =( SELECT MIN(created_at) FROM heallife_hospitaltraining.patients );"
    * Verifies that datas : "known_allergies" values : "Fast food" message : "false"
    * Database connection is closed


  Scenario: DB_US10 List the sibling babies in the birth_report table on the database and verify their names.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.birth_report where father_name = 'Mahesh'"
    * Verifies that datas : "child_name#child_name#child_name" values : "Rohit#Reyana#child" message : "Was not siblings"
    * Database connection is closed

  Scenario: DB_US20 Verify that data can be deleted from the events table via the database.
    * User sets the database connection
    * Creates query with ""
    * Verifies that datas : "" values : "" message : ""
    * Database connection is closed

  Scenario: DB_US30 Verify that the name of the visitor who came to visit Maria Fernandis from the data in the visitors_book table on the database is Jhon.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.visitors_book where name = 'Jhon' and related_to = 'Maria Fernandis (4) (OPDN24)'"
    * Verifies that datas : "name" values : "Jhon" message : "false"
    * Database connection is closed


  Scenario:
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.birth_report WHERE weight >= 2.5;"
    * Verifies that the result number of query is 6
    * Database connection is closed

  @ay
  Scenario:
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.department"
    * Verifies that datas belowed
      | Admin,2021-10-25 00:52:21              |
      | BURN CARE,2021-10-25 00:55:11          |
      | Blood Bank,2021-10-25 00:53:07         |
      | Cardiology,2021-10-25 00:54:54         |
      | Doctor,2021-10-25 00:51:22             |
      | Emergency,2021-10-25 00:54:42          |
      | Finance,2021-10-25 00:54:22            |
      | Gynecology,2021-10-25 00:54:10         |
      | Human Resource,2021-10-25 00:53:59     |
      | ICU,2021-10-25 00:52:55                |
      | IPD,2021-10-25 00:52:34                |
      | NICU,2021-10-25 00:56:13               |
      | Nursing Department,2021-10-25 03:02:57 |
      | OPD,2021-10-25 00:52:38                |
      | OT,2021-10-25 00:50:49                 |
      | Pathology,2021-10-25 00:53:20          |
      | Pharmacy,2021-10-25 00:53:33           |
      | Radiology,2021-10-25 00:53:27          |
      | Reception,021-10-25 00:53:46           |
    * Database connection is closed

  Scenario: DB_US04 In the appointment table on the database, verify that the appointments made for the morning are less than the appointments for the afternoon.

    * User sets the database connection
    * Creates query with "SELECT IF(ogleden_once_sayisi < ogleden_sonra_sayisi, 'true', 'false') AS sonuc FROM ( SELECT (SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) < '12:00:00') AS ogleden_once_sayisi,(SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) >= '12:00:00') AS ogleden_sonra_sayisi) AS counts;"
    * Verify that the appointments made for the morning are less than the appointments for the afternoon
    * Database connection is closed

  Scenario: DB_US14 Sort the data in the charges table via the database from smallest to largest, and verify the first 5 (100, 100,100,110,120).

    * User sets the database connection
    * Creates query with "SELECT standard_charge FROM heallife_hospitaltraining.charges ORDER BY standard_charge ASC LIMIT 5;"
    * Verify the first five
      | 100 |
      | 100 |
      | 100 |
      | 110 |
      | 120 |
    * Database connection is closed

  Scenario: DB_US24 It should be verified that multiple data entries can be made to the nurse_note table through the database.

    * User sets the database connection
    * Creates update query with "INSERT INTO heallife_hospitaltraining.nurse_note (date, ipd_id, staff_id, note, comment, updated_at) VALUES ('2022-05-01 12:00', 1, 15, 'bu bir deneme notudur', 'yorum', '2023-05-30 20:50'), ('2022-05-01', 1, 15, 'deneme text', 'new comment', '2023-05-30 20:50');"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.nurse_note;"
    # * Verifies that it CONTAINS datas : "note" values : "deneme text" message : "false"
    * It should be verified that multiple data entries can be made
    * Creates update query with "DELETE FROM heallife_hospitaltraining.nurse_note ORDER BY id DESC LIMIT 2;"
    * Database connection is closed

  @wip1
  Scenario: DB_US07 Verify that the bed with created_at = 2021-10-25 03:34:25 in the bed table from the database is active.

    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.bed WHERE created_at='2021-10-25 03:34:25' and is_active='yes';"
    * Verifies that datas : "created_at" values : "2021-10-25 03:34:25" message : "false"
    * Database connection is closed


  Scenario: DB_US27 List the account_title data of the contents with qualification=MS, specialization= Neurology in the staff table through the database by ordering them in alphabetical order.
    * User sets the database connection
    * Creates query with "SELECT account_title FROM heallife_hospitaltraining.staff where qualification='MS' and specialization='Neurology'group by account_title order by account_title asc;"
     * Database connection is closed


@HUM
  Scenario: DB_US03 Verify that the live examination request of the patient with patient_id = 20 in the appointment table on the database is open.
    * User sets the database connection
    * Creates query with "SELECT live_consult FROM heallife_hospitaltraining.appointment where patient_id = 20;"
    * Verifies that datas : "live_consult" values : "yes" message : "false"
    * Database connection is closed

  @HUM
  Scenario: DB_US13 List and verify the charge_type_id numbers of the contents whose name information starts with "P" in the charge_categories table over the database, without repetition. (6 , 7)
    * User sets the database connection
    * Creates query with "SELECT distinct charge_type_id   FROM heallife_hospitaltraining.charge_categories WHERE name  LIKE 'P%' "
    * Verifies that datas : "charge_type_id#charge_type_id" values : "6#7" message : "false"
     * Database connection is closed


  @HUM
  Scenario: DB_US23 Check that the other information of the data whose address information is "Andheri, Mumbai" in the medicine_supplier table on the database is correct.
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.medicine_supplier where address='Andheri, Mumbai'; "
    * Verifies that datas : "address" values : "Andheri, Mumbai" message : "false"
    * Database connection is closed


 Scenario: DB_US02 Verify that an appointment can be made by entering the necessary information into the hospital system via the database.

   * User sets the database connection
   * Creates update query with "INSERT INTO heallife_hospitaltraining.appointment (id , patient_id , date , doctor , message) VALUES ('987', '98', '2023-05-01 13:00', '38' , 'migren');"
   * Creates query with "SELECT * FROM heallife_hospitaltraining.appointment;"
   * Verifies that datas : "id#patient_id#date#doctor#message" values : "987#98#'2023-05-01 13:00'#38#'migren'" message : "false"
   * Database connection is closed



  Scenario: DB_US12 List the id numbers whose institution is certain in the blood_donor_cycle table via Databese. And verify that id=17 is in the list.
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.blood_donor_cycle WHERE institutions !='';"
    * Verifies that it CONTAINS datas : "id" values : "17" message : "false"
    * Database connection is closed


  Scenario: DB_US22 Verify that the language information of the data whose short_code is "yi" in the languages table is "Yiddish" through the database.
    * User sets the database connection
    * Creates query with "SELECT language FROM heallife_hospitaltraining.languages where short_code='yi';"
    * Verifies that datas : "language" values : "Yiddish'" message : "false"
    * Database connection is closed

