create database SE_Project_Bank;

use SE_Project_Bank;

create table Customer_Details (Customer_ID varchar(20),Customer_Name varchar(20),ATM_Card_Number long,Voting_Right char,Pan_Card varchar(10));

insert into Customer_Details values('C00001','Kausal',9876543210987654,'Y','BETPM9690A');

insert into Customer_Details values('C00002','Srivatsan',1234567890098765,'','XYZPM7658A');

alter table Customer_Details add primary key (Customer_ID);

insert into Customer_Authentication values('C00001','1234');

insert into Customer_Authentication values('C00002','5678');