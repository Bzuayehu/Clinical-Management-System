--ADDRESS OBJECT TYPE
--this object is used as one of the variable in person abstract type
--it has no method, since its only be used as a complex variable,
--not as an object by itself
CREATE OR REPLACE TYPE address_typ AS OBJECT ( 
   street          VARCHAR2(30),
   city            VARCHAR2(20),
   region          VARCHAR2(20),
   phoneNo               NUMBER,
   email           VARCHAR2(30), 
   postalNo         NUMBER(4));
   
--PERSON OBJECT TYPE
--its a type that is an abstract type which can not be instanitated
--the main purpose of this type is act as a super class/type 
--for other subclass instantiable object types which has multiple commonalities
CREATE OR REPLACE TYPE person_typ AS OBJECT(
    fname       VARCHAR2(20),
    lname       VARCHAR2(20), 
    sex         CHAR(1),
    DOB         DATE,
    addr        address_typ,
    MEMBER PROCEDURE getInfo) 
    --ITS is declared NOT INSTANTIABEL because its an abstract class
    --and, NOT FINAL is for it can be inherited by subtypes
    NOT INSTANTIABLE NOT FINAL;
    
--DOCTOR OBJECT TYPE
--CREATING DOCTOR OBJECT DRIVED FROM PERSON OBJECT
CREATE OR REPLACE TYPE doctor_typ UNDER person_typ(
    drId    NUMBER,
    special VARCHAR2(30),
    salary  NUMBER,
    --the user defined constructor help us to make initializing much simpler
    CONSTRUCTOR FUNCTION doctor_typ(c_drId NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_special VARCHAR2, c_salary NUMBER)
    RETURN SELF AS RESULT,
    MEMBER PROCEDURE addDr,
    MEMBER PROCEDURE deleteDr (dr_id NUMBER),
    MEMBER PROCEDURE updateAddr(dr_id NUMBER, newAddr address_typ),
    MEMBER PROCEDURE updateSalary(dr_id NUMBER, newsal NUMBER),
    MEMBER PROCEDURE displayinfo
);

-- a table for DOCTOR type to store it in a convinient way
--this help us make retrieval and storage more dynamic
CREATE TABLE dr_table OF doctor_typ;

-- THESE are the type bodies which are the definition of implemetation 
-- for type methods
CREATE OR REPLACE TYPE BODY doctor_typ AS
--constructor method definition
CONSTRUCTOR FUNCTION doctor_typ(c_drId NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_special VARCHAR2, c_salary NUMBER)
    RETURN SELF AS RESULT 
IS
BEGIN
    -- SELF key word to refer to the current object of doctor type  
    SELF.drID := c_drid;
    SELF.fname := c_fname;
    SELF.lname := c_lname;
    SELF.sex := c_sex;
    SELF.DOB := c_DOB;
    SELF.addr := c_addr;
    SELF.special := c_special;
    SELF.salary := c_salary;
    RETURN; -- it returns it self as result
END;
-- method to add a record of doctor into the doctor table we created earlier
MEMBER PROCEDURE addDr 
IS
BEGIN
    INSERT INTO dr_table VALUES(fname, lname, sex, DOB, addr, 
                            drid, special, salary);
END;
-- method to delete a doctor record from the doctor table provided a doctor ID
MEMBER PROCEDURE deleteDr (dr_id NUMBER)
IS
BEGIN
    DELETE FROM dr_table WHERE drid = dr_id;
END;
--method to update address of a doctor for its possible to change addresses
-- it has two parameters, one is a doctor ID to identify which doctor
-- the other is a new address to be updated
MEMBER PROCEDURE updateAddr(dr_id NUMBER, newAddr address_typ)
IS
BEGIN
    UPDATE dr_table SET  addr  = newAddr WHERE drid = dr_id;
END;
-- this method also update the salary of a doctor identified by the given id
MEMBER PROCEDURE updateSalary(dr_id NUMBER, newsal NUMBER)
IS
BEGIN
    UPDATE dr_table SET salary = newsal WHERE drid = dr_id; 
END;
-- method to display the information about the object of the doctor type 
MEMBER PROCEDURE displayinfo
IS 
BEGIN 
    dbms_output.put_line('DOCTOR ID: ' || drid);
    dbms_output.put_line('NAME: ' || fname || ' ' || lname );
    dbms_output.put_line('SEX: ' || sex);
    dbms_output.put_line('DATE OF BIRTH: ' || DOB);
    dbms_output.put_line('SPECIALIZATION: ' || special);
    dbms_output.put_line('SALARY: ' || salary);
    dbms_output.put_line('STREET ADDRESS: ' || addr.street);
    dbms_output.put_line('CITY: ' || addr.city);
    dbms_output.put_line('PHONE NUMBER: ' || addr.phoneNo);
    dbms_output.put_line('E-MAIL: ' || addr.email);
    dbms_output.put_line('POSTAL NUMBER: ' || addr.postalNo);
END;
END; -- end of the object body definition


-- Nurse object 
-- THIS OBJECT IS ALSO DRIVED FROM THE PERSON ABSTRACT TYPE
CREATE OR REPLACE TYPE nurse_typ UNDER person_typ(
    nurseId    NUMBER,
    nurse_role VARCHAR2(30),
    salary  NUMBER,
    --this constructor is used to make instantiating much simpler
    CONSTRUCTOR FUNCTION nurse_typ(c_nurseId NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_role VARCHAR2, c_salary NUMBER)
    RETURN SELF AS RESULT,
    MEMBER PROCEDURE addNurse,
    MEMBER PROCEDURE deleteNurse (nurse_id NUMBER),
    MEMBER PROCEDURE updateAddr(nurse_id NUMBER, newAddr address_typ),
    MEMBER PROCEDURE updateSalary(nurse_id NUMBER, newsal NUMBER),
    MEMBER PROCEDURE displayinfo
);

-- TABLE for nurse object to store and retrieve in a structured way
CREATE TABLE nurse_table OF nurse_typ;

--DEFINITION FOR THE METHOD OF THE NURSE TYPE SPECIFIED IN THE TYPE DECLARATION
CREATE OR REPLACE TYPE BODY nurse_typ AS
-- constructor to make instantiation easier to manupulate
CONSTRUCTOR FUNCTION nurse_typ(c_nurseId NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_role VARCHAR2, c_salary NUMBER)
    RETURN SELF AS RESULT 
IS
BEGIN
    SELF.NurseID := c_nurseid;
    SELF.fname := c_fname;
    SELF.lname := c_lname;
    SELF.sex := c_sex;
    SELF.DOB := c_DOB;
    SELF.addr := c_addr;
    SELF.nurse_role := c_role;
    SELF.salary := c_salary;
    RETURN;
END;
--method to add a record of nurse in to the nurse table 
MEMBER PROCEDURE addNurse 
IS
BEGIN
    INSERT INTO Nurse_table VALUES(fname, lname, sex, DOB, addr, 
                            nurseid, nurse_role, salary);
END;
-- this method deletes a nurse record from the table identified by the nurse id
MEMBER PROCEDURE deletenurse (nurse_id NUMBER)
IS
BEGIN
    DELETE FROM nurse_table WHERE nurseid = nurse_id;
END;
-- this method also update address of the nurse identified by a certain id
MEMBER PROCEDURE updateAddr(nurse_id NUMBER, newAddr address_typ)
IS
BEGIN
    UPDATE nurse_table SET  addr = newAddr WHERE nurseid = nurse_id;
END;
--method to update a salary of a nurse 
MEMBER PROCEDURE updateSalary(nurse_id NUMBER, newsal NUMBER)
IS
BEGIN
    UPDATE nurse_table SET salary = newsal WHERE nurseid = nurse_id;
END;
--method to display indormation about the nurse object with a output line
MEMBER PROCEDURE displayinfo
IS 
BEGIN 
    dbms_output.put_line('DOCTOR ID: ' || NURSEID);
    dbms_output.put_line('NAME: ' || fname || ' ' || lname );
    dbms_output.put_line('SEX: ' || sex);
    dbms_output.put_line('DATE OF BIRTH: ' || DOB);
    dbms_output.put_line('NURSE ROLE: ' || nurse_role);
    dbms_output.put_line('SALARY: ' || salary);
    dbms_output.put_line('STREET ADDRESS: ' || addr.street);
    dbms_output.put_line('CITY: ' || addr.city);
    dbms_output.put_line('PHONE NUMBER: ' || addr.phoneNo);
    dbms_output.put_line('E-MAIL: ' || addr.email);
    dbms_output.put_line('POSTAL NUMBER: ' || addr.postalNo);
END;
END; -- end of body definition

--DRUG OBJECT
-- this object will be used in the patient record as patients prescribed drug
CREATE OR REPLACE TYPE drug_typ AS OBJECT(
    barcode     NUMBER(10),
    drugName    VARCHAR2(30),
    drugType    VARCHAR2(30),
    manuDate    DATE,
    expireDate  DATE,
    MEMBER PROCEDURE addDrug,
    MEMBER PROCEDURE deleteDrug (bar_code NUMBER),
    MEMBER FUNCTION getExpireDate (bar_code NUMBER) RETURN DATE,
    MEMBER PROCEDURE displayinfo);  
    
-- table for drug type to manupulate easily
CREATE TABLE drug_table OF drug_typ;

--the type body for definning of implementation for type methods 
CREATE OR REPLACE TYPE BODY drug_typ AS
--to add drugs in to the drug table created earlier
MEMBER PROCEDURE addDrug
IS
BEGIN
    INSERT INTO drug_table VALUES(barcode, drugName, drugType, 
                            manuDate, expireDate);
END addDrug;
-- to delete a certain drug object from the drug table identified by its barcode
MEMBER PROCEDURE deleteDrug (bar_code NUMBER)
IS
BEGIN
    DELETE FROM drug_table WHERE barcode = bar_code;
END deleteDrug;
-- method function to return an expire date of a certain drug based on barcode
MEMBER FUNCTION getExpireDate (bar_code NUMBER) 
RETURN DATE
IS expiresOn DATE;
BEGIN
    SELECT expireDate INTO expiresOn  FROM drug_table WHERE barcode = bar_code;
    RETURN expiresOn;
END;
-- displaying all information of a certain drug
MEMBER PROCEDURE displayinfo
IS
BEGIN
    dbms_output.put_line('DRUG BARCODE NUMBER: ' || barcode);
    dbms_output.put_line('DRUG NAME: ' || drugName);
    dbms_output.put_line('DRUG TYPE: ' || drugType);
    dbms_output.put_line('MANUFACTURE DATE: ' || manuDate);
    dbms_output.put_line('EXPIRE DATE: ' || expireDate);
END;
END; -- end of body definition of drug type

-- PATIENT RECORD OBJECT
-- this object will have all the related patient records 
-- it includes all the information of his visit to the clinic
CREATE OR REPLACE TYPE p_record AS OBJECT(
    record_id       NUMBER,
    assignDr        doctor_typ,
    drug            drug_typ,
    symptom         VARCHAR2(50),
    assignNurse     nurse_typ,
    diagnosis       VARCHAR2(50),
    results         VARCHAR2(50),
    MEMBER PROCEDURE addRec,
    MEMBER PROCEDURE deleteRec (rec_id NUMBER),
    MEMBER PROCEDURE updateDr(rec_id NUMBER, newdr doctor_typ),
    MEMBER PROCEDURE updateNurse(rec_id NUMBER, newNurse nurse_typ),
    MEMBER PROCEDURE giveDrug(rec_id NUMBER, newdrug drug_typ),
    MEMBER PROCEDURE displayResult,
    MEMBER PROCEDURE displayDoctor,
    MEMBER PROCEDURE displayNurse,
    MEMBER PROCEDURE displayDrug
    );
-- table for the patient record 
CREATE TABLE rec_table OF p_record;

-- definition of the method body implementations
CREATE OR REPLACE TYPE BODY p_record AS
-- to add an object of record into the table
MEMBER PROCEDURE addRec 
IS
BEGIN 
    INSERT INTO rec_table VALUES(record_id, assignDr,drug, symptom,assignNurse,
    diagnosis, results);
END;
-- method to delete a patient record identifying by its record id
MEMBER PROCEDURE deleteRec (rec_id NUMBER)
IS 
BEGIN
    DELETE FROM rec_table WHERE record_id = rec_id;
END;
-- this method update the assigned doctor 
-- if the doctor is changed for a certain patient
MEMBER PROCEDURE updateDr(rec_id NUMBER, newdr doctor_typ)
IS
BEGIN
    UPDATE rec_table SET assignDr = newdr WHERE record_id = rec_id;
END;
-- this method update the assigned nurse 
-- if the doctor is changed for a certain patient
MEMBER PROCEDURE updateNurse(rec_id NUMBER, newNurse nurse_typ)
IS 
BEGIN
    UPDATE rec_table SET assignnurse = newNurse WHERE record_id = rec_id;
END;
-- this method is used to change the drug that are given to the patient
MEMBER PROCEDURE giveDrug(rec_id NUMBER, newdrug drug_typ)
IS 
BEGIN 
    UPDATE REC_TABLE SET Drug = newdrug WHERE record_id = rec_id;
END;
-- to display result of an investigation of the patient
MEMBER PROCEDURE displayResult
IS
BEGIN
    dbms_output.put_line('RECORED ID: ' || record_id);
    dbms_output.put_line('SYMPTOMS: ' || symptom);
    dbms_output.put_line('DIAGNOSIS: ' || diagnosis);
    dbms_output.put_line('RESULTS: ' || results);
    dbms_output.put_line('INVESTIGATE PRESCRIBED BY: ' || assigndr.fname 
    || ' ' || assigndr.lname);
END;
-- method to display information about the assigned doctor to the patient 
MEMBER PROCEDURE displayDoctor
IS
BEGIN
    assignDr.displayinfo;
END;
-- method to display information about the assigned nurse to the patient 
MEMBER PROCEDURE displayNurse
IS
BEGIN
    assignNurse.displayinfo;
END;
-- method to display information about the prescribed drug
MEMBER PROCEDURE displayDrug
IS
BEGIN
    drug.displayinfo;
    dbms_output.put_line('DRUG PRESCRIBED BY: ' || assigndr.fname 
    || ' ' || assigndr.lname);
END;
END; -- end of body definition for the patient record type

--PATIENT OBJECT
-- this is the main actor in the clinical system, ITS DRIVED FORM PERSON TYPE
-- this object will have some attributes as for patient related information
-- and also has a specific patient record 
CREATE OR REPLACE TYPE patient_typ UNDER person_typ(
    patient_Id   NUMBER, 
    blood_Type   CHAR(2),
    last_Checkup DATE,
    record_info   p_record,
    CONSTRUCTOR FUNCTION patient_typ(c_patient_Id NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_blood_type CHAR, c_last_checkup DATE, c_record_info p_record)
    RETURN SELF AS RESULT,
    MEMBER PROCEDURE addPatient,
    MEMBER PROCEDURE deletePatient(pid Number),
    MEMBER PROCEDURE update_checkup(pid Number, newcheckup DATE),
    --MEMBER PROCEDURE getPatientInfo (pid NUMBER),
    MEMBER PROCEDURE setRecord(pid NUMBER, newrecinfo p_record),
    MEMBER PROCEDURE displayinfo, 
    MEMBER FUNCTION getRecid(PID NUMBER) RETURN p_record
);

-- table for patient object type
CREATE TABLE patient_table OF patient_typ;

-- method body definition
CREATE OR REPLACE TYPE BODY patient_typ AS
CONSTRUCTOR FUNCTION patient_typ(c_patient_Id NUMBER, c_fname VARCHAR2,
    c_lname VARCHAR2, c_sex CHAR, c_DOB DATE, c_addr address_typ, 
    c_blood_type CHAR, c_last_checkup DATE, c_record_info p_record)
RETURN SELF AS RESULT
IS 
BEGIN
    SELF.patient_id := c_patient_id;
    SELF.fname := c_fname;
    SELF.lname := c_lname;
    SELF.sex := c_sex;
    SELF.DOB := c_DOB;
    SELF.addr := c_addr;
    SELF.blood_Type := c_blood_type;
    SELF.last_checkup := c_last_checkup;
    SELF.record_info := c_record_info;
    RETURN;
END;
-- method to add new patient in to the system 
MEMBER PROCEDURE addPatient
IS
BEGIN
    INSERT INTO patient_table VALUES(fname, lname, sex, dob, addr, patient_id,
    blood_Type, last_checkup, record_info );
END;
-- to delete a certain patient from the database table based on its patient id
MEMBER PROCEDURE deletePatient(pid Number)
IS
BEGIN
    DELETE FROM patient_table WHERE patient_id = pid;
END;
--method to update last update of the patients visit
MEMBER PROCEDURE update_checkup(pid Number, newcheckup DATE)
IS 
BEGIN
    UPDATE patient_table SET last_checkup = newcheckup WHERE patient_id = pid;
END;
--MEMBER PROCEDURE getPatientInfo (pid NUMBER)
--IS var_patient patient_typ;
--BEGIN
--    SELECT ALL INTO var_patient FROM patient_table WHERE patient_id = pid;
--    var_patient.displayinfo;
--END;
-- method to set a patient record for the patient based on his investigation
MEMBER PROCEDURE setRecord(pid NUMBER, newrecinfo p_record)
IS
BEGIN
    UPDATE patient_table SET record_info = newrecinfo WHERE patient_id = pid;
END;
-- method to display information about the patient object type
MEMBER PROCEDURE displayinfo
IS 
BEGIN 
    dbms_output.put_line('PATIENT ID: ' || patient_id);
    dbms_output.put_line('NAME: ' || fname || ' ' || lname );
    dbms_output.put_line('SEX: ' || sex);
    dbms_output.put_line('DATE OF BIRTH: ' || DOB);
    dbms_output.put_line('BLOOD TYPE: ' || blood_type);
    dbms_output.put_line('LAST CHECK UP: ' || last_checkup);
    record_info.displayResult;
    dbms_output.put_line('STREET ADDRESS: ' || addr.street);
    dbms_output.put_line('CITY: ' || addr.city);
    dbms_output.put_line('PHONE NUMBER: ' || addr.phoneNo);
    dbms_output.put_line('E-MAIL: ' || addr.email);
    dbms_output.put_line('POSTAL NUMBER: ' || addr.postalNo);
END;
-- function method to return a patient record of a certain patient
MEMBER FUNCTION getRecid(PID NUMBER) RETURN p_record
IS var_record p_record;
BEGIN
    SELECT record_info INTO var_record FROM patient_table WHERE patient_id = pid;
    RETURN var_record;
END;
END; -- end of body definition of patient type

