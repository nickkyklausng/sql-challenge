-- Create table for data_department and import csv.
CREATE TABLE data_department(
	dept_no VARCHAR(225) PRIMARY KEY NOT NULL,
	dept_name VARCHAR (225) NOT NULL
);

-- Create table for data_department_employee and import csv.
CREATE TABLE data_department_employee(
	emp_no INT NOT NULL,
	dept_no VARCHAR(225) NOT NULL
);

-- Create table for data_department_manager and import csv.
CREATE TABLE data_department_manager(
	dept_no VARCHAR(225) NOT NULL,
	emp_no INT NOT NULL
);

-- Create table for data_department_salary and import csv.
CREATE TABLE data_department_salary(
	emp_no INT NOT NULL,
	salary INT NOT NULL
);

-- Create table for data_titles and import csv.
CREATE TABLE data_titles(
	title_id VARCHAR(225) PRIMARY KEY NOT NULL,
	title VARCHAR(225) NOT NULL
);

-- Create table for employee_data and import csv.
CREATE TABLE employee_data(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(225) NOT NULL,
	birth_date DATE,
	first_name VARCHAR(225) NOT NULL,
	last_name VARCHAR(225) NOT NULL,
	sex VARCHAR,
	hire_date DATE
);

SELECT * FROM employee_data;
--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT f.emp_no, f.first_name, f.last_name, f.sex, d.salary 
FROM employee_data f
LEFT JOIN data_department_salary d
ON f.emp_no = d.emp_no
ORDER BY emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
--extract the date directly: Where DATE_PART(year, hire_date) = '1986'
SELECT * FROM employee_data
WHERE DATE_PART('year', hire_date) = '1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT c.dept_no, a.dept_name, c.emp_no, f.first_name, f.last_name, f.sex
FROM data_department_manager c
LEFT JOIN data_department a
ON c.dept_no = a.dept_no
LEFT JOIN employee_data f
ON f.emp_no = c.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT f.first_name, f.last_name, f.emp_no, b.dept_no, a.dept_name
FROM employee_data f
INNER JOIN data_department_employee b
ON b.emp_no = f.emp_no
INNER JOIN data_department a
ON a.dept_no = b.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employee_data
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT b.dept_no, a.dept_name, f.emp_no, f.first_name, f.last_name
FROM employee_data f
LEFT JOIN data_department_employee b
ON f.emp_no = b.emp_no
INNER JOIN data_department a
ON a.dept_no = b.dept_no
WHERE dept_name = 'Sales';


--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT b.dept_no, a.dept_name, f.emp_no, f.first_name, f.last_name
FROM employee_data f
LEFT JOIN data_department_employee b
ON f.emp_no = b.emp_no
INNER JOIN data_department a
ON a.dept_no = b.dept_no
WHERE dept_name IN ('Sales', 'Development');

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employee_data
GROUP BY last_name
ORDER BY "Last Name Count" DESC;

