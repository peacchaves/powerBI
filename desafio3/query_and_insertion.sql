use company_constraints;

insert into employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) values 
('John', 'B', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5),
('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 888665555, 5),
('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, 987654321, 4),
('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, 888665555, 4),
('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5),
('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5),
('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, 987654321, 4),
('James', 'E', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

insert into dependent (Essn, Dependent_name, Sex, Bdate, Relationship) values 
(333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
(333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
(333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
(987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
(123456789, 'Michael', 'M', '1988-01-04', 'Son'),
(123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');

insert into departament (Dname, Dnumber, Mgr_ssn, Mgr_start_date, Dept_create_date) values 
('Research', 5, 333445555, '1988-05-22', '1986-05-22'),
('Administration', 4, 987654321, '1995-01-01', '1994-01-01'),
('Headquarters', 1, 888665555, '1981-06-19', '1980-06-19');

insert into dept_locations (Dnumber, Dlocation) values 
(1, 'Houston'), (4, 'Stafford'), (5, 'Bellaire'), (5, 'Sugarland'), (5, 'Houston');

insert into project (Pname, Pnumber, Plocation, Dnum) values 
('ProductX', 1, 'Bellaire', 5), ('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5), ('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1), ('Newbenefits', 30, 'Stafford', 4);

insert into works_on (Essn, Pno, Hours) values 
(123456789, 1, 32.5), (123456789, 2, 7.5), (666884444, 3, 40.0),
(453453453, 1, 20.0), (453453453, 2, 20.0), (333445555, 2, 10.0),
(333445555, 3, 10.0), (333445555, 10, 10.0), (333445555, 20, 10.0),
(999887777, 30, 30.0), (999887777, 10, 10.0), (987987987, 10, 35.0),
(987987987, 30, 5.0), (987654321, 30, 20.0), (987654321, 20, 15.0),
(888665555, 20, 0.0);

select * from employee;
select e.Ssn, count(d.Essn) from employee e join dependent d on e.Ssn = d.Essn;
select * from dependent;

select Bdate, Address from employee where Fname = 'John' and Minit = 'B' and Lname = 'Smith';

select * from departament where Dname = 'Research';

select Fname, Lname, Address from employee join departament on Dnumber = Dno where Dname = 'Research';

select * from project;

select Dname as Department, Mgr_ssn as Manager from departament join dept_locations on departament.Dnumber = dept_locations.Dnumber;

select Dname as Department, concat(Fname, ' ', Lname) as Manager from departament d
join dept_locations l on d.Dnumber = l.Dnumber join employee e on d.Mgr_ssn = e.Ssn;

select * from project join departament on project.Dnum = departament.Dnumber where Plocation = 'Stafford';

select Pnumber, Dnum, Lname, Address, Bdate from project p 
join departament d on p.Dnum = d.Dnumber 
join employee e on d.Mgr_ssn = e.Ssn where Plocation = 'Stafford';

select * from employee where Dno in (3,6,9);

select Fname, Lname, Salary, round(Salary * 0.011, 2) as INSS from employee;

select e.Fname, e.Lname, round(1.1 * e.Salary, 2) as increased_salary from employee e
join works_on w on e.Ssn = w.Essn 
join project p on w.Pno = p.Pnumber where p.Pname = 'ProductX';
