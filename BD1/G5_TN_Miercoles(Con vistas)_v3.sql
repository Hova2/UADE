--GRUPO 5 - MIERCOLES - NOCHE 
--Integrantes:
--LU: 1072204 – Apellido y nombre: Mingo Suarez, Tomas Esteban
--LU: 1022935 – Apellido y nombre: Miño, Lucas Nicolas
--LU: 1065614 – Apellido y nombre: Gueicha Muñoz, Esteban Ezequiel
--LU: 1014180 – Apellido y nombre: Guglielmone, Juan Ignacio

USE db4209_05

--CREATES

create table Medicos 
(
	matricula int not null,
	apellido varchar(30) not null,
	nombre varchar(30) not null,
	sexo varchar(10) not null,
	nacimiento date not null,
	activo bit not null,
	
	constraint Medicos_pk primary key (matricula)
)
go

create table Pacientes
(
	dni int not null,
	apellido varchar(30) not null,
	nombre varchar(30) not null,
	sexo varchar(10) not null,
	nacimiento date not null,
	telefono int not null,
	
	constraint Pacientes_pk primary key (dni)

)
go


create table Coberturas
(
	idEstudio int identity not null,
	Sigla varchar(10) not null,
	NroPlan int not null,
	Cobertura float not null,
	
	constraint Coberturas_pk primary key (idEstudio, Sigla, Nroplan)

)
go


create table Registros
(
	idRegistro int identity not null,
	Fecha datetime not null,
	dni int not null,
	IdEstudio int not null,
	idInstituto int not null,
	Matricula int not null,
	Sigla varchar (10) not null,
	
	constraint Registros_pk primary key (idRegistro)

)
go

create table ObraSocial
(
	Sigla varchar (10) not null,
	Nombre varchar (30) not null,
	Categoria varchar(20) not null,
	
	constraint ObraSocial_pk primary key (Sigla) 
)
go


create table Afiliados
(
	idAfiliado int identity not null,
	dni int not null,
	Sigla varchar (10) not null,
	NroPlan int not null,
	NroAfiliado int not null,

	Constraint Afiliados_pk primary key (idAfiliado)
)
go


create table Planes
(
	Sigla varchar (10) not null,
	NroPlan int not null,
	NombrePlan varchar (15) not null,

	Constraint Planes_pk primary key (Sigla,NroPlan)
)
go



Create table Especialidades
(
    idEspecialidad int identity,
    Descripcion varchar(50) not null,
    Constraint especialidad_pk Primary key (idEspecialidad)
)
go

Create table EstuEspe
(
    idEstudio int not null,
    idEspecialidad int not null,
    Constraint estuEspe_pk Primary key(idEstudio,idEspecialidad)
)
go

Create table Estudios
(
    idEstudio int identity,
    Descripcion varchar(50) not null,
    Constraint estudios_pk primary key(idEstudio)
)
go

Create table Precios
(
    idEstudio int not null,
    idInstituto int not null,
    Precio money not null
    Constraint precios_pk primary key(idEstudio,idInstituto)
)
go


Create table Institutos
(
    idInstituto int identity,
    razonSocial varchar(30) not null,
    Activo bit not null,
    Constraint institutos_pk primary key(idInstituto)
)
go

Create table EspeMedi
(
    idEspecialidad int not null,
    Matricula int not null,
    Constraint espeMedi_pk primary key (idEspecialidad,matricula)
)
go

--ALTERS

Alter table EstuEspe

    add Constraint estuEspe_fk_estudios foreign key(idEstudio) references Estudios,
    Constraint estuEspe_fk_especialidades foreign key(idEspecialidad) references Especialidades;
go

Alter table Precios

    add Constraint precios_fk_estudios foreign key (idEstudio) references Estudios,
    Constraint precios_fk_institutos foreign key (idInstituto) references Institutos;
go

Alter table EspeMedi

    add Constraint espeMedi_fk_especialidades foreign key (idEspecialidad) references Especialidades,
    Constraint espeMedi_fk_medicos foreign key (matricula) references Medicos;
go

Alter table Registros

    add Constraint Registros_fk_Medicos foreign key (Matricula) references Medicos,
    Constraint Registros_fk_Pacientes foreign key (dni) references Pacientes,
	Constraint Registros_fk_Precios foreign key (idEstudio, idInstituto) references Precios,
	Constraint Registros_fk_ObraSocial foreign key (Sigla) references ObraSocial;
go


Alter table Coberturas
    add Constraint Coberturas_fk_Estudios foreign key (idEstudio) references Estudios,
    Constraint Coberturas_fk_Planes foreign key (Sigla,NroPlan) references Planes;
go

Alter table Afiliados
	add constraint Afiliados_fk_Pacientes foreign key (Dni) references Pacientes,
	Constraint Afiliados_fk_Planes foreign key (Sigla, NroPlan) references Planes;
go

--CHECKS

ALTER TABLE Afiliados ADD CONSTRAINT Afiliados_Sigla_Solo_Letras_CK CHECK (Sigla NOT LIKE '%[^A-Z]%')
GO

ALTER TABLE Afiliados ADD CONSTRAINT Afiliados_NroPlan_Rango_Numeros_CK CHECK (NroPlan>=1 AND NroPlan<=12)
GO

ALTER TABLE Afiliados ADD CONSTRAINT Afiliados_Dni_Solo_Numeros_CK CHECK (dni NOT LIKE '%[^0-9]%')
GO

ALTER TABLE Coberturas ADD CONSTRAINT Coberturas_Sigla_Solo_Letras_CK CHECK (Sigla NOT LIKE '%[^A-Z]%')
GO

ALTER TABLE Coberturas ADD CONSTRAINT Coberturas_NroPlan_Rango_Numeros_CK CHECK (NroPlan>=1 AND NroPlan<=12)
GO

ALTER TABLE Coberturas ADD CONSTRAINT Coberturas_Cobertura_Rango_Numeros_CK CHECK (Cobertura>=0 AND Cobertura<=1)
GO

ALTER TABLE Planes ADD CONSTRAINT Planes_Sigla_Solo_Letras_CK CHECK (Sigla NOT LIKE '%[^A-Z]%')
GO

ALTER TABLE Planes ADD CONSTRAINT Planes_NroPlan_Rango_Numeros_CK CHECK (NroPlan>=1 AND NroPlan<=12)
GO

ALTER TABLE Registros ADD CONSTRAINT Registros_Sigla_Solo_Letras_CK CHECK (Sigla NOT LIKE '%[^A-Z]%')
GO

ALTER TABLE Registros ADD CONSTRAINT Registros_Dni_Solo_Numeros_CK CHECK (dni NOT LIKE '%[^0-9]%')
GO

ALTER TABLE Registros ADD CONSTRAINT Registros_Fecha_Diff_Fechas_CK CHECK (DATEDIFF(MONTH,fecha,GETDATE())>=-1 AND DATEDIFF(MONTH,fecha,GETDATE())<=1)
GO

ALTER TABLE ObraSocial ADD CONSTRAINT ObraSocial_Sigla_Solo_Letras_CK CHECK (Sigla NOT LIKE '%[^A-Z]%')
GO

ALTER TABLE ObraSocial ADD CONSTRAINT ObraSocial_Categoria_Solo_Abreviaturas_CK CHECK (categoria='os' OR categoria='pp')
GO

ALTER TABLE Medicos ADD CONSTRAINT Medicos_Sexo_Solo_Abreviaturas_CK CHECK (sexo='m' OR sexo='f')
GO

ALTER TABLE Medicos ADD CONSTRAINT Medicos_Nacimiento_Diff_Fechas_CK CHECK (DATEDIFF(YEAR,nacimiento,GETDATE())>=21 AND DATEDIFF(YEAR,nacimiento,GETDATE())<=80)
GO

ALTER TABLE Pacientes ADD CONSTRAINT Pacientes_Sexo_Solo_Abreviaturas_CK CHECK (sexo='m' OR sexo='f')
GO

ALTER TABLE Pacientes ADD CONSTRAINT Pacientes_Dni_Solo_Numeros_CK CHECK (dni NOT LIKE '%[^0-9]%')
GO

ALTER TABLE Pacientes ADD CONSTRAINT Pacientes_Nacimiento_Diff_Fechas_CK CHECK (DATEDIFF(YEAR,nacimiento,GETDATE())>=21 AND DATEDIFF(YEAR,nacimiento,GETDATE())<=80)
GO

ALTER TABLE Precios ADD CONSTRAINT Precios_Precio_Rango_Numeros_CK CHECK (Precio>=1 AND Precio<=8000)
GO

--VISTAS

CREATE VIEW vw_medicos_activos
AS
SELECT MATRICULA, NOMBRE, APELLIDO,
		SEXO = CASE Sexo WHEN 'm' THEN 'MASCULINO'
					WHEN 'F' THEN 'FEMENINO'
					ELSE 'NO ESPECIFICADO' END
FROM Medicos
WHERE activo=1
GO