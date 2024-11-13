-- CREAR BASE DE DATOS
CREATE DATABASE forward_engineer;
USE forward_engineer;

-- CREAR TABLAS
CREATE TABLE estudiantes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE cursos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    duracion INT NOT NULL
);

CREATE TABLE inscripciones (
	id_estudiante INT,
    FOREIGN KEY(id_estudiante) REFERENCES estudiantes(id),
    id_curso INT,
    FOREIGN KEY(id_curso) REFERENCES cursos(id),
    PRIMARY KEY(id_estudiante, id_curso)
);

-- AGREGAR DATOS
INSERT INTO estudiantes (nombre, edad)
VALUES ('Nala', 27),
		('Abigail', 29),
        ('Ester', 20),
        ('Trinidad', 26),
        ('Montserrat', 20);
        
INSERT INTO cursos (nombre, duracion)
VALUES ('Matemáticas', 20),
		('Historia', 60),
        ('Artes', 40),
        ('Ciencias', 30);
        
-- ASOCIAR ESTUDIANTES A CURSOS
INSERT INTO inscripciones (id_estudiante, id_curso)
VALUES (1, 4),
		(2, 3),
        (3, 1),
        (4, 2),
        (1, 3),
        (2, 4),
        (3, 2),
        (4, 1);
        
-- ESTUDIANTES Y SUS CURSOS
SELECT e.nombre, c.nombre FROM estudiantes e 
INNER JOIN inscripciones i ON e.id = i.id_estudiante
INNER JOIN cursos c ON i.id_curso = c.id;

-- BUSCAR POR NOMBRE DE CURSO
SELECT e.nombre FROM estudiantes e
INNER JOIN inscripciones i ON e.id = i.id_estudiante
INNER JOIN cursos c ON i.id_curso = c.id WHERE c.nombre = 'Matemáticas';

-- BUSCAR POR NOMBRE DE ESTUDIANTE
SELECT c.nombre FROM cursos c
JOIN inscripciones i ON c.id = i.id_curso
JOIN estudiantes e ON i.id_estudiante = e.id WHERE e.nombre = 'Ester';

-- CONTAR ESTUDIANTES EN CURSOS
SELECT c.nombre, count(i.id_estudiante) AS numero_de_estudiantes FROM cursos c LEFT JOIN inscripciones i ON c.id = i.id_curso GROUP BY c.nombre;

-- ESTUDIANTES SIN CURSO
SELECT e.nombre FROM estudiantes e LEFT JOIN inscripciones i ON e.id = i.id_estudiante WHERE i.id_estudiante IS NULL;