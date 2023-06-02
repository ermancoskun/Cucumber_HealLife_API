Feature: DB_Testing

  @Select
  Scenario: DB_US06 List and verify the contents created in 2023 in the appointment_queue table on the database, which were created in May.
    * User sets the database connection
    * Creates query with "SELECT date FROM heallife_hospitaltraining.appointment_queue WHERE YEAR(date) = 2023 AND MONTH(date) = 5;"
    * Verifies that it CONTAINS datas : "date" values : "2023-05" message : "false"
    * Database connection is closed


  @Select
  Scenario: DB_US16 Verify that the guardian_name of the last deceased patient is Kane Stark, according to the death dates in the death_report table via the database.
    * User sets the database connection
    * Creates query with "SELECT guardian_name FROM heallife_hospitaltraining.death_report WHERE death_date =( SELECT MAX(death_date)  FROM heallife_hospitaltraining.death_report );"
    * Verifies that datas : "guardian_name" values : "Kane Stark" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US26 Verify that the oldest patient's known_allergies in the patients table from the database is "Fast food".
    * User sets the database connection
    * Creates query with "SELECT known_allergies FROM heallife_hospitaltraining.patients WHERE created_at =( SELECT MIN(created_at) FROM heallife_hospitaltraining.patients );"
    * Verifies that datas : "known_allergies" values : "Fast food" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US08 Verify that the name of the patient whose bed group id is 4 and is_active= "no" in the bed table on the database is 105.
    Given User sets the database connection
    Then Creates query with "SELECT name FROM heallife_hospitaltraining.bed where bed_group_id=4 and is_active ='no';"
    Then Verifies that datas : "name" values : "105"
    Then Database connection is closed

  @Select
  Scenario: DB_US18 Verify the created_at information of the data with opd_details_id between 11 and 31 (except 11 and 31) in the discharge_card table over the database.
    Given User sets the database connection
    Then  Creates query with "SELECT created_at FROM discharge_card WHERE opd_details_id > 11 AND opd_details_id < 31;"
    Then Verifies that datas : "created_at" values : "2021-10-28 04:48:56"
    Then Database connection is closed

  @Select
  Scenario: DB_US28 Verify through the database that the oldest vehicle in the vehicles table is driver_name=bayram erguven and driver_licence =b.
    Given User sets the database connection
    Then  Creates query with "SELECT * FROM vehicles WHERE driver_name = 'bayram erguven' AND driver_licence = 'b' ORDER BY manufacture_year ASC LIMIT 1;"
    Then Verifies that datas : "driver_name" values : "bayram erguven"
    Then Database connection is closed

  @Select
  Scenario: DB_US04 In the appointment table on the database, verify that the appointments made for the morning are less than the appointments for the afternoon.
    * User sets the database connection
    * Creates query with "SELECT IF(ogleden_once_sayisi < ogleden_sonra_sayisi, 'true', 'false') AS sonuc FROM ( SELECT (SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) < '12:00:00') AS ogleden_once_sayisi,(SELECT COUNT(*) FROM heallife_hospitaltraining.appointment WHERE TIME(date) >= '12:00:00') AS ogleden_sonra_sayisi) AS counts;"
    * Verify that the appointments made for the morning are less than the appointments for the afternoon
    * Database connection is closed

  @Select
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

  @Insert
  Scenario: DB_US24 It should be verified that multiple data entries can be made to the nurse_note table through the database.
    * User sets the database connection
    * Creates update query with "INSERT INTO heallife_hospitaltraining.nurse_note (date, ipd_id, staff_id, note, comment, updated_at) VALUES ('2022-05-01 12:00', 1, 15, 'bu bir deneme notudur', 'yorum', '2023-05-30 20:50'), ('2022-05-01', 1, 15, 'deneme text', 'new comment', '2023-05-30 20:50');"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.nurse_note;"
    # * Verifies that it CONTAINS datas : "note" values : "deneme text" message : "false"
    * It should be verified that multiple data entries can be made
    * Creates update query with "DELETE FROM heallife_hospitaltraining.nurse_note ORDER BY id DESC LIMIT 2;"
    * Database connection is closed

  @Select
  Scenario: DB_US07 Verify that the bed with created_at = 2021-10-25 03:34:25 in the bed table from the database is active.
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.bed WHERE created_at='2021-10-25 03:34:25' and is_active='yes';"
    * Verifies that datas : "created_at" values : "2021-10-25 03:34:25" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US27 List the account_title data of the contents with qualification=MS, specialization= Neurology in the staff table through the database by ordering them in alphabetical order.
    * User sets the database connection
    * Creates query with "SELECT account_title FROM heallife_hospitaltraining.staff where qualification='MS' and specialization='Neurology'group by account_title order by account_title asc;"
    * Database connection is closed


  @Select
  Scenario: DB_US09 Verify that the number of babies with a weight of 2.5 kg and above is 6 in the birth_report table on the database.
    * User sets the database connection
    * Creates query with "SELECT COUNT(*)as number_baby FROM birth_report WHERE weight >= 2.5"
    * Verifies that datas : "number_baby" values : "6" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US19 From the database, calculate how many hours the doctor with staff_id=2 in the doctor_shift table works on Tuesday. (2)
    * User sets the database connection
    * Creates query with "SELECT sum(hour( end_time - start_time)) as work_out FROM doctor_shift WHERE staff_id = 2 AND day = 'Tuesday';"
    * Verifies that datas : "work_out" values : "2" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US29 Verify that when the vehicles in the vehicles table are listed from the oldest to the newest according to the manufacture_year information through the database, and the vehicles in the same index are listed in the same list according to the created_at information.
    * User sets the database connection
    * Creates query with "SELECT *FROM (SELECT *,ROW_NUMBER() OVER (ORDER BY manufacture_year) AS year_row_num,ROW_NUMBER() OVER (ORDER BY created_at) AS created_row_num FROM vehicles) AS subquery WHERE year_row_num = created_row_num;"
    * Verifies that datas : "vehicle_no" values : "45454545" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US10 List the sibling babies in the birth_report table on the database and verify their names.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.birth_report where father_name = 'Mahesh'"
    * Verifies that datas : "child_name#child_name#child_name" values : "Rohit#Reyana#child" message : "Was not siblings"
    * Database connection is closed

  @InsertDelete
  Scenario: DB_US20 Verify that data can be deleted from the events table via the database.
    * User sets the database connection
    * Creates update query with "INSERT INTO heallife_hospitaltraining.events values (583, 'For delete','kass','2023-05-20 05:43:13','2023-05-20 05:43:13','privat','abc','500','59','yes','2023-06-01 05:43:13')"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.events where id=583;"
    * Verifies that datas : "id" values : "583" message : "Unsuccessful creation"
    * Creates update query with "DELETE FROM heallife_hospitaltraining.events where id=583;"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.events where id=583;"
    * Verifies that the result number of query is 0
    * Database connection is closed

  @Select
  Scenario: DB_US30 Verify that the name of the visitor who came to visit Maria Fernandis from the data in the visitors_book table on the database is Jhon.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.visitors_book where name = 'Jhon' and related_to = 'Maria Fernandis (4) (OPDN24)'"
    * Verifies that datas : "name" values : "Jhon" message : "false"
    * Database connection is closed


  @Select
  Scenario: DB_US03 Verify that the live examination request of the patient with patient_id = 20 in the appointment table on the database is open.
    * User sets the database connection
    * Creates query with "SELECT live_consult FROM heallife_hospitaltraining.appointment where patient_id = 20;"
    * Verifies that datas : "live_consult" values : "yes" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US13 List and verify the charge_type_id numbers of the contents whose name information starts with "P" in the charge_categories table over the database, without repetition. (6 , 7)
    * User sets the database connection
    * Creates query with "SELECT distinct charge_type_id   FROM heallife_hospitaltraining.charge_categories WHERE name  LIKE 'P%' "
    * Verifies that datas : "charge_type_id#charge_type_id" values : "6#7" message : "false"
    * Database connection is closed


  @Select
  Scenario: DB_US23 Check that the other information of the data whose address information is "Andheri, Mumbai" in the medicine_supplier table on the database is correct.
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.medicine_supplier where address='Andheri, Mumbai'; "
    * Verifies that datas : "address" values : "Andheri, Mumbai" message : "false"
    * Database connection is closed

  @Insert
  Scenario: DB_US02 Verify that an appointment can be made by entering the necessary information into the hospital system via the database.
    * User sets the database connection
    * Creates update query with "INSERT INTO heallife_hospitaltraining.appointment  VALUES ('819','10','74','10', '2023-05-01 13:00','06:00:00','2','1','4','38','1', 'migren','approved','Offline','yes','1','15','0','no','2023-01-19 04:54:36');"
    * Creates query with "SELECT * FROM heallife_hospitaltraining.appointment WHERE id=819;"
    * Verifies that it CONTAINS datas : "id#patient_id#date#doctor#appointment_status" values : "819#10#2023-05-01 13:00:00#4#migren" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US01 Verify that the patient with patient_id = 1 in the ambulance call table on the database has been dispatched 2 times by the ambulance whose driver is Smith.
    * User sets the database connection
    * Creates query with "select patient_id, driver from heallife_hospitaltraining.ambulance_call where patient_id=1 and driver = 'Smith';"
    * Verify that number of result is two
    * Database connection is closed

  @Select
  Scenario: DB_US21 List the IDs of the X-RAY laboratories from the laboratories in the lab table. Verify that the largest of the ids is (3) by the database.
    * User sets the database connection
    * Creates query with "SELECT max(id) AS max_id FROM heallife_hospitaltraining.lab WHERE lab_name LIKE '%X-RAY%';"
    * Verify that max id is three
    * Database connection is closed

  @Select
  Scenario: DB_US11 Verify on the database that the donor_name of the donor with id= 7 in the blood_donor table is Maria, date_of_birth=2001-03-02, gender=Female, father_name=Jhonson, address=England.
    * User sets the database connection
    * Creates query with "select * from heallife_hospitaltraining.blood_donor where id=7;"
    * Verifies that it CONTAINS datas : "donor_name#date_of_birth#gender#father_name#address" values : "Maria#2001-03-02 00:00:00#Female#Jhonson#England" message : "false"

  @Select
  Scenario: DB_US12 List the id numbers whose institution is certain in the blood_donor_cycle table via Databese. And verify that id=17 is in the list.
    * User sets the database connection
    * Creates query with "SELECT * FROM heallife_hospitaltraining.blood_donor_cycle WHERE institution !='';"
    * Creates query with "select * from heallife_hospitaltraining.blood_donor where id=17;"
    * Verifies that it CONTAINS datas : "id" values : "17" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US22 Verify that the language information of the data whose short_code is "yi" in the languages table is "Yiddish" through the database.
    * User sets the database connection
    * Creates query with "SELECT language FROM heallife_hospitaltraining.languages where short_code='yi';"
    * Verifies that datas : "language" values : "Yiddish" message : "false"
    * Database connection is closed

  @Select
  Scenario: DB_US05 In the appointment_payment table through the database, verify that the patient IDs selected as "offline" as the payment type are: (1,2,3,16,17,18,20,21,24,25,31).
    * User sets the database connection
    * Creates query with "SELECT appointment_id FROM heallife_hospitaltraining.appointment_payment WHERE payment_type = 'offline';"
    * Verify that the patient IDs below selected as offline as the payment type
      | 1  |
      | 2  |
      | 3  |
      | 16 |
      | 17 |
      | 18 |
      | 20 |
      | 21 |
      | 24 |
      | 25 |
      | 31 |
    * Database connection is closed

  @Select
  Scenario: DB_US15 It should be verified that a new record can be added to the consultant_register table via the database.
    * User sets the database connection
    * Add a new record to the consultant_register table
    * Creates query with "SELECT * FROM heallife_hospitaltraining.consultant_register"
    * Verifies that datas : "ipd_id" values : "8" message : ""
    * Database connection is closed

  @Select
  Scenario: DB_US25 Verify the gender and email information of the patients whose patient_name information contains "Jain" in the patients table on the database.
    * User sets the database connection
    * Creates query with "select patient_name, gender, email from heallife_hospitaltraining.patients where patient_name LIKE ('%Jain%');"
    * Verify gender and mail information of patients whose patient name contains "Jain"
    * Database connection is closed

  @Select
  Scenario: DB_US17 It should be verified that the department_name and created_at information of the contents in the department table via the database match.
    *  User sets the database connection
    *  Verify from the database that the contents of the department table match the "department_name" and "created_at"  "OT" "2021-10-25 00:50:49" information
    *  Database connection is closed




