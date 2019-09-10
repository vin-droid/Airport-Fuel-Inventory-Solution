#  Airport Fuel Inventory Solution

**Problem Statement:**
The goal is to generate fuel consumption report of airport. Application will be run from command
line based on the menu options as below. Note, the number stands for menu option and text is
the description of the option.


**Option Code | Title: 0 | Initiate**  
Description - Initiate / re-initiate the airport fuel data based on the table below.
```
Airport ID   Airport Name                                       Fuel Capacity(ltrs)   Fuel Available(ltrs)
1            Indira Gandhi International Airport,Delhi          500000                25066
2            Rajiv Gandhi International Airport, Hyderabad      500000                350732
3            Chhatrapati Shivaji International Airport, Mumbai  500000                288467
4            Chennai International Airport, Chennai             500000                497460
5            Kempegowda International Airport, Bangalore        500000                123456
```

**Option Code | Title: 1 | Show Fuel Summary at all Airports**  
Description - Shows the below table as output with the actual fuel available in each airport.
```
Choose Your Option:
> 1
Airport                                            Fuel Available
Indira Gandhi International Airport, Delhi         25066
Rajiv Gandhi International Airport, Hyderabad      350732
Chhatrapati Shivaji International Airport, Mumbai  288467
Chennai International Airport, Chennai             497460
Kempegowda International Airport, Bangalore        123456
```

**Option Code | Title: 2 | Update Fuel Inventory of a selected Airport**  
Description - Takes Airport ID and Fuel as input, then creates transaction and adds to the fuel
available. Make sure to validate it against the actual Fuel capacity to fill in and captures the
date/time of transaction.
```
Choose Your Option:
> 2
Enter Airport ID:
> 2
Enter Fuel (ltrs):
> 500000
Error: Goes beyond fuel capacity of the airport
Choose Your Option:
> 2
Enter Airport ID:
> 3
Enter Fuel (ltrs):
> 150000
Success: Fuel inventory updated
```



**Option Code | Title: 3 | Fill Aircraft**  
Description - Takes Airport ID, Aircraft Code and Fuel as input, then creates a transaction and
deduct to the fuel available accordingly. Make sure to validate it against the actual Fuel
available and captures the date/time of transaction.
```
Choose Your Option:
> 3
Enter Airport ID:
> 1
Enter Aircraft Code:
> 6E-102
Enter Fuel (ltrs):
> 30000
Failure: Request for the fuel is beyond availability at airport
```
```
Choose Your Option:
> 3
Enter Airport ID:
> 2
Enter Aircraft Code:
> 6E-102
Enter Fuel (ltrs):
> 30000
Success: Request for the has been fulfilled
```



**Option Code | Title: 4 | Show Fuel Transaction for All Airport**  
Description - Show a report as per the below format, based on the above examples. Feel free to
use any date/time format as you like.
```
Choose Your Option:
> 4
Airport: Indira Gandhi International Airport, Delhi
Date/time             Type   Fuel   Aircraft
2019-08-01 14:20:30   In     25066
Fuel Available: 25066
---
Airport: Rajiv Gandhi International Airport, Hyderabad
Date/time             Type   Fuel   Aircraft
2019-08-01 14:20:30   In     350732
2019-08-01 15:10:11   Out    30000  6E-102
Fuel Available: 320732
---
Airport: Chhatrapati Shivaji International Airport, Mumbai
Date/time             Type   Fuel   Aircraft
2019-08-01 14:20:30   In     288467
2019-08-01 15:10:11   In     150000
Fuel Available: 438467
---
Airport: Chennai International Airport, Chennai
Date/time             Type   Fuel   Aircraft
2019-08-01 14:20:30   In     497460
Fuel Available: 497460
---
Airport: Kempegowda International Airport, Bangalore
Date/time             Type   Fuel   Aircraft
2019-08-01 14:20:30   In     123456
Fuel Available: 123456
```

**Option Code | Title: 9 | Exit**  
Description - Exit from the program.

## Setup
First, install [Ruby](https://www.ruby-lang.org/en/documentation/installation/). Then run the following commands.

```
airport_fuel_inventory $ ruby -v # confirm Ruby present
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
airport_fuel_inventory $ chmod +x ./bin/setup # Make executable file
airport_fuel_inventory $ ./bin/setup  # Executable setup file
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Using bundler 1.17.2
Using diff-lcs 1.3
Using rspec-support 3.8.2
Using rspec-core 3.8.2
Using rspec-expectations 3.8.4
Using rspec-mocks 3.8.1
Using rspec 3.8.0
Bundle complete! 1 Gemfile dependency, 7 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

## Usage

You can execute the program and launch the shell
```
airport_fuel_inventory $ bin/airport_fuel_inventory_system

```

Enter your Choice:
```
0 #Initiate / re-initiate the airport fuel data and shows full fuel summary at all ports.
1 #Shows fuel available in each airport.
2 #Takes Airport ID and Fuel as input, then creates transaction and adds to the fuel available.
3 #Takes Airport ID, Aircraft Code and Fuel as input, then creates a transaction and deduct to the fuel available accordingly.
4 #Shows Fuel Transaction for All Airport
9 #Exit from program
exit #Exit from program
```
You can run the full test suite from `airport_fuel_inventory_system` by doing
```
airport_fuel_inventory $ rspec ./functional_spec
```