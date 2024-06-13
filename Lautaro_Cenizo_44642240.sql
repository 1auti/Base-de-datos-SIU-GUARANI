create database tp_44642240_Cenizo;
use tp_44642240_Cenizo;

/*Creacion de las tablas*/
CREATE TABLE Universidad (
    ID_Universidad INT PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE Departamento (
    ID_Departamento INT PRIMARY KEY,
    Nombre VARCHAR(100),
    ID_Universidad INT,
    FOREIGN KEY (ID_Universidad) REFERENCES Universidad(ID_Universidad)
);

CREATE TABLE Carrera (
    ID_Carrera INT PRIMARY KEY,
    Nombre_Carrera VARCHAR(100),
    Duración INT,
    ID_Departamento INT,
    FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

CREATE TABLE Alumno (
    ID_Alumno INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    DNI INT,
    Fecha_Nacimiento DATE,
    ID_Carrera INT,
    Regularidad ENUM('Regular', 'Libre'),
    FOREIGN KEY (ID_Carrera) REFERENCES Carrera(ID_Carrera)
);

CREATE TABLE Legajo (
    ID_Legajo INT PRIMARY KEY,
    ID_Alumno INT,
    Año_Ingreso INT,
    Estado ENUM('Activo', 'Inactivo', 'Graduado'),
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno)
);

CREATE TABLE Materia (
    ID_Materia INT PRIMARY KEY,
    Nombre_Materia VARCHAR(100),
    ID_Carrera INT,
    Año INT,
    FOREIGN KEY (ID_Carrera) REFERENCES Carrera(ID_Carrera)
);

CREATE TABLE Profesor (
    ID_Profesor INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Título VARCHAR(100)
);

CREATE TABLE Comision (
    ID_Comision INT PRIMARY KEY,
    ID_Materia INT,
    Turno ENUM('Mañana', 'Tarde', 'Noche'),
    Modalidad ENUM('Presencial', 'Virtual'),
    FOREIGN KEY (ID_Materia) REFERENCES Materia(ID_Materia)
);

CREATE TABLE Inscripción (
    ID_Inscripción INT PRIMARY KEY,
    ID_Alumno INT,
    ID_Comision INT,
    Fecha_Inscripción DATE,
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno),
    FOREIGN KEY (ID_Comision) REFERENCES Comision(ID_Comision)
);

CREATE TABLE Dicta (
    ID_Dicta INT PRIMARY KEY,
    ID_Profesor INT,
    ID_Comision INT,
    Año_Académico INT,
    FOREIGN KEY (ID_Profesor) REFERENCES Profesor(ID_Profesor),
    FOREIGN KEY (ID_Comision) REFERENCES Comision(ID_Comision)
);

CREATE TABLE Correlativa (
    ID_Materia INT,
    ID_Materia_Correlativa INT,
    PRIMARY KEY (ID_Materia, ID_Materia_Correlativa),
    FOREIGN KEY (ID_Materia) REFERENCES Materia(ID_Materia),
    FOREIGN KEY (ID_Materia_Correlativa) REFERENCES Materia(ID_Materia)
);

CREATE TABLE Final (
    ID_Final INT PRIMARY KEY,
    ID_Alumno INT,
    ID_Materia INT,
    Fecha_Final DATE,
    Nota DECIMAL(3, 1),
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno),
    FOREIGN KEY (ID_Materia) REFERENCES Materia(ID_Materia)
);

CREATE TABLE Historial_Academico (
    ID_Historial INT PRIMARY KEY,
    ID_Alumno INT,
    ID_Materia INT,
    Año_Cursada INT,
    Nota DECIMAL(3, 1),
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno),
    FOREIGN KEY (ID_Materia) REFERENCES Materia(ID_Materia)
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(50),
    Rol ENUM('Alumno', 'Profesor', 'Administrador'),
    ID_Alumno INT NULL,
    ID_Profesor INT NULL,
    FOREIGN KEY (ID_Alumno) REFERENCES Alumno(ID_Alumno),
    FOREIGN KEY (ID_Profesor) REFERENCES Profesor(ID_Profesor)
);

CREATE TABLE Horario (
    ID_Horario INT PRIMARY KEY,
    ID_Comision INT,
    Dia ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'),
    Hora_Inicio TIME,
    Hora_Fin TIME,
    FOREIGN KEY (ID_Comision) REFERENCES Comision(ID_Comision)
);

CREATE TABLE Historial_Cambios (
    ID_Cambio INT PRIMARY KEY,
    Tabla VARCHAR(50),
    Operacion ENUM('INSERT', 'UPDATE', 'DELETE'),
    Fecha TIMESTAMP,
    Usuario VARCHAR(50),
    Descripcion TEXT
);

CREATE TABLE Contacto (
    ID_Contacto INT PRIMARY KEY,
    ID_Usuario INT,
    Tipo ENUM('Email', 'Teléfono'),
    Valor VARCHAR(100),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

CREATE TABLE Permiso (
    ID_Permiso INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

CREATE TABLE Rol_Permiso (
    ID_Rol ENUM('Alumno', 'Profesor', 'Administrador'),
    ID_Permiso INT,
    PRIMARY KEY (ID_Rol, ID_Permiso),
    FOREIGN KEY (ID_Permiso) REFERENCES Permiso(ID_Permiso)
);


/*Insercion de datos*/

-- Inserción de datos para Universidad
INSERT INTO Universidad (ID_Universidad, Nombre) VALUES 
(1, 'Universidad Nacional de Lanús'),
(2, 'Universidad Nacional de Buenos Aires');

-- Inserción de datos para Departamento
INSERT INTO Departamento (ID_Departamento, Nombre, ID_Universidad) VALUES 
(1, 'Departamento de Desarrollo Productivo y Tecnológico', 1),
(2, 'Departamento de Ciencias Básicas', 1),
(3, 'Departamento de Ingeniería', 2);

-- Inserción de datos para Carrera
INSERT INTO Carrera (ID_Carrera, Nombre_Carrera, Duración, ID_Departamento) VALUES 
(1, 'Licenciatura en Sistemas', 5, 1),
(2, 'Ingeniería en Informática', 5, 1),
(3, 'Ingeniería Civil', 5, 3);

-- Inserción de datos para Alumno
INSERT INTO Alumno (ID_Alumno, Nombre, Apellido, DNI, Fecha_Nacimiento, ID_Carrera, Regularidad) VALUES 
(1, 'Juan', 'Pérez', 12345678, '2000-01-01', 1, 'Regular'),
(2, 'María', 'Gómez', 23456789, '1999-05-15', 1, 'Regular'),
(3, 'Pedro', 'López', 34567890, '2001-07-21', 2, 'Libre'),
(4, 'Ana', 'Martínez', 45678901, '2000-09-10', 3, 'Regular'),
(5, 'Luis', 'García', 56789012, '1998-11-25', 1, 'Regular'),
(6, 'Sofía', 'Fernández', 67890123, '2002-03-30', 2, 'Regular'),
(7, 'Jorge', 'Rodríguez', 78901234, '1997-12-05', 3, 'Libre'),
(8, 'Laura', 'Hernández', 89012345, '2001-04-18', 1, 'Regular'),
(9, 'Carlos', 'Ramírez', 90123456, '1999-06-22', 2, 'Libre'),
(10, 'Marta', 'López', 11234567, '1998-08-14', 3, 'Regular');

-- Inserción de datos para Legajo
INSERT INTO Legajo (ID_Legajo, ID_Alumno, Año_Ingreso, Estado) VALUES 
(1, 1, 2018, 'Activo'),
(2, 2, 2017, 'Activo'),
(3, 3, 2019, 'Inactivo'),
(4, 4, 2020, 'Activo'),
(5, 5, 2016, 'Graduado'),
(6, 6, 2021, 'Activo'),
(7, 7, 2015, 'Inactivo'),
(8, 8, 2019, 'Activo'),
(9, 9, 2018, 'Activo'),
(10, 10, 2017, 'Activo');

-- Inserción de datos para Materia
INSERT INTO Materia (ID_Materia, Nombre_Materia, ID_Carrera, Año) VALUES 
(1, 'Algoritmos y Estructuras de Datos', 1, 1),
(2, 'Programación Avanzada', 1, 2),
(3, 'Matemáticas Discretas', 1, 1),
(4, 'Bases de Datos', 1, 3),
(5, 'Cálculo I', 2, 1),
(6, 'Física I', 2, 1),
(7, 'Química General', 3, 1),
(8, 'Mecánica de Fluidos', 3, 2),
(9, 'Estructuras de Hormigón', 3, 3),
(10, 'Ingeniería de Software', 1, 4);

-- Inserción de datos para Profesor
INSERT INTO Profesor (ID_Profesor, Nombre, Apellido, Título) VALUES 
(1, 'Carlos', 'Rodríguez', 'Licenciado en Sistemas'),
(2, 'Ana', 'López', 'Ingeniera en Sistemas'),
(3, 'Luis', 'Martínez', 'Doctor en Matemáticas'),
(4, 'Laura', 'García', 'Licenciada en Física'),
(5, 'Miguel', 'Pérez', 'Ingeniero Civil');

-- Inserción de datos para Comision
INSERT INTO Comision (ID_Comision, ID_Materia, Turno, Modalidad) VALUES 
(1, 1, 'Mañana', 'Presencial'),
(2, 1, 'Tarde', 'Virtual'),
(3, 2, 'Noche', 'Presencial'),
(4, 3, 'Mañana', 'Presencial'),
(5, 4, 'Tarde', 'Virtual'),
(6, 5, 'Noche', 'Presencial'),
(7, 6, 'Mañana', 'Presencial'),
(8, 7, 'Tarde', 'Virtual'),
(9, 8, 'Noche', 'Presencial'),
(10, 9, 'Mañana', 'Presencial');

-- Inserción de datos para Inscripción
INSERT INTO Inscripción (ID_Inscripción, ID_Alumno, ID_Comision, Fecha_Inscripción) VALUES 
(1, 1, 1, '2024-02-01'),
(2, 2, 3, '2024-02-15'),
(3, 3, 6, '2024-03-01'),
(4, 4, 9, '2024-01-20'),
(5, 5, 1, '2024-02-05'),
(6, 6, 7, '2024-03-10'),
(7, 7, 10, '2024-01-25'),
(8, 8, 4, '2024-02-14'),
(9, 9, 8, '2024-03-02'),
(10, 10, 5, '2024-02-11');

-- Inserción de datos para Dicta
INSERT INTO Dicta (ID_Dicta, ID_Profesor, ID_Comision, Año_Académico) VALUES 
(1, 1, 1, 2024),
(2, 2, 3, 2024),
(3, 3, 6, 2024),
(4, 4, 9, 2024),
(5, 5, 10, 2024);

-- Inserción de datos para Correlativa
INSERT INTO Correlativa (ID_Materia, ID_Materia_Correlativa) VALUES 
(2, 1),  -- Programación Avanzada requiere Algoritmos y Estructuras de Datos
(4, 1),  -- Bases de Datos requiere Algoritmos y Estructuras de Datos
(4, 2),  -- Bases de Datos requiere Programación Avanzada
(9, 7),  -- Estructuras de Hormigón requiere Química General
(8, 6);  -- Mecánica de Fluidos requiere Física I

-- Inserción de datos para Final
INSERT INTO Final (ID_Final, ID_Alumno, ID_Materia, Fecha_Final, Nota) VALUES 
(1, 1, 1, '2024-06-15', 8.5),
(2, 2, 2, '2024-06-20', 9.0),
(3, 3, 5, '2024-07-10', 7.0),
(4, 4, 9, '2024-06-18', 8.0),
(5, 5, 4, '2024-07-01', 9.5);

-- Inserción de datos para Historial_Academico
INSERT INTO Historial_Academico (ID_Historial, ID_Alumno, ID_Materia, Año_Cursada, Nota) VALUES 
(1, 1, 1, 2023, 7.5),
(2, 2, 2, 2023, 8.0),
(3, 3, 5, 2022, 6.0),
(4, 4, 9, 2023, 7.0),
(5, 5, 4, 2023, 8.5);

-- Inserción de datos para Usuario
INSERT INTO Usuario (ID_Usuario, Username, Password, Rol, ID_Alumno, ID_Profesor) VALUES 
(1, 'juanperez', 'password123', 'Alumno', 1, NULL),
(2, 'mariagomez', 'password456', 'Alumno', 2, NULL),
(3, 'pedrolopez', 'password789', 'Alumno', 3, NULL),
(4, 'anamartinez', 'password012', 'Alumno', 4, NULL),
(5, 'luisgarcia', 'password345', 'Alumno', 5, NULL),
(6, 'sofiafernandez', 'password678', 'Alumno', 6, NULL),
(7, 'jorgerodriguez', 'password901', 'Alumno', 7, NULL),
(8, 'laurahernandez', 'password234', 'Alumno', 8, NULL),
(9, 'carlosramirez', 'password567', 'Alumno', 9, NULL),
(10, 'martalopez', 'password890', 'Alumno', 10, NULL),
(11, 'carlosrodriguez', 'password123', 'Profesor', NULL, 1),
(12, 'analopez', 'password456', 'Profesor', NULL, 2),
(13, 'luismartinez', 'password789', 'Profesor', NULL, 3),
(14, 'lauragarcia', 'password012', 'Profesor', NULL, 4),
(15, 'miguelperez', 'password345', 'Profesor', NULL, 5),
(16, 'admin', 'adminpassword', 'Administrador', NULL, NULL);

-- Inserción de datos para Horario
INSERT INTO Horario (ID_Horario, ID_Comision, Dia, Hora_Inicio, Hora_Fin) VALUES 
(1, 1, 'Lunes', '08:00', '10:00'),
(2, 1, 'Miércoles', '08:00', '10:00'),
(3, 3, 'Martes', '18:00', '20:00'),
(4, 3, 'Jueves', '18:00', '20:00'),
(5, 6, 'Viernes', '20:00', '22:00'),
(6, 9, 'Lunes', '10:00', '12:00'),
(7, 9, 'Miércoles', '10:00', '12:00'),
(8, 10, 'Martes', '14:00', '16:00'),
(9, 10, 'Jueves', '14:00', '16:00');

-- Inserción de datos para Historial_Cambios
INSERT INTO Historial_Cambios (ID_Cambio, Tabla, Operacion, Fecha, Usuario, Descripcion) VALUES 
(1, 'Alumno', 'INSERT', '2024-02-01 12:00:00', 'admin', 'Inserción de nuevo alumno Juan Pérez'),
(2, 'Alumno', 'INSERT', '2024-02-15 12:00:00', 'admin', 'Inserción de nueva alumna María Gómez'),
(3, 'Alumno', 'INSERT', '2024-03-01 12:00:00', 'admin', 'Inserción de nuevo alumno Pedro López'),
(4, 'Alumno', 'INSERT', '2024-01-20 12:00:00', 'admin', 'Inserción de nueva alumna Ana Martínez'),
(5, 'Alumno', 'INSERT', '2024-02-05 12:00:00', 'admin', 'Inserción de nuevo alumno Luis García'),
(6, 'Alumno', 'INSERT', '2024-03-10 12:00:00', 'admin', 'Inserción de nueva alumna Sofía Fernández'),
(7, 'Alumno', 'INSERT', '2024-01-25 12:00:00', 'admin', 'Inserción de nuevo alumno Jorge Rodríguez'),
(8, 'Alumno', 'INSERT', '2024-02-14 12:00:00', 'admin', 'Inserción de nueva alumna Laura Hernández'),
(9, 'Alumno', 'INSERT', '2024-03-02 12:00:00', 'admin', 'Inserción de nuevo alumno Carlos Ramírez'),
(10, 'Alumno', 'INSERT', '2024-02-11 12:00:00', 'admin', 'Inserción de nueva alumna Marta López');

-- Inserción de datos para Contacto
INSERT INTO Contacto (ID_Contacto, ID_Usuario, Tipo, Valor) VALUES 
(1, 1, 'Email', 'juanperez@example.com'),
(2, 2, 'Email', 'mariagomez@example.com'),
(3, 3, 'Email', 'pedrolopez@example.com'),
(4, 4, 'Email', 'anamartinez@example.com'),
(5, 5, 'Email', 'luisgarcia@example.com'),
(6, 6, 'Email', 'sofiafernandez@example.com'),
(7, 7, 'Email', 'jorgerodriguez@example.com'),
(8, 8, 'Email', 'laurahernandez@example.com'),
(9, 9, 'Email', 'carlosramirez@example.com'),
(10, 10, 'Email', 'martalopez@example.com'),
(11, 11, 'Email', 'carlosrodriguez@example.com'),
(12, 12, 'Email', 'analopez@example.com'),
(13, 13, 'Email', 'luismartinez@example.com'),
(14, 14, 'Email', 'lauragarcia@example.com'),
(15, 15, 'Email', 'miguelperez@example.com'),
(16, 1, 'Teléfono', '123-456-7890'),
(17, 2, 'Teléfono', '234-567-8901'),
(18, 3, 'Teléfono', '345-678-9012'),
(19, 4, 'Teléfono', '456-789-0123'),
(20, 5, 'Teléfono', '567-890-1234');

-- Inserción de datos para Permiso
INSERT INTO Permiso (ID_Permiso, Nombre) VALUES 
(1, 'Ver_Materias'),
(2, 'Ver_Comisiones'),
(3, 'Ver_Alumnos'),
(4, 'Administrar_Usuarios');

-- Inserción de datos para Rol_Permiso
INSERT INTO Rol_Permiso (ID_Rol, ID_Permiso) VALUES 
('Alumno', 1),
('Alumno', 2),
('Profesor', 1),
('Profesor', 2),
('Profesor', 3),
('Administrador', 1),
('Administrador', 2),
('Administrador', 3),
('Administrador', 4);

-- CONSULTAS

--  1 ) Mostrar a los alumnos en las materias que estan inscriptos con su nombre , apellido, modalidad , turno , comision

SELECT a.Nombre, a.Apellido, m.Nombre_Materia, c.ID_Comision, c.Turno, c.Modalidad
FROM Alumno a
JOIN Inscripción i ON a.ID_Alumno = i.ID_Alumno
JOIN Comision c ON i.ID_Comision = c.ID_Comision
JOIN Materia m ON c.ID_Materia = m.ID_Materia; 

-- 2 ) Obtener las materias que dicta un profesor en especifico por su ID
/*
SELECT p.Nombre, p.Apellido, m.Nombre_Materia, c.Turno, c.Modalidad
FROM Profesor p
JOIN Dicta d ON p.ID_Profesor = d.ID_Profesor
JOIN Comision c ON d.ID_Comision = c.ID_Comision
JOIN Materia m ON c.ID_Materia = m.ID_Materia
WHERE p.ID_Profesor = 1; */

-- 3 ) Consultar si un alumno cumple con las correlativas para inscribrise en una materia 
/*
SELECT CASE
    WHEN NOT EXISTS (
        SELECT 1
        FROM Correlativa c
        LEFT JOIN Historial_Academico ha ON c.ID_Materia_Correlativa = ha.ID_Materia
        WHERE c.ID_Materia = 2 AND ha.ID_Alumno = 1
    ) THEN 'Puede Inscribirse'
    ELSE 'No Puede Inscribirse'
END AS Estado_Inscripción; */


--  4 ) Obtener el historial acedemico de un alumno en especifico
/*
SELECT ha.ID_Historial, m.Nombre_Materia, ha.Año_Cursada, ha.Nota
FROM Historial_Academico ha
JOIN Materia m ON ha.ID_Materia = m.ID_Materia
WHERE ha.ID_Alumno = 1; */

--  5 ) Consultar los finales rendidos por un alumno en especifico
/*
SELECT f.ID_Final, m.Nombre_Materia, f.Fecha_Final, f.Nota
FROM Final f
JOIN Materia m ON f.ID_Materia = m.ID_Materia
WHERE f.ID_Alumno = 1;
*/

-- 6 )  Obtener las comisiones y horarios de una materia en especifico
/*
SELECT m.Nombre_Materia, c.ID_Comision, c.Turno, c.Modalidad, h.Dia, h.Hora_Inicio, h.Hora_Fin
FROM Materia m
JOIN Comision c ON m.ID_Materia = c.ID_Materia
JOIN Horario h ON c.ID_Comision = h.ID_Comision
WHERE m.ID_Materia = 1; */

-- 7 ) Listar los alumnos de una carrera especifica y sus datos de contacto 
/*
SELECT a.Nombre, a.Apellido, c.Nombre_Carrera, con.Tipo, con.Valor
FROM Alumno a
JOIN Carrera c ON a.ID_Carrera = c.ID_Carrera
JOIN Usuario u ON a.ID_Alumno = u.ID_Alumno
JOIN Contacto con ON u.ID_Usuario = con.ID_Usuario
WHERE c.ID_Carrera = 1;*/

--  8 ) Obtener los permisos asociados a los profesores
/*
SELECT u.Username, p.Nombre AS Permiso
FROM Usuario u
JOIN Rol_Permiso rp ON u.Rol = rp.ID_Rol
JOIN Permiso p ON rp.ID_Permiso = p.ID_Permiso
WHERE u.Rol = 'Profesor'; */

-- 9) Listar los profesores y las materias que dictan
/*
SELECT p.Nombre, p.Apellido, m.Nombre_Materia, c.Turno, c.Modalidad
FROM Profesor p
JOIN Dicta d ON p.ID_Profesor = d.ID_Profesor
JOIN Comision c ON d.ID_Comision = c.ID_Comision
JOIN Materia m ON c.ID_Materia = m.ID_Materia;
*/

-- 10 ) Consultar el historial academica de los alumnos
/*
SELECT a.Nombre, a.Apellido, m.Nombre_Materia, ha.Año_Cursada, ha.Nota
FROM Alumno a
JOIN Historial_Academico ha ON a.ID_Alumno = ha.ID_Alumno
JOIN Materia m ON ha.ID_Materia = m.ID_Materia; */


 -- 11) Consultar correlatividades necesarias 
 /*
SELECT 
    m.Nombre_Materia AS Materia,
    mc.Nombre_Materia AS Correlativa_Necesaria
FROM 
    Correlativa c
JOIN 
    Materia m ON c.ID_Materia = m.ID_Materia
JOIN 
    Materia mc ON c.ID_Materia_Correlativa = mc.ID_Materia;
*/














