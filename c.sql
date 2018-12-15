/*
File:               c.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Passes in information about a new vehicle record and uses newVehRecord procedure to insert the record into Car*/

SET SERVEROUTPUT ON;

-- Obtaining the information of the car the user wishes to create a record for
ACCEPT p_custname PROMPT 'Enter the name of the customer of the vehicle: '
ACCEPT p_carmake PROMPT 'Enter the make of the vehicle: '
ACCEPT p_carmodel PROMPT 'Enter the model of the vehicle: '
ACCEPT p_caryear PROMPT 'Enter the year of the vehicle: '
ACCEPT p_extcolor PROMPT 'Enter the color of the vehicle: '
ACCEPT p_cartrim PROMPT 'Enter the trim of the vehicle: '
ACCEPT p_enginetype PROMPT 'Enter the engine type of the vehicle: '
ACCEPT p_purchinvno PROMPT 'Enter the purhcase number of the vehicle: '
ACCEPT p_purchcost PROMPT 'Enter the purchase cost of the vehicle: '
ACCEPT p_freightcost PROMPT 'Enter the freight cost of the vehicle: '
ACCEPT p_carlistprice PROMPT 'Enter the car list price of the vehicle: '

DECLARE
    -- Declaring the car serial number so it can be constructed before it is passed to the procedure
    v_carserial car.carserial%TYPE;
    -- Declaring the confirmation message
    v_confirmation VARCHAR2(100);
    -- Exception handling
    NO_INPUT EXCEPTION;
    VALID_YEAR EXCEPTION;
    
BEGIN
    -- If there was a required field to make the carserial no that was not provided
    IF '&p_custname' = '' OR '&p_custname' IS NULL OR '&p_carmake' = '' OR '&p_carmake' IS NULL
    OR '&p_carmodel' = '' OR '&p_carmodel' IS NULL OR '&p_caryear' = '' OR '&p_caryear' IS NULL 
    OR '&p_extcolor' = '' OR '&p_extcolor' IS NULL OR '&p_carmodel' = '' OR '&p_carmodel' IS NULL THEN
        RAISE NO_INPUT;
    END IF;
    
    IF length('&p_caryear') != 4 OR '&p_caryear' > 0 THEN
        RAISE VALID_YEAR;
    END IF;
    -- Constructing a new car serial # for the new recod: The first character of the car make, last two digits of car year, first digita of 
    -- ext color, first three digits of car model, and a zero
    v_carserial := (substr('&p_carmake', 1, 1)|| substr('&p_caryear', 3, 2) || substr('&p_extcolor', 1, 1) || substr('&p_carmodel', 1, 3) || '0');
    
    -- Calling the new vehicle record procedure
    newVehRecord(UPPER(v_carserial), UPPER('&p_custname'), UPPER('&p_carmake'), UPPER('&p_carmodel'), '&p_caryear', '&p_extcolor', '&p_cartrim', 
    '&p_enginetype', '&p_purchinvno', '&p_purchcost', '&p_freightcost', '&p_carlistprice', v_confirmation);
    -- Printing out the confirmation record
    DBMS_OUTPUT.PUT_LINE(v_confirmation);
    
EXCEPTION
    WHEN VALID_YEAR THEN
        DBMS_OUTPUT.PUT_LINE('Please ensure you enter a valid year');
    WHEN NO_INPUT THEN
        DBMS_OUTPUT.PUT_LINE('Please ensure all required fields are completed');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Please contact the system administrator');   
END;
/
EXIT;