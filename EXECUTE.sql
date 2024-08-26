
SET SERVEROUTPUT ON;

DECLARE 
    v NUMBER;
    a address_typ;
    b address_typ;
    c address_typ;
    dr doctor_typ;
    nur nurse_typ;
    dru drug_typ;
    prec p_record;
    p patient_typ;
BEGIN
    a := address_typ('Main St.', 'Gondar', 'AMHARA', 0927382937, 
    'something@some.com', 2112);
    b := address_typ('South St.', 'Gondar', 'AMHARA', 0900837292,
    'try@test.com', 3445);
    c := address_typ('WEST St.', 'LA', 'CALI', 238926,
    'icloud@apple.com', 9876);
    
    dr := doctor_typ(001, 'Abebe','Kebede', 'M', '02-OCT-03', a, 'GENERAL',
    24000);
    dr.adddr;
    
    nur := nurse_typ(001, 'Gelete', 'Chala', 'F', '05-DEC-06', b, 'EMERGENCY',
    17000);
    nur.addnurse;
    
    dru := drug_typ(001, 'PARACETAMOL', 'PAIN-KILLER', '01-JAN-03', '03-JUN-07');
    
    DRU.adddrug;
    prec := p_record(001, dr, dru, 'NAUSIA, HEADACHE, COUGH', nur, 
    'RBC AND URINAL TEST', 'LEVEL 1 -> FLU WITH HEADACHE');
    prec.addrec;
    prec.displayResult;
    prec.displayDoctor;
    prec.displayNurse;
    prec.displayDrug; 
    
    p := patient_typ(002, 'Steve', 'Jobs', 'M', '01-JAN-01', c, 'O+', 
    '06-JUN-09', prec);
    p.addpatient;
    
    p.displayinfo;
    
END;


--DELETE FROM dr_table;
--DELETE FROM NURSE_table;
--DELETE FROM REC_TABLE;
    