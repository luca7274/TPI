-- Création de la base de données
CREATE DATABASE DB_employee;
GO

-- Utilisation de la base
USE DB_employee;
GO

-- Table contenant les métiers
CREATE TABLE t_job (
    id_job INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    job_name VARCHAR(100) NOT NULL,
    job_description VARCHAR(255)
);

-- Table contenant les employés
CREATE TABLE t_employee (
    id_employee INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    empFirstName VARCHAR(100) NOT NULL,
    empLastName VARCHAR(100) NOT NULL,
    empHireDate DATE NOT NULL,
    id_job INT NULL,
    CONSTRAINT FK_employee_job FOREIGN KEY (id_job) REFERENCES t_job(id_job)
);

-- Table contenant les fiches de salaire
CREATE TABLE t_salary (
    id_salary INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    salDate DATE NOT NULL,
    sal_grossSalary DECIMAL(10, 2) NOT NULL,
    sal_netSalary DECIMAL(10, 2) NOT NULL,
    id_employee INT UNIQUE NOT NULL,
    CONSTRAINT FK_salary_employee FOREIGN KEY (id_employee) REFERENCES t_employee(id_employee)
);
