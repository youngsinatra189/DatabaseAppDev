/*
File:               d.sql
Author:             Roshan Sahu
Oracle Username:    s6_sahuro
Description:        Obtains vehicle information and illustrates the information to the user */

SET SERVEROUTPUT ON;

-- Obtaining the name of the customer the user wants to query   
ACCEPT p_carserial PROMPT 'Enter the car serial no: '

DECLARE
    -- A row for the vehicle record
    v_car car%ROWTYPE;
    -- A row for the purchase invoice information
    v_purchinvno purchinv%ROWTYPE;
    -- A cursor for when procedure that will return a cursor of options
    l_cursor SYS_REFCURSOR;
    l_optioncode   options.optioncode%TYPE;
    l_optiondesc   options.optiondesc%TYPE;
    l_optionlistprice  options.optionlistprice%TYPE;
    
BEGIN
    -- Calling inquireCar procedure and obtaining a car record, purchinvno record, and options record
    inquireCar(UPPER('&p_carserial'),v_car, v_purchinvno);
    
    -- 1.1 Vehicle Info Labels
    DBMS_OUTPUT.PUT_LINE('VEHICLE INVENTORY RECORD' || CHR(10) || 
    '-----------------------------------------------------------------------------'||
    CHR(10) ||'|' || RPAD('Serial No. ',10) ||'|' || RPAD('Make ',7) ||'|' || RPAD('Model ',7) ||'|' ||
    RPAD('Year ',5) ||'|' || RPAD('ExteriorColor ',10) ||'|' || RPAD('Trim ',31) || '|' ||
    CHR(10) ||'|' || 
    -- 1.2 Vehicle Info 
    RPAD(v_car.carserial,10) ||'|' || RPAD(v_car.carmake,7) ||'|' || RPAD(v_car.carmodel,7) ||'|' ||
    RPAD(v_car.caryear,5) ||'|' || RPAD(v_car.extcolor,10) ||'|' || RPAD(v_car.cartrim,31) ||'|' ||    
    CHR(10) || 
    '-----------------------------------------------------------------------------'|| 
    -- 2.1 Purchase Labels
    CHR(10) ||'|' || RPAD('Purhcased From ',15) ||'|' || RPAD('Purhcase Inv.No ',15) ||'|' || RPAD('Purhcase Date ',13) ||'|' ||
    RPAD('Purchase Cost ',13)|| '|' || RPAD('List Base Price ',15) ||'|' ||
    -- 2.2 Purhcase Information
    CHR(10) ||'|' || RPAD(v_purchinvno.purchfrom ,15) ||'|' || RPAD(v_car.purchinvno ,15) || '|' || RPAD(v_purchinvno.purchdate,13) ||
    '|' || RPAD(v_car.purchcost,13)|| '|' || RPAD(v_car.carlistprice,15) ||'|' || 
    CHR(10) || 
     -- 3.0 Options
    '-----------------------------------------------------------------------------'|| CHR(10) ||
    RPAD('OPTIONAL EQUIPMENT AND ACCESSORIES - FACTORY',76) || '|' || CHR(10) ||
    '-----------------------------------------------------------------------------' || CHR(10) ||
    -- 3.1 Options Labels
    RPAD('Code ',5) || '|' || RPAD('Description ',13) || '|' || RPAD('List Price',56) || '|' || CHR(10) ||
    '-----------------------------------------------------------------------------');
    -- 3.2 Using the getOptions procedure to obtain the vehicle's options
    getOptions(UPPER('&p_carserial'), l_cursor);
    LOOP 
        FETCH l_cursor
        INTO  l_optioncode, l_optiondesc, l_optionlistprice;
    EXIT WHEN l_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(RPAD(l_optioncode,5) || '|' || RPAD(l_optiondesc,13) || '|' || RPAD(l_optionlistprice,56) || '|');
    END LOOP;
    CLOSE l_cursor;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('There is no car with this serial');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Please contact system administrator');
        
END;
/
EXIT;