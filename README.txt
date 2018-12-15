The files in this directory provide a the items on the DBAS32100 final assignment.
The directory contains 13 scripts: 1 of which contain all the procedures, functions, and views required (this script is called 'Procedures.sql').
The Procedures.sql must be executed before in order to create objects in user's schema.
To execute the program the user must be in the same directory where the scrips reside, or provide the appropriate 
path to the main shell script called menu:
tcsh menu

//********* A: Create Customer***********//
If the user selects 'a' then the menu shell script calls a.sql to collect the information to enter a new customer. The script calls the createCustProcedure. a.sql passes in seven parameters: the customer's name, street address, city, province, postal code, and phone numbers. The values are passed IN to createCust and then a confirmation message, as VARCHAR2, is OUT. 

-------input-------
Enter the customers name: Mark Conseulos
Enter the customer street address: 123 Attractive Ave
Enter a customers city: Toronto
Enter a customers province Ex. PR: ON
Enter a customers postal code: L6L4P4
Enter a customers home phone number Ex. (123)456-7890: (123)456-7890
Enter a customers work phone number: Ex. (123)456-7890: (123)456-7890
-------output-------
The customer information for MARK CONSUELOS has been entered

//********* B: Retrieve a Customer Record ***********//

If the user selects 'b' then the menu shell script calls b.sql to collect a customer's name to inquire. The script calls the inquireCust procedure and does a basic selection of the customer table. b.sql passes in only one parameter: the customer's name. The values is passed IN to the inquireCust procedure and then a ROWTYPE of the customer's record OUT. b.sql then prints out the customer's information.

-------input-------
Enter the customers name: Roby karl
-------output-------
------------------------------
CUSTOMER INFORMATION
------------------------------
|Customer Name: ROBY KARL     |
|Street Address: Other Lane   |
|Postal Code: R5T5U6          |
|Home Phone: (614)521-7745    |
|Business Phone: (614)521-7745|
|Customer Work Phone: (647)584|
------------------------------

//********* C: Enter a New Vehicle Record***********//

If the user selects 'c' then the menu shell script calls c.sql to collect information about a new vehicle record. The script calls the newVehRecord procedure and inserts the information into the car database. c.sql passes all the required parameters for the new car record: Customer Name, Car Make, Car Model, Car Year, Ext Color, car Trim, Engine Type, Purchase Invoice Number, Purchase Cost, Freight Cost, and Car List Price. The values are passed IN to the newVehRecord procedure and then a confirmation message (VARCHAR2) OUT that the record has been created. c.sql then prints out the car record's information.

-------input-------
Enter the name of the customer of the vehicle: Roby Karl
Enter the make of the vehicle: ACURA
Enter the model of the vehicle: MDX
Enter the year of the vehicle: 2015
Enter the color of the vehicle: Silver
Enter the trim of the vehicle:: White
Enter the engine type of the vehicle: Premium
Enter the purchase number of the vehicle: 123456
Enter the purchase cost of the vehicle: 40000
Enter the freight cost of the vehicle: 1000
Enter the car list price of the vehicle: 42000
-------output-------
The new car record has been inserted successfully

//********* D: Retrieve a vehicle record ***********//

If the user selects 'd' then the menu shells script calls d.sql to retrieve information about a new vehicle record. The script calls the inqurieCar procedure and retrieves the information about the car. d.sql passes the required parameter, a Car Serial no, to the procedure. The value is passed IN to the inquireCarProcedure procedure and then OUT is both a car record and a purchinv record. The car record is used to illustrate the car's information while the purchinv record is used to illustrate the car's options, if any exist.

-------input-------
Enter the car serial no: 18A05484
-------output-------

VEHICLE INVENTORY RECORD
-----------------------------------------------------------------------------
|Serial No.|Make   |Model  |Year |ExteriorCo|Trim                           |
|A16GCCL0  |ACURA  |CCLASS |2016 |Grey      |NA                             |
-----------------------------------------------------------------------------
|Purhcased From |Purhcase Inv.No|Purhcase Date|Purchase Cost|List Base Price|
|SSAuto         |INVAAA         |19-JAN-82    |55555        |73508.5        |
-----------------------------------------------------------------------------
OPTIONAL EQUIPMENT AND ACCESSORIES - FACTORY                                |
-----------------------------------------------------------------------------
Code |Description  |List Price                                              |
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

//********* E: Create a New Sales Invoice ***********//
If the user selects 'e' then the menu shell script calls e.sql to collect the information to enter a new Sales Invoice record. There are many prompts that will be presented to the user and all are required except for Trade-In serial and allowance. The script will first check that the primary key values provided are valid using SI_CHECK functions. These functions accept the inputted value and run a SELECT statement to retrieve a COUNT(*) on the results. It returns the count back which tells the script whether that record exists or not. 
	- In the case of SI_CHECK_CAR, the check will also use a "WHERE custname IS NULL" clause to ensure that only cars which are not 		  yet sold are accepted as valid.
	- In the case of SI_CHECK_TRADEIN, the check is the same as SI_CHECK_CAR minus the WHERE clause on custname. The check is nested 	  in an if-statement block to ensure that in cases where the tradeserial is not provided, the program will bypass the check and 		  continue to execute
The script will check that all of the check variables are > 0 using an IF-Statement block. 
[*] If TRUE: it will add the new Sales Invoice record into the table and update the car record's custname column to refer to the provided custname. There is a confirmation output message which will advise the user that these changes were successfully processed.
The next step has the script entering another IF-Statement block to check if the value provided for tradeserial is null or if it is set to something. If it is a valid input, then the script retrieves the tradeallow value and runs an INSERT to add the new tradeinv record to the tradeinv table. The script will also run an UPDATE statement to set the custname value of the trade-in vehicle to NULL. The final step is to output another confirmation message to the user advising them of the changes that were made.
[*] If FALSE: the script will run through ELSIF blocks to try and determine which check failed and then trigger the appropriate EXCEPTION block output advising the user which value was invalid.

Example 1:
-------input-------
Enter Salespersons Name: JACK SPRATT
Enter Customer Name: jordan roy
Enter New Car Serial Number: h14bciv8
Fire Insurance? (Y/N): y
Collision Insurance? (Y/N): n
Liability Insurance? (Y/N): n
Property Insurance? (Y/N): y
Tax Rate (Ex. 13.0): 13.0
(Optional) Enter Trade-In Serial Number:
(Optional) Enter Trade-In Allowance: $
License Fee: $200
Discount: $3200
Commission: $800
Car Sale Price: $14800

-------output-------
Owner for the new car H14BCIV8 set to JORDAN ROY.
Press any key to continue .....

Example 2:
-------input-------
Enter Salespersons Name: JACK SPRATT
Enter Customer Name: jordan roy
Enter New Car Serial Number: h14bciv8
Fire Insurance? (Y/N): y
Collision Insurance? (Y/N): n
Liability Insurance? (Y/N): n
Property Insurance? (Y/N): y
Tax Rate (Ex. 13.0): 13.0
(Optional) Enter Trade-In Serial Number: a18bnsx0
(Optional) Enter Trade-In Allowance: $10000
License Fee: $200
Discount: $3200
Commission: $800
Car Sale Price: $14800

-------output-------
Owner for the new car H14BCIV8 set to JORDAN ROY.
Owner for trade-in car A18BNSX0 set to NULL.
Press any key to continue .....


//********* F. Inquire a sales invoice ***********//
If the user selects 'f' then the menu shell script calls f.sql to collect a Sales Invoice number and then retrieves the data and displays it for the user. To make the output possible, the script utilizes 3 cursors (which use 3 saves views) to retrieve the data. As long as a valid invoice number is given, the cursor is accessed and retrieves all the data from the saleinv table and begins to print the lines.  Once the script reaches the sections pertaining to additional car options and trade-in vehicles, the respective cursors to retrieve these values are accessed and output each record in it's own line until all are printed and then continues to execute the saleinv cursor output. Upon reaching the end of the output, a tracker variable is set to 1. In the event that the loop is skipped due to an error, then a NO_DATA_FOUND EXCEPTION is raised.

-------input-------
Enter a Sales Invoice Number: I00055

-------output-------

                        SPECIALTY IMPORTS
              SALES INVOICE

InvoiceNo.I00055        Date: 07-JUL-14
SOLD TO: Name:              JAIMEE GONZAGA
        Address:                LOLSTREET

______________________
        City:                   ROFLVILLE
        State:                  ON      Postal Code:L3F 3H8
        Telephone:              (617)405-6532

Salesman: CHUCK BARTOWSKI

Serial Number   Make
        Model           Year    Color
H12PACU0        HONDA           ACURA           2012    PURPLE

             Insurance Coverage Includes
        Fire & Theft    [N]             Liability       [N]
        Collision       [N]             Property Dam    [Y]

OPTIONS
Code           Description         Price

                  TRADE-IN
Serial No.    Make      Model     Year    Allowance
====================================================
          Total Price:           80090
    Trade-in Allowance:              0
              Discount:           4000
                   Net:
76000
                 Taxes:           9880
         Total Payable:          85880


Press any key to continue .....


//********* G. Create a new service work order ***********//
If the user selects 'g' then the menu shell script calls g.sql to collect the data to enter a new Service Work Order. Upon retrieving all the input data via prompts, the script checks the provided carserial and custname values to ensure they are valid and exist within their respective tables. If they do not exist, the user is prompted to enter this data first and the script terminates. As long as both checks pass, the script executes and will INSERT a record into the servinv table and another record into the servwork table.

-------input-------
Enter Customer Name: jordan roy
Enter Car Serial: a18bnsx0
Enter Work Description: oil change
Parts Cost: 35
Labor Cost: 25
Tax Rate (Ex. 13.0): 13.0

-------output-------
W7027 has been added.

Press any key to continue .....


//********* H. Inquire a service work order ***********//
If the user selects 'h' then the menu shell script calls h.sql which accepts a service invoice number and displays a Service Work Order on the users screen. The script validates the provided invoice number and if there are any issues, it will raise an appropriate exception. When a valid invoice number is provided, the script proceeds to retrieve the data via two cursors starting with the main data from the servinv table. Once the script reaches the section of the invoice to output the work description, it begins a nested loop to retrieve and print all the descriptions for the given invoice. Upon completion of the nested loop, the original output proceeds and is finalized.

-------input-------
Enter Service Invoice Number: W0397

-------output-------
                        SPECIALTY  IMPORTS
            SERVICE WORK ORDER

Service Invoice No: W0397
Date:23-SEP-16
Service for: Name: MYUNGSUK CHOI
   Address: 2365 Central Park

________________________
      City: Oakville      Postal code   L6H0C7


Telephone Work:(234)234-1111    Home:(234)123-1234

Serial Number   Make
Model     Year  Color
J14RXE00        JAGUAR    XE        2014  Red


Work to be Done:
Changing Tires

Costs:
   Parts:         1100
   Labor:          100
     Tax:          156

Total:         1356


Press any key to continue .....

//********* I: Create Prospect***********//
If the user selects 'i', the menu shell script calls i.sql script to create a prospect.
i.sql prompts the user to enter customer name, types of car and combinations of characteristics 
that customer has interest in.
i.sql uses add_prospect procedure to add a new prospect by passing seven parameters which are IN parameters.
The IN parameters are the customer name, car make, car model, car year, car color, car trim and the option code.
The parameters will hold the formatted customer information, which is inserted in the database by the calling script. 
If the user did not enter customer name or carmake, i.sql will raise the exceptions.
If the user entered the same prospect that already exists in the database, i.sql will raise the DUP_VAL_ON_INDEX exception.
For the other exceptions, OTHERS exception will be raised.
Here is a sample of the program execution: 

-------input-------
 Enter your option here: i
Enter Customer Name: ali
Enter Preferred Car Make: mercedes
Enter Preferred Car Model: g-class
Car year: 2015
Enter Preferred Colour: black
Car Trim: walnut wood
Enter option code for an additional option:

-------output-------
The data inserted.


//********* J: Inquire a prospective customer ***********//
If the user selects 'j', the menu shell script calls j.sql script to inquire a prospective customer.
j.sql prompts the user to enter a customer name to look up for.
j.sql uses get_cust_prospect procedure by passing two parameters one of which is an IN parameter and the other 
is an OUT parameter. The IN parameter is the entered customer name and the OUT parameter is a SYS_REFCURSOR that 
will hold the records of the customer and prospect information selected from the database, which are printed out 
by the calling script. 
If there is any error with cursor, INVALID_CURSOR exception will be raised.
If data is not found with SELECT statement, NO_DATA_FOUND exception will be raised.
If the user do not provide the customer name, NO_CUSTNAME_INPUT exception will be raised. 
For the other exceptions, OTHERS exception will be raised.
Here is a sample of the program execution:

-------input-------
 Enter your option here: j
Enter the prospective customer name: anju kohli

-------output-------
                                anju kohli PREFERES THE FOLLOWING:
---------------------------------------------------------------------------------------------------
CustomerName   HomePhone      Make        Model    Year  Colour Trim                Option
---------------------------------------------------------------------------------------------------
ANJU KOHLI     (212)232-3434  JAGUAR      GT       2006  WHITE  SEUDE               SKI RACK
ANJU KOHLI     (212)232-3434  JAGUAR      UX       2001  INDIGO WHITE               SKI RACK
ANJU KOHLI     (212)232-3434  LAND ROVER  PY       2000  GREY   BLACK LEATHER       TINTED SUN ROO


//********* K: Generate a prospect list ***********//
If the user selects 'k' the menu shell script calls k.sql script to generate a prospect list. 
k.sql uses get_prospects procedure by passing a parameter which is an OUT parameter. 
The OUT parameter is SYS_REFCURSOR that will hold all of the selected customer and prospect information 
which is printed out by the calling script using LOOP and FETCH statements. 
If there is any error with cursor, INVALID_CURSOR exception will be raised.
If no data is found with SELECT statement, NO_DATA_FOUND exception will be raised.
For the other exceptions, OTHERS exception will be raised.

Here is a sample of the program execution:

-------input-------
 Enter your option here: k

-------output-------
                                        PROSPECT LIST
---------------------------------------------------------------------------------------------------
CustomerName   HomePhone      Make        Model    Year  Colour Trim                Option
---------------------------------------------------------------------------------------------------
ABDALLA FREIHAT(905)890-0484  ACURA       INTEGRA  2006  SILVER SILVER              CD PLAYER
ABDALLA FREIHAT(905)890-0484  MERCEDES    BENZ     2005  BLACK  BLACK               SUN ROOF
ADAM           (416)866-7894  LAND ROVER  Defen 90 2016  White  Vinyl               TAPE DECK
......


//********* L: Delete a prospect entry ***********//
If the user selects 'l' the menu shell script calls l.sql script to delete a prospect record. 
l.sql uses deleteProspect procedure by passing eight parameters one of which is an OUT parameter and the others 
are IN parameters. The OUT parameter is a VARCHAR2 that will hold the result string. 
The IN parameters consist of customer name, car make, car model, car year, car color, car trim, and option code. 
If the entered data matches with a stored record, the record will be deleted by the calling script.
Otherwise, an exception will be raised with the message to re-enter the information.
To consider the null types in the record of the Prospect table, multiple if-else statements were used. 
Here is a sample of the program execution:

-------input-------
 Enter your option here: L
Enter Customer Name (Required): LUCAS NGUYEN
Enter Preferred Car Make (Required): MERCEDES
Enter Preferred Car Model: I8
Car year: 2016
Enter Preferred Colour: RED
Car Trim:
Enter option code for an additional option: SD1

-------output-------
The prospect has been deleted

