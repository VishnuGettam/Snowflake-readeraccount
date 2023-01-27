--Managed account creation
create managed account vg_reader
admin_name = 'vg_reader'
admin_password = 'Gettam@0406'
type = 'reader';

--create share object (use accountadmin)
create or replace share share_dev_customer;

--assing the required DB objects to be shared 
show shares;

--desc the share object 
desc share share_dev_customer;

--Sample DB/Schema and tables creation
create database shared_db;

create schema source;

create or replace table tblcustomers
as
select  
c_customer_id,
c_first_name,
c_last_name,
c_birth_country
from snowflake_sample_data.tpcds_sf100tcl.customer limit 1000;


--grant DB usage privelage 
grant usage on database shared_db to share share_dev_customer;

grant usage on schema shared_db.source to share share_dev_customer;

grant select on table shared_db.source.tblcustomers to share share_dev_customer; 

--add the reader account to the share DB object
alter share share_dev_customer add accounts = AZ07484;
