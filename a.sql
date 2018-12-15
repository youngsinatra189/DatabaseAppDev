/*
File:               a.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Enters a new customer */
SET SERVEROUTPUT ON;

-- Prompting the customer for the required information
ACCEPT p_custname PROMPT 'Enter the customers name: '
ACCEPT p_custstreet PROMPT 'Enter the customer street address: '
ACCEPT p_custcity PROMPT 'Enter a customers city: '
ACCEPT p_custprovince PROMPT 'Enter a customers province Ex. PR: '
ACCEPT p_custpostal PROMPT 'Enter a customers postal code: '
ACCEPT p_custhphone PROMPT 'Enter a customers home phone number Ex. (123)-456-7890: '
ACCEPT p_custbphone PROMPT 'Enter a customers work phone number: Ex. (123)-456-7890: '

DECLARE
    -- Declaring the confirmation message
    v_confirmation VARCHAR2(100);
    -- Exception handling
    NO_CUSTNAME_INPUT EXCEPTION;
    PROVINCE_CODE EXCEPTION;
    
BEGIN
    -- If there is no customer name
    IF '&p_custname' = '' OR '&p_custname' IS NULL THEN
        RAISE NO_CUSTNAME_INPUT;
    END IF;
    -- If province code is more than two characters name
    IF length('&p_custprovince') > 2 THEN
        RAISE PROVINCE_CODE;
    END IF;
    -- Calling the createCustomer procedure
    createCust(UPPER('&p_custname'), '&p_custstreet', '&p_custcity', '&p_custprovince', '&p_custpostal', '&p_custhphone', '&p_custbphone', v_confirmation);
    -- Printing out the confirmation message   
    DBMS_OUTPUT.PUT_LINE(v_confirmation);

EXCEPTION
    WHEN PROVINCE_CODE THEN
        DBMS_OUTPUT.PUT_LINE('Please ensure youve entered the province code correctly. Ex. ON.');
    WHEN NO_CUSTNAME_INPUT THEN
        DBMS_OUTPUT.PUT_LINE('Please ensure a customer name is entered.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Please contact the system administrator.');  
END;
/
EXIT;