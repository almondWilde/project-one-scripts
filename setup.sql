-- #create the project one database
create database if not exists projectone;
use projectone;

-- #build the schema
create table if not exists bevbranch(beverage String, branch String)row format delimited fields terminated by ',' stored as textfile;
load data inpath '/user/wk/projectone/Bevs.txt' overwrite into table bevbranch;
create table if not exists stats(beverage String, consumer_count int);
load data inpath '/user/wk/projectone/ConsumerCount.txt' overwrite into table stats;
