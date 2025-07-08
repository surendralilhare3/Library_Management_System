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

SELECT * FROM members;
SELECT * FROM issued_status
WHERE issued_id = 'IS121';

-- Solving Bussiness Problems

--Q.1 Create a new book record--"978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

--Q.2 Update an Existing Member's Address

UPDATE members
SET member_address = '1234 Rajiv Nagar'
WHERE member_id = 'C101';

--Q.3 Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

--Q.4 Select all books issued by the employee with emp_id = 'E101'

SELECT issued_book_name FROM issued_status
WHERE issued_emp_id = 'E101';

--Q.5 List Members Who Have Issued More Than One Book

SELECT issued_emp_id, COUNT(*)
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*)>1;

--Q.6 Use CTAS(Create Table as Select) to generate new tables based on query results - each book and total book_issued_cnt

SELECT * FROM books;
SELECT * FROM issued_status;

CREATE TABLE books_count AS
	SELECT b.isbn, b.book_title, COUNT(ist.issued_id)
	FROM issued_status AS ist
	JOIN books as b
	ON ist.issued_book_isbn = b.isbn
	GROUP BY b.isbn, b.book_title;

SELECT * FROM books_count;

--Q.7 Retrive all books from specific category

SELECT * FROM books 
WHERE category = 'Classic';

--Q.8 Total rental on each category

SELECT category, SUM(rental_price) AS total_rental
FROM books
GROUP BY category

--Q.9 List members who registered in last 80 days

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '500 days' 

--Q.10 List the employee with their manager name and details

SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id














