create database SE_Project_EC;

use SE_Project_EC;

create table Voter_Details (Voter_ID varchar(20) PRIMARY KEY,Voter_Name varchar(20),Pan_Card varchar(10));

insert into Voter_Details values('V00001','Kausal Malladi','BETPM9690A');

create table Voter_Registration(PAN_Card varchar(10) PRIMARY KEY,Status varchar(30));

alter table Voter_Details add column Mobile_Number long;

update Voter_Details set Mobile_Number=9535152658 where Voter_ID='V00001';

create table Voter_OTP(Voter_ID varchar(20) references Voter_Details(Voter_ID),OTP int);

insert into Voter_OTP values('V00001',987654);

create table Voter_PIN(Voter_ID varchar(20) references Voter_Details(Voter_ID),PIN varchar(4));

insert into Voter_PIN values('V00001','1234');

create table Voter_Vote(Voter_ID varchar(20) references Voter_Details(Voter_ID),Election_Type varchar(20),Constituency_ID varchar(20),Candidate_ID varchar(10));

create table Voter_Rejected_Vote(Voter_ID varchar(20) references Voter_Details(Voter_ID),Election_Type varchar(20),Constituency_ID varchar(20),Candidate_ID varchar(10));

create table Client_Keys(Machine_ID int primary key,Key_Value varchar(256));

insert into Client_Keys values(1,'00:23:4d:20:5a:8e');

create table Voter_Constituency(Voter_ID varchar(20) references Voter_Details(Voter_ID),Election_Type varchar(20),Constituency_ID varchar(10));

insert into Voter_Constituency values('V00001','General','AP060');

create table Constituency_List(Constituency_ID varchar(10),Election_Type varchar(20),Constituency_Name varchar(40));

insert into Constituency_List values('AP032','General','Secunderabad');

insert into Constituency_List values('AP132','State','L B Nagar');

drop table Voter_Constituency;

create table Voter_Constituency(Voter_ID varchar(20) references Voter_Details(Voter_ID),Constituency_ID varchar(10));

insert into Voter_Constituency values('V00001','AP032');

insert into Voter_Constituency values('V00001','AP132');

create table Candidate_Vote(Constituency_ID varchar(10),Candidate_ID varchar(10),Vote_Count int);

insert into Candidate_Vote values('General','AP032','32',0);

insert into Candidate_Vote values('State','AP132','12',0);

insert into Candidate_Vote values('State','AP132','32',0);

insert into Candidate_Vote values('General','AP032','12',0);

alter table Voter_Vote drop Candidate_ID;

alter table Voter_Vote add column Already_Voted char(1);

alter table Voter_Rejected_Vote drop Candidate_ID;

alter table Voter_Rejected_Vote add column Already_Voted_Count int;

update Voter_Rejected_Vote set Already_Voted_Count=0;

update Voter_Vote set Already_Voted='N';

alter table Voter_Vote add column Already_Voted varchar(1);
