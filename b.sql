/*
File:               b.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Uses the inquireCust procedure to display info about an exisitng customer*/

SET SERVEROUTPUT ON;

-- Obtaining the name of the customer the user wants to query   
ACCEPT p_custname PROMPT 'Enter the customers name: '

DECLARE
    v_customer customer%ROWTYPE;

BEGIN  
    inquireCust(UPPER('&p_custname'),v_customer);
    
    DBMS_OUTPUT.PUT_LINE('------------------------------' || CHR(10)||
    'CUSTOMER INFORMATION' || CHR(10) || '------------------------------' ||
    CHR(10) ||'|' || RPAD('Customer Name: ' || v_customer.custname,29) ||'|' ||
    CHR(10) ||'|' || RPAD('Street Address: ' || v_customer.custstreet,29) ||'|' || 
    CHR(10) ||'|' ||  RPAD('Postal Code: ' || v_customer.custpostal,29) ||'|' || 
    CHR(10) ||'|' || RPAD('Home Phone: ' || v_customer.custhphone,29) ||'|' || 
    CHR(10) ||'|' || RPAD('Business Phone: ' || v_customer.custhphone,29) ||'|' || 
    CHR(10) ||'|' || RPAD('Customer Work Phone: ' || v_customer.custbphone,29) ||'|' || 
    CHR(10) || '------------------------------');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('There is no customer with this name');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Please contact system administrator');
        
END;
/
EXIT;