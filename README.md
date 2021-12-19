# BashDatabase
A basic Database in  Bash
To get this to properly function you need to start the server pipe, and any amount of user pipes. 
There are a number of basic commands:
  create_database (requires 1 argument a database name)
  create_table (requires 3 arguments:existing database name, table name, column title names)
  insert (requires 3 arguments: existing database name, existing table name, a tuple of values equal to the columns in the table)
  select (requires 3 arguments: existing database name, existing table name, select requested columns)
  select_where (requires 4 arguments: existing database name, existing table name, select requested columns, select value which is required in each row)
  shutdown.
The client can differentiate between the varios different users, but will shutdown if there is an incorrect request made.

Python validator available upon request..
