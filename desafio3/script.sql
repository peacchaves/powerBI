create schema if not exists azure_company;
use azure_company;

select * from information_schema.table_constraints where constraint_schema = 'azure_company';

create table employee (
    Fname varchar(15) not null,
    Minit char(1),
    Lname varchar(15) not null,
    Ssn char(9) not null primary key,
    Bdate date,
    Address varchar(30),
    Sex char(1),
    Salary decimal(10, 2) check (Salary > 2000),
    Super_ssn char(9),
    Dno int not null default 1
);

alter table employee add foreign key (Super_ssn) references employee(Ssn) on delete set null on update cascade;

create table departament (
    Dname varchar(15) not null unique,
    Dnumber int not null primary key,
    Mgr_ssn char(9) not null,
    Mgr_start_date date,
    Dept_create_date date check (Dept_create_date < Mgr_start_date),
    foreign key (Mgr_ssn) references employee(Ssn) on update cascade
);

create table dept_locations (
    Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament(Dnumber) on delete cascade on update cascade
);

create table project (
    Pname varchar(15) not null unique,
    Pnumber int not null primary key,
    Plocation varchar(15),
    Dnum int not null,
    foreign key (Dnum) references departament(Dnumber)
);

create table works_on (
    Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    foreign key (Essn) references employee(Ssn),
    foreign key (Pno) references project(Pnumber)
);

create table dependent (
    Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char(1),
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    foreign key (Essn) references employee(Ssn)
);

show tables;
