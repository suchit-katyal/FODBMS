/*Project Title - Payroll and Performance Evaluation Management System

Submitted By - Group - 9
Anisha Siwas - 025007
Suchit Katyal - 025033
Kartik Mohan Sinha - 025017
*/

/********************************************************************************************/

/* Aim : The main objective of this project is to design a payroll management
system which will maintain record of all the employees within an organization
like salary/bonus calculation, annual performance score, personal records, job departments,
leaves etc. Each stakeholder has limited rights in the system as per their role.

creating database for payroll and performance evaluation management system as PPEMS and using it to create tables in it.*/

create database if not exists PPEMS ;

use PPEMS;

/********************************************************************************************/

/* creating required tables. */

create table job_department ( job_ID char(5) primary key,    
                              job_dept varchar(25),                    
                              description varchar(25)
                                )  ;                

insert into job_department values ( '12301' , 'sales' , 'generates revenue' ) ;
insert into job_department values ( '12302' , 'finance' , 'manages accounts' ) ;
insert into job_department values ( '12303' , 'human resource' , 'manages manpower' ) ;
insert into job_department values ( '12304' , 'operations' , 'supervise logistics' ) ;
insert into job_department values ( '12305' , 'sales' , ' lead generation' ) ;

select * from job_department ;
   
create table employee ( emp_ID char(5) primary key,              
                        fname varchar(25),
                        lname varchar(25),                  
                        gender varchar(10),
                        age int ,
                        contact_add varchar(25),
                        emp_email varchar(25),
                        emp_pass varchar(25))  ;

insert into employee values ('a12d' , 'suchit' , 'katyal' , 'male' , 22 ,'presidents house' , 'suchit@gmail.com' , 'abc' ) ;
insert into employee values ('b12d' , 'arpit' , 'sharma' , 'male' , 99 , 'white hoouse' , 'arpit@gmail.com' , 'lll' );
insert into employee values ('c12d' , 'pankaj' , 'grover' , 'male' , 22 ,'v-60 shyam nagar' , 'pankaj@gmail.com' , 'llc' );
insert into employee values ('d12d' , 'akansha' , 'gupta' , 'female' , 20 , 'k-90 ram nagar' , 'akansha@gmail.com' , 'ppc' );
insert into employee values ('e12d' , 'kanak' , 'singh' , 'male' , 29 , 'm-70 ram nagar' , 'kanak@gmail.com' , 'ooc' );

CREATE TABLE if not exists salary ( salary_id char(5) primary key,
                                    basic_pay int NOT NULL,
                                    variable_Pay int,
                                    CONSTRAINT basic_pay_greater CHECK (basic_pay>variable_pay));

insert into salary values('00001', 35000, 10000) ;
insert into salary values('00002', 45000, 13500) ;
insert into salary values('00003', 63000, 18000) ;
insert into salary values('00004', 28000, 17000) ;
insert into salary values('00005', 45000, 20000) ;


CREATE TABLE if not exists leaves ( leave_id char(5) primary key,
                                   leave_type varchar(25) NOT NULL,
                                   status varchar(20) NOT NULL,
                                   date DATE NOT NULL );

insert into leaves values('10001', 'sick_leave', 'approved', '2022-01-10' ) ;
insert into leaves values('10002', 'casual_leave', 'not_approved', '2022-01-15') ;
insert into leaves values('10003', 'sick_leave', 'approved', '2022-01-16') ;
insert into leaves values('10004', 'sick_leave', 'approved', '2022-01-22') ;
insert into leaves values('10005', 'casual_leave', 'approved', '2022-01-27') ;

create table if not exists annual_performance_score ( score_id char(5) primary key ,    
                                                      score int check (score>=0 and score<=5) NOT NULL ,
                                                      remarks varchar(30)                             
                                                      ) ;

insert into annual_performance_score values ( '33001' , 5 , 'excellent work' ) ;
insert into annual_performance_score values ( '33002' , 4 , 'very good performance' ) ;
insert into annual_performance_score values ( '33003' , 3 , 'good work' ) ;
insert into annual_performance_score values ( '33004' , 2 , 'average performance' ) ;
insert into annual_performance_score values ( '33005' , 1 , 'need to improve' ) ;

create table if not exists payroll ( payroll_id char(5) primary key ,
                                     pf_acc_no varchar(5) UNIQUE ,
                                     date DATE NOT NULL , 
                                     net_amount int(10) NOT NULL
                                      );

insert into payroll values ( '25001' , 'ab12q' , '2022-01-31' , 250000 ) ;
insert into payroll values ( '25002' , 'cd62k' , '2022-01-31' , 300000 ) ;
insert into payroll values ( '25003' , 'ef52h' , '2022-01-31' , 1000000 ) ;
insert into payroll values ( '25004' , 'gh02f' , '2022-01-31' , 50000 ) ;
insert into payroll values ( '25005' , 'ij85h' , '2021-01-31' , 750000 ) ;

/**************************************************************************************************/

/* creating required relationsgip tables and stating assumptions for each table.

Assumptions for relationship_employee_payroll table - 
1. emp_ID maybe repeated as an employee will get payroll every month but payroll_id will not be repeated as it is like an transaction ID which is created every month and is unique.*/

create table relationship_employee_payroll ( emp_ID char(5) ,
                                             payroll_id char(5) ,
                                             primary key (payroll_id),
                                             foreign key (emp_ID) references employee (emp_ID) ,
                                             foreign key (payroll_id) references payroll (payroll_id) );

insert into relationship_employee_payroll values ( 'a12d' , '25001' ) ;
insert into relationship_employee_payroll values ( 'a12d' , '25002' ) ;
insert into relationship_employee_payroll values ( 'c12d' , '25005' ) ;
insert into relationship_employee_payroll values ( 'd12d' , '25004' ) ;
insert into relationship_employee_payroll values ( 'e12d' , '25003' ) ;

/* Assumptions for relationship_employee_job_department -
1. emp_ID can be repeated as an employee be transferred to another department and job_ID will be reapeated as there can be many employees within a job department but together they will be unique. */

create table relationship_employee_job_department ( emp_ID char(5),
                                                    job_ID char(5) ,
                                                    primary key (emp_ID, job_ID),
                                                    foreign key (emp_ID) references employee (emp_ID),
                                                    foreign key (job_ID) references job_department (job_ID) );

insert into relationship_employee_job_department values ( 'a12d' , '12301' ) ;
insert into relationship_employee_job_department values ( 'b12d' , '12301' ) ;
insert into relationship_employee_job_department values ( 'a12d' , '12302' ) ;
insert into relationship_employee_job_department values ( 'd12d' , '12303' ) ;
insert into relationship_employee_job_department values ( 'e12d' , '12303' ) ;

/* Assumption for relationship_employee_annual_performance_score -
1. emp_ID is repeated because employee will be given evaluation score every year and score_id is repeated because a particular score can be given to many employees. An employee can score same in 2 years so year added and all 3 together forms a primary key.
2. An employee can score anywhere starting from 1 to 5 where 5 being the best score.*/

create table relationship_employee_annual_performance_score ( emp_ID char(5) ,
                                                              score_id char(5) ,
                                                              year int, 
                                                              primary key (emp_ID, score_id, year),
                                                              foreign key (emp_ID) references employee (emp_ID),
                                                              foreign key (score_id) references annual_performance_score (score_id) );

insert into relationship_employee_annual_performance_score values ( 'a12d' , '33001' , 2020) ;
insert into relationship_employee_annual_performance_score values ( 'b12d' , '33001' , 2020) ;
insert into relationship_employee_annual_performance_score values ( 'a12d' , '33005' , 2021) ;
insert into relationship_employee_annual_performance_score values ( 'd12d' , '33004' , 2020) ;
insert into relationship_employee_annual_performance_score values ( 'a12d' , '33001' , 2019) ;

/* Assumption for relationship_payroll_salary - 
1. payroll_id can not be repeated as it is like an transaction id but salary_id can be repeated as same amount of salary can be included in many payrolls.*/

create table if not exists relationship_payroll_salary ( payroll_id char(5) not null ,
                                                         salary_id char(5) not null ,
                                                         primary key (payroll_id) ,
                                                         foreign key (payroll_id) references payroll (payroll_id) ,
                                                         foreign key (salary_id) references salary (salary_id) 
                                                            );

insert into relationship_payroll_salary values ( '25001' , '00001' ) ; 
insert into relationship_payroll_salary values ( '25002' , '00001' ) ;
insert into relationship_payroll_salary values ( '25003' , '00002' ) ;
insert into relationship_payroll_salary values ( '25004' , '00003' ) ;
insert into relationship_payroll_salary values ( '25005' , '00004' ) ;

/* Assumption for relationship_payroll_leaves -
1. A payroll can include various leave_id and leave_id can be repeated in payroll_id as an employee can same kind of leaves ex: sick leave but date_of_leave will be different for each one. So all three combined forms primary key.*/

create table if not exists relationship_payroll_leaves ( payroll_id char(5) not null ,
                                                         leave_id char(5) not null ,
                                                         date_of_leave DATE NOT NULL ,
                                                         primary key (payroll_id,leave_id, date_of_leave ) ,
                                                         foreign key (payroll_id) references payroll (payroll_id) ,
                                                         foreign key (leave_id) references leaves (leave_id)
                                                            );

insert into relationship_payroll_leaves values ( '25001' , '10001' , '2022-01-10') ;
insert into relationship_payroll_leaves values ( '25001' , '10001' , '2022-01-15') ;
insert into relationship_payroll_leaves values ( '25002' , '10003' , '2022-01-17') ;
insert into relationship_payroll_leaves values ( '25003' , '10004' , '2022-01-10') ;
insert into relationship_payroll_leaves values ( '25004' , '10005' , '2022-01-27') ;

/* Assumption for relationship_employee_leaves -
1. emp_ID can be repeated as an employee can ask for multiple leaves in a month, leave_id is repeated as an employee can ask for similar leave ex: sick in an month but every time date will be unique. So primary key is formed using all three.*/  

create table if not exists relationship_employee_leaves ( emp_ID char(5) not null ,
                                                          leave_id char(5) not null ,
                                                          apply_date date not null ,
                                                          approval_date date , 
                                                          primary key (emp_ID,leave_id,apply_date) ,
                                                          foreign key (emp_ID) references employee (emp_ID) ,
                                                          foreign key (leave_id) references leaves (leave_id) 
                                                            );

insert into relationship_employee_leaves values ( 'a12d' , '10001' , '2022-01-10' , '2022-01-10' ) ;
insert into relationship_employee_leaves values ( 'b12d' , '10003' , '2022-01-10' , '2022-01-12' ) ;
insert into relationship_employee_leaves values ( 'a12d' , '10001' , '2022-01-16' , '2022-01-18' ) ;
insert into relationship_employee_leaves values ( 'c12d' , '10002' , '2022-01-22' , '2022-01-25' ) ;
insert into relationship_employee_leaves values ( 'e12d' , '10003' , '2022-01-27' , '2022-01-28' ) ;

/***********************************************************************************************************************/

/* creating users.*/

CREATE USER 'anisha'@'localhost' IDENTIFIED BY 'anisha' ;
CREATE USER 'suchit'@'localhost' IDENTIFIED BY 'suchit' ;
CREATE USER 'kartik'@'localhost' IDENTIFIED BY 'kartik' ;
CREATE USER 'ravi'@'localhost' IDENTIFIED BY 'ravi' ;

/* granting roles/authority to users. */

/* giving create,drop and grant authority to the database administrator - anisha*/

grant create,drop ON *.*  TO 'anisha'@'localhost' with grant option ;

/* giving select authority to employee - suchit*/

grant  select  on  *.*  to  'suchit'@'localhost'  ;

/* giving select, insert, update and delete authority to the admin(HR team) - kartik*/ 

GRANT select, insert, update, delete ON job_department TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON leaves TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON salary TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON payroll TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON employee TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON relationship_employee_payroll TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON relationship_employee_job_department TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON relationship_payroll_salary TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON relationship_payroll_leaves TO 'kartik'@'localhost' ;
GRANT select, insert, update, delete ON relationship_employee_leaves TO 'kartik'@'localhost' ;

/* giving select, insert, update and delete authority to senior manager - ravi as per the authority he should possess over particular tables*/

GRANT select, insert, update, delete ON annual_performance_score TO 'ravi'@'localhost' ;
GRANT select, insert, update, delete ON relationship_employee_annual_performance_score TO 'ravi'@'localhost' ;
GRANT select ON relationship_employee_leaves TO 'ravi'@'localhost' ;
GRANT select ON leaves TO 'ravi'@'localhost' ;
GRANT select ON employee TO 'ravi'@'localhost' ;

/*************************************END-OF-PROJECT******************************************/
