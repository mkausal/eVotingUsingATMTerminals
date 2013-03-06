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
