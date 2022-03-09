Project Title - Membership Cancellation Form

Submitted By - Group - 9
Anisha Siwas - 025007
Suchit Katyal - 025033
Kartik Mohan Sinha - 025017

/********************************************************************************************/

/* Bottom-up approach to data modelling. Normalization of membership cancellation form and creating entity relationship diagram for same. */

create database if not exists MCF ;

use MCF;

/********************************************************************************************/

/* creating required tables. */

create table membership ( membership_ID varchar(4) primary key,    
                          enrollment_date DATE,
                          ) ;
  
insert into membership values ('3011','2022-01-05') ;
insert into membership values ('3022','2022-01-17') ;
insert into membership values ('3055','2022-01-20') ;
insert into membership values ('3033','2022-01-27') ;


create table customer ( customer_ID char(5) primary key,    
                        first name varchar(20),
                        last name varchar(20),
                        e-mail varchar(20)
                        adderess varchar(40)
                        country varchar(20) 
                        state  varchar(20)
                        city varchar(20)
                        pincode int )  ;

insert into customer values ('11','suchit','katyal','sk@gmail.com','hno-201, sector 37','india','haryana','faridabad','121003') ;
insert into customer values ('12','anisha','siwas','as@gmail.com','hno-12, sector 4','india','delhi','new delhi','220077') ;
insert into customer values ('14','kartik','mohan','km@gmail.com','hno-27, block A','india','haryana','gurugram','121788') ;
insert into customer values ('17','ravi','sharma','rs@yahoo.in','hno-68, block M','india','delhi','south delhi','220099') ;

create table services ( service_ID varchar(3) primary key,
                        description varchar(25)  
                        price_per_month  int )  ;

insert into services values ('101','Movies',100) ;
insert into services values ('202','songs',50) ;
insert into services values ('303','podcasts',30) ;

create table time_period ( membership_ID char(4),
                           service_ID char(3)  
                           number_of_months_left int
                           primary key (membership_ID, service_ID ) )  ;

insert into time_period values ('3011','101',3) ;
insert into time_period values ('3011','202',3) ;
insert into time_period values ('3011','303',3) ;
insert into time_period values ('3022','202',5) ;
insert into time_period values ('3022','303',4) ;
insert into time_period values ('3055','101',6) ;
insert into time_period values ('3055','303',6) ;
insert into time_period values ('3033','202',2) ;

/**********************************************************************************/

/* creating required relationship tables and stating assumptions for each table.*/

/* Assumption for relationship_membership_table.
1. Every memebership_ID is unique. */ 

create table relationship_membership_customer ( membership_ID char(4),
                                                customer_ID char(5),
                                                primary key ( membership_ID ),
                                                foreign key (membership_ID) references membership (membership_ID),
                                                foreign key (customer_ID) references customer (customer_ID) );

insert into relationship_membership_customer values ( '3011' , '11' ) ;
insert into relationship_membership_customer values ( '3022' , '12' ) ;
insert into relationship_membership_customer values ( '3055' , '14' ) ;
insert into relationship_membership_customer values ( '3033' , '17' ) ;

/* Assumption relationship_customer_services.
1. A member can purchase various services and a service can be purchased by multiple members. */

create table relationship_customer_services ( customer_ID char(5),
                                              service_ID varchar(3),
                                              primary key (customer_ID, service_ID),
                                              foreign key (customer_ID) references customer (customer_ID),
                                              foreign key (service_ID) references services (service_ID) ); 
   
insert into relationship_customer_services values ( '11' , '101' ) ;
insert into relationship_customer_services values ( '11' , '202' ) ;
insert into relationship_customer_services values ( '12' , '101' ) ;
insert into relationship_customer_services values ( '14' , '303' ) ;


/*********************************END-OF-PROJECT****************************/