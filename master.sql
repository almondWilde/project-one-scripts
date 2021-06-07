-- Problem Scenario 1
-- What is the total number of consumers for Branch1?
select b.branch, sum(c.consumers) from branch b left join consumers c on (b.drink = c.drink) group by (b.branch) having (b.branch="Branch1");

-- What is the number of consumers for the Branch2?
select b.branch, sum(c.consumers) from branch b left join consumers c on (b.drink = c.drink) group by (b.branch) having (b.branch="Branch2");

-- Problem Scenario 2
-- What is the most consumed beverage on Branch1?
select b.drink, sum(c.consumers) as totalcount from bevbranch b left join consumers c on (b.drink = c.drink and b.branch = "Branch1") group by (b.drink) order by totalcount desc limit 1;

-- What is the least consumed beverage on Branch2?
select b.beverage, sum(s.order_count) as totalcount from bevbranch b left join stats s on (b.beverage = s.beverage and b.branch = "Branch2") group by (b.beverage) order by totalcount limit 10;

-- Problem Scenario 3
-- What are the beverages available on Branch10, Branch8, and Branch1?
select distinct beverage from bevbranch where (branch="Branch10" or branch="Branch8" or branch="Branch1");

-- what are the common beverages available in Branch4,Branch7?
create view branch4beverages(beverage, branch) as select * from bevbranch where branch="Branch4";
			-- >60 rows
create view branch7beverages(beverage, branch) as select * from bevbranch where branch="Branch7";
			-- >100 rows

select s.beverage, f.branch, s.branch from branch4beverages s inner join branch7beverages f on (f.beverage = s.beverage) group by s.beverage, s.branch, f.branch;
			-- >51 rows

-- Problem Scenario 4
-- create a partition,index,View for the scenario3.
		-- partition:
set hive.exec.dynamic.partition.mode=nonstrict;
create table bevbranch(beverage String) partitioned by (branch String) location '/user/wk/projectone/scenario3_part';
load data inpath '/user/wk/projectone/Bevs.txt' overwrite into table bevbranchpartition(branch);

		-- index:
create index s4 on table bevbranch (branch) as 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' with deferred rebuild;
		-- view:
ceate view bevbranch010810 as select distinct beverage from bevbranch where (branch="Branch10" or branch="Branch8" or branch="Branch1");
select * from bevbranch010810

-- Problem Scenario 5
-- Alter the table properties to add "note","comment"
  -- note:
alter table stats set tblproperties ('note'='shows sum of orders on a certain beverage');
alter table bevbranch set tblproperties ('note'='beverages and the branches they are available in');
	-- comment:
alter table bevbranch set tblproperties ('comment'='vague data points, good luck deciphering');
alter table stats set tblproperties ('comment'='good data, lets use this for production');

show tblproperties bevbranch;                                                 OK
show tblproperties stats;

-- Problem Scenario 6
-- Remove the row 5 from the output of Scenario 1
		-- //Performed not on Scenario 1
		-- //view created for this scenario
insert overwrite table s6 (select beverage, branch from (select *, row_number() over() as row_number from s6) as serialized_s6 where row_number != 5);
