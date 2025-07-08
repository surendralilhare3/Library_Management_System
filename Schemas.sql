-- Library Management System
-- Creating table Branch
DROP TABLE IF EXISTS Branch;

CREATE TABLE Branch (
		branch_id VARCHAR(10)PRIMARY KEY,
		manager_id VARCHAR(10),
		branch_address VARCHAR(50),
		contact_no VARCHAR(10)
	);

-- Create table Employee

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees(
		emp_id VARCHAR(10) PRIMARY KEY,
		emp_name VARCHAR(25),
		position VARCHAR(15),
		salary INT,
		branch_id VARCHAR(10)
);

-- Create table Books

DROP TABLE IF EXISTS Books;

CREATE TABLE Books(
		isbn VARCHAR(20) PRIMARY KEY,
		book_title VARCHAR(60),
		category VARCHAR(30),
		rental_price FLOAT,
		status VARCHAR(30),
		author VARCHAR(30),
		publisher VARCHAR(50)
)

-- Create table Members

DROP TABLE IF EXISTS Members;

CREATE TABLE Members(
		member_id VARCHAR(10) PRIMARY KEY,
		member_name VARCHAR(25),
		member_address VARCHAR(75),
		reg_date DATE
)

-- Create table Issued_Status

DROP TABLE IF EXISTS Issued_Status;

CREATE TABLE Issued_Status(
		issued_id VARCHAR(10) PRIMARY KEY,
		issued_member_id VARCHAR(10),
		issued_book_name VARCHAR(75),
		issued_date DATE,
		issued_book_isbn VARCHAR(10),
		issued_emp_id VARCHAR(10)
);

-- Create table Return_Status

DROP TABLE IF EXISTS Return_Status;

CREATE TABLE Return_Status(
		return_id VARCHAR(10) PRIMARY KEY,
		issued_id VARCHAR(10),
		return_book_name VARCHAR(75),
		return_date DATE,
		return_book_isbn VARCHAR(20)

);

-- Create table Members

DROP TABLE IF EXISTS Members;

CREATE TABLE Members(
		member_id VARCHAR(10) PRIMARY KEY,
		member_name VARCHAR(50),
		member_address VARCHAR(100),
		reg_date DATE
);

-- FOREIGN KEYS

ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employee
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);
