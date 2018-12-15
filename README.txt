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

