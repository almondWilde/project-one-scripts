# PROJECT NAME

## Project Description

Here goes your awesome project description!

## Technologies Used

* Hive
* Hadoop
* Linux

## Features

List of features ready and TODOs for future development
###Problem Scenario 1
*What is the total number of consumers for Branch1?
*What is the number of consumers for the Branch2?
###Problem Scenario 2
*What is the most consumed beverage on Branch1?
*What is the least consumed beverage on Branch2?
###Problem Scenario 3
*What are the beverages available on Branch10, Branch8, and Branch1?
*what are the common beverages available in Branch4,Branch7?
###Problem Scenario 4
*create a partition,index,View for the scenario3.
###Problem Scenario 5
*Alter the table properties to add "note","comment"
###Problem Scenario 6
*Remove the row 5 from a table

To-do list:
* Add an ERD to the project folder

## Getting Started
   >Prerequisites: Hadoop and Hive should already be installed
   >Tested in Ubuntu
   `
   git clone https://github.com/almondWilde/project-one-scripts
   
   #add the datafiles to hdfs
   $hdfs dfs -put Bevs.txt ConsumerCount.txt /user/<hdfs username>/projectone
   
   #loadind the files into hive schema
   $hive -f setup.sql
   `

## Usage
Solve the problem scenarios by running the script:
`$hive -f master.sql`


