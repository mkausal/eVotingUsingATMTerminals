create database SE_Project_EC;

use SE_Project_EC;

create table Voter_Details (Voter_ID varchar(20) PRIMARY KEY,Voter_Name varchar(20),Pan_Card varchar(10));

insert into Voter_Details values('V00001','Kausal Malladi','BETPM9690A');

create table Voter_Registration(PAN_Card varchar(10) PRIMARY KEY,Status varchar(30));

