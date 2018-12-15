/*
File:               checkOptionsProcedure.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        A procedure that used to compliement inquireCarProcedure and returns a cursor with a cars options*/

CREATE OR REPLACE PROCEDURE getOptions
(
    -- Passing in the car serial
     pl_carserial IN car.carserial%TYPE,
     -- Returning a singular car row 
     pl_options OUT SYS_REFCURSOR
)
AS
BEGIN
    -- Selecting the options row(s) into the return record
    OPEN pl_options FOR
    SELECT options.optioncode, options.optiondesc, options.optionlistprice
      FROM options, baseoption
     WHERE options.optioncode = baseoption.optioncode
       AND baseoption.carserial = pl_carserial
     ORDER BY options.optioncode;    
END;
/

/*
File:               createCustProcedure.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        A procedure that inquires about a customer and returns the details */

CREATE OR REPLACE PROCEDURE createCust
(
     -- Passing in all the required elements for customer
     v_custname IN customer.custname%TYPE,
     v_custstreet IN customer.custstreet%TYPE,
     v_custcity IN customer.custcity%TYPE,
     v_custprovince IN customer.custprovince%TYPE,
     v_custpostal IN customer.custpostal%TYPE,
     v_custhphone IN customer.custhphone%TYPE,
     v_custbphone IN customer.custbphone%TYPE,
     v_confirmation OUT VARCHAR2
)
AS
BEGIN
    INSERT INTO customer
    -- Inserting all the passed in values into customer
    VALUES(v_custname, v_custstreet, v_custcity, v_custprovince, v_custpostal, v_custhphone, v_custbphone);
    -- The confirmation message
    v_confirmation := 'The customer information for ' || v_custname || ' has been entered';
    COMMIT;
END;
/

/*
File:               createVehicelRecord.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Creates a new inventory vehicle record */

CREATE OR REPLACE PROCEDURE newVehRecord
(        
    -- Passing in all the requirments of a card record and returning the confirmation message
     v_carserial IN car.carserial%TYPE,    
     v_custname IN car.custname%TYPE,
     v_carmake IN car.carmake%TYPE,
     v_carmodel IN car.carmodel%TYPE,
     v_caryear IN car.caryear%TYPE,
     v_extcolor IN car.extcolor%TYPE,
     v_cartrim IN car.cartrim%TYPE,
     v_enginetype IN car.enginetype%TYPE,
     v_purchinvno IN car.purchinvno%TYPE,
     v_purchcost IN car.purchcost%TYPE,
     v_freightcost IN car.freightcost%TYPE,
     v_carlistprice IN car.carlistprice%TYPE,
     v_confirmation OUT VARCHAR2
)
AS
BEGIN
    -- Inserting all the requirements into car
    INSERT INTO car
    VALUES(v_carserial, v_custname, v_carmake, v_carmodel, v_caryear, v_extcolor, v_cartrim, v_enginetype, v_purchinvno, v_purchcost, v_freightcost, v_carlistprice);
    v_confirmation := 'The new car record has been inserted successfully';
    COMMIT;
END;
/

/*
File:               deleteProspect.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Inquires about a prospect and deletes it */

CREATE OR REPLACE PROCEDURE deleteProspect
(
     -- Passing in all the required elements for the prospect
    v_custname IN prospect.custname%TYPE,
    v_carmake IN prospect.carmake%TYPE, 
    v_carmodel IN prospect.carmodel%TYPE,
    v_caryear IN prospect.caryear%TYPE, 
    v_carcolor IN prospect.carcolor%TYPE,
    v_cartrim IN prospect.cartrim%TYPE, 
    v_optioncode IN prospect.optioncode%TYPE,     
    -- Declaring the confirmation message    
    v_confirmation OUT VARCHAR2
)
AS
BEGIN
    -- Case 1: - Nothing Null
    IF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;
    -- Case 2: - 00001      
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode IS NULL;
    -- Case 3: - 00010       
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode = v_optioncode;
    -- Case 4: - 00011  
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode IS NULL;
    -- Case 5: - 00100 
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;
    -- Case 6: - 00101 
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode IS NULL;
    -- Case 7: - 00110 
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode = v_optioncode;
    -- Case 8: - 00111       
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode IS NULL;      
    -- Case 9: - 01000  
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;
    -- Case 10: - 01001  
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode IS NULL;
    -- Case 11: - 01010 
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode = v_optioncode;
    -- Case 12: - 01011 
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode IS NULL;    
    -- Case 13: - 01100
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;    
    -- Case 14: 01101  
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode IS NULL;       
    -- Case 15: 01110
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode = v_optioncode;       
    -- Case 16: 01111
    ELSIF v_carmodel IS NOT NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel = v_carmodel
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode IS NULL;      
    -- Case 17: 10000
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;     
    -- Case 18: 10001
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode IS NULL;    
    -- Case 19: 10010
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode = v_optioncode;    
    -- Case 20: 10011
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode IS NULL;    
    -- Case 21: 10100
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;      
    -- Case 22: 10101
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode IS NULL;        
    -- Case 23: 10110
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode = v_optioncode;         
     -- Case 24: 10111
    ELSIF v_carmodel IS NULL AND v_caryear IS NOT NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear = v_caryear
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode IS NULL;     
    -- Case 25: 11000
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;      
    -- Case 26: 11001
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim = v_cartrim
          AND optioncode IS NULL;      
    -- Case 27: 11010
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode = v_optioncode;      
    -- Case 28: 11011
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NOT NULL AND v_cartrim IS NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor = v_carcolor
          AND cartrim IS NULL
          AND optioncode IS NULL;      
    -- Case 29 11100
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode = v_optioncode;      
    -- Case 30 11101
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NOT NULL AND v_optioncode IS NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim = v_cartrim
          AND optioncode IS NULL;      
    -- Case 31 11110
    ELSIF v_carmodel IS NULL AND v_caryear IS NULL AND v_carcolor IS NULL AND v_cartrim IS NULL AND v_optioncode IS NOT NULL THEN
        DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode = v_optioncode; 
    ELSE 
       DELETE FROM prospect
        WHERE custname = v_custname
          AND carmake = v_carmake
          AND carmodel IS NULL
          AND caryear IS NULL
          AND carcolor IS NULL
          AND cartrim IS NULL
          AND optioncode IS NULL;       
    END IF;
COMMIT;
    v_confirmation := 'The prospect has been deleted';
END;
/

/************************************************************
* i_procedure.sql                                           *
* SeungChan Kim                                             *
* s6_kimseu                                                 *
* Procedure for adding a new prospect record                *
*************************************************************/
CREATE OR REPLACE PROCEDURE add_prospect
(   pl_custname   IN prospect.custname%TYPE,
    pl_carmake    IN prospect.carmake%TYPE,
    pl_carmodel   IN prospect.carmodel%TYPE,
    pl_caryear    IN prospect.caryear%TYPE,
    pl_carcolor   IN prospect.carcolor%TYPE,
    pl_cartrim    IN prospect.cartrim%TYPE,
    pl_optioncode IN prospect.optioncode%TYPE
)
AS
BEGIN
    INSERT INTO prospect (custname, carmake, carmodel, caryear, carcolor, cartrim, optioncode)
         VALUES (pl_custname, pl_carmake, pl_carmodel, pl_caryear, pl_carcolor, pl_cartrim, pl_optioncode);
END add_prospect;
/

/*
File:               inquireCarProcedure.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Inquires about a car record and return the form */

CREATE OR REPLACE PROCEDURE inquireCar
(
    -- Passing in the car serial
     pl_carserial IN car.carserial%TYPE,
     -- Returning a singular car row 
     pl_carinfo OUT car%ROWTYPE,
     -- Also returning the corresponding row from purchase invoice
     pl_purchinfo OUT purchinv%ROWTYPE
)
AS
BEGIN
    -- Selecting the car row into the return record
    SELECT *
      INTO pl_carinfo
      FROM car
     WHERE carserial = pl_carserial;
     
     -- Selecting the purchase invoice record that holds info like purchased from and purch date
     SELECT purchinv.purchinvno, purchinv.purchfrom, purchinv.purchdate
      INTO pl_purchinfo
      FROM car, purchinv 
     WHERE car.purchinvno = purchinv.purchinvno
       AND car.carserial = pl_carserial;     
    
END;
/

/*
File:               inquireCustProcedure.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Inquires about a customer and returns his or her details */

CREATE OR REPLACE PROCEDURE inquireCust
(
    -- Passing in the customer name
     pl_custname IN customer.custname%TYPE,
     -- Returning a singular customer row 
     pl_custinfo OUT customer%ROWTYPE
)
AS
BEGIN
    -- Selecting the customer row into the return record
    SELECT *
      INTO pl_custinfo
      FROM customer
     WHERE custname = UPPER(pl_custname);  
    
END;
/