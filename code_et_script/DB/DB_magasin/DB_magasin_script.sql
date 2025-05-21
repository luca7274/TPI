-- Création de la base de données
CREATE DATABASE DB_magasin;
GO

-- Utilisation de la base
USE DB_magasin;
GO

-- Création des tables
CREATE TABLE t_client (
    id_client INT IDENTITY(1,1) NOT NULL,
    cliFirstName VARCHAR(50) NOT NULL,
    cliLastName VARCHAR(50) NOT NULL,
    cliBirthdate DATE NOT NULL,
    cliAddress VARCHAR(100) NOT NULL,
    cliPostCode VARCHAR(10) NOT NULL,
    cliPhoneNumber VARCHAR(15) NOT NULL,
    cliGender CHAR(1) NOT NULL,
    CONSTRAINT PK_t_client PRIMARY KEY (id_client)
);


CREATE TABLE t_brand (
    id_brand INT IDENTITY(1,1) NOT NULL,
    braName VARCHAR(50) NOT NULL,
    braCountry VARCHAR(50) NOT NULL,
    CONSTRAINT PK_t_brand PRIMARY KEY (id_brand)
);

create table t_accessories (
    id_accessories int identity primary key,
    id_brand int not null,
    accCategory varchar(50) not null,
    accSerialNumber varchar(50) not null,
    accPrice float not null,
    foreign key (id_brand) references t_brand(id_brand)
);

create table t_bicycle (
    id_bicycle int identity primary key,
    id_brand int not null,
    bicSerialNumber varchar(50) not null,
    bicColor varchar(20) not null,
    bicSize varchar(10) not null,
    bicPrice float not null,
    id_client int,
    foreign key (id_client) references t_client(id_client),
    foreign key (id_brand) references t_brand(id_brand)
);
