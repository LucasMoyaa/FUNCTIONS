-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS universidade;
USE universidade;

-- Criar tabelas
CREATE TABLE Alunos (
    aluno_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    sobrenome VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Areas (
    area_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Cursos (
    curso_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

CREATE TABLE Matriculas (
    matricula_id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT,
    curso_id INT,
    data_matricula DATETIME,
    FOREIGN KEY (aluno_id) REFERENCES Alunos(aluno_id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(curso_id)
);

-- Stored Procedure para inserir um novo curso
DELIMITER //
CREATE PROCEDURE InserirCurso (
    IN nome_curso VARCHAR(255),
    IN nome_area VARCHAR(255)
)
BEGIN
    DECLARE area_id INT;

    -- Verifica se a área já existe
    SELECT area_id INTO area_id FROM Areas WHERE nome = nome_area;

    -- Se a área não existe, insere
    IF area_id IS NULL THEN
        INSERT INTO Areas (nome) VALUES (nome_area);
        SET area_id = LAST_INSERT_ID();
    END IF;

    -- Insere o curso
    INSERT INTO Cursos (nome, area_id) VALUES (nome_curso, area_id);
END //
DELIMITER ;

-- Função para retornar o ID de um curso
CREATE FUNCTION ObterIdCurso (nome_curso VARCHAR(255), nome_area VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE curso_id INT;

    -- Busca o ID do curso
    SELECT curso_id INTO curso_id
    FROM Cursos c
    JOIN Areas a ON c.area_id = a.area_id
    WHERE c.nome = nome_curso AND a.nome = nome_area;

    RETURN curso_id;
END;

-- Stored Procedure para fazer a matrícula de um aluno em um curso
DELIMITER //
CREATE PROCEDURE MatricularAluno (
    IN nome_aluno VARCHAR(255),
    IN sobrenome_aluno VARCHAR(255),
    IN email_aluno VARCHAR(255),
    IN nome_curso VARCHAR(255),
    IN nome_area VARCHAR(255)
)
BEGIN
    DECLARE aluno_id INT;
    DECLARE curso_id INT;

    -- Verifica se o aluno já está matriculado em algum curso
    SELECT aluno_id INTO aluno_id FROM Alunos WHERE email = email_aluno;

    IF aluno_id IS NULL THEN
        -- Insere o aluno se não estiver cadastrado
        INSERT INTO Alunos (nome, sobrenome, email) VALUES (nome_aluno, sobrenome_aluno, email_aluno);
        SET aluno_id = LAST_INSERT_ID();
    END IF;

    -- Obtém o ID do curso
    SET curso_id = ObterIdCurso(nome_curso, nome_area);

    -- Verifica se o aluno já está matriculado no curso
    IF NOT EXISTS (SELECT 1 FROM Matriculas WHERE aluno_id = aluno_id AND curso_id = curso_id) THEN
        -- Faz a matrícula
        INSERT INTO Matriculas (aluno_id, curso_id, data_matricula) VALUES (aluno_id, curso_id, NOW());
    END IF;
END //
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE InserirAlunos()
BEGIN
    INSERT INTO Alunos (nome, sobrenome, email) VALUES 
    ('Liam', 'Smith', 'liam.smith@dominio.com'),
    ('Olivia', 'Johnson', 'olivia.johnson@dominio.com'),
    ('Noah', 'Williams', 'noah.williams@dominio.com'),
    ('Emma', 'Jones', 'emma.jones@dominio.com'),
    ('William', 'Brown', 'william.brown@dominio.com'),
    ('Ava', 'Davis', 'ava.davis@dominio.com'),
    ('James', 'Miller', 'james.miller@dominio.com'),
    ('Isabella', 'Wilson', 'isabella.wilson@dominio.com'),
    ('Oliver', 'Moore', 'oliver.moore@dominio.com'),
    ('Sophia', 'Taylor', 'sophia.taylor@dominio.com'),
    ('Benjamin', 'Anderson', 'benjamin.anderson@dominio.com'),
    ('Charlotte', 'Thomas', 'charlotte.thomas@dominio.com'),
    ('Elijah', 'Jackson', 'elijah.jackson@dominio.com'),
    ('Amelia', 'White', 'amelia.white@dominio.com'),
    ('Lucas', 'Harris', 'lucas.harris@dominio.com'),
    ('Mia', 'Martin', 'mia.martin@dominio.com'),
    ('Mason', 'Thompson', 'mason.thompson@dominio.com'),
    ('Harper', 'Garcia', 'harper.garcia@dominio.com'),
    ('Logan', 'Martinez', 'logan.martinez@dominio.com'),
    ('Evelyn', 'Robinson', 'evelyn.robinson@dominio.com'),
    ('Jackson', 'Clark', 'jackson.clark@dominio.com'),
    ('Abigail', 'Rodriguez', 'abigail.rodriguez@dominio.com'),
    ('Michael', 'Lewis', 'michael.lewis@dominio.com'),
    ('Emily', 'Lee', 'emily.lee@dominio.com'),
    ('Alexander', 'Walker', 'alexander.walker@dominio.com'),
    ('Elizabeth', 'Hall', 'elizabeth.hall@dominio.com'),
    ('Jacob', 'Allen', 'jacob.allen@dominio.com'),
    ('Avery', 'Young', 'avery.young@dominio.com'),
    ('Ella', 'Hernandez', 'ella.hernandez@dominio.com'),
    ('Daniel', 'King', 'daniel.king@dominio.com'),
    ('Sofia', 'Wright', 'sofia.wright@dominio.com'),
    ('Matthew', 'Lopez', 'matthew.lopez@dominio.com'),
    ('Camila', 'Hill', 'camila.hill@dominio.com'),
    ('William', 'Scott', 'william.scott@dominio.com'),
    ('Madison', 'Green', 'madison.green@dominio.com'),
    ('Anthony', 'Adams', 'anthony.adams@dominio.com'),
    ('Victoria', 'Baker', 'victoria.baker@dominio.com'),
    ('Joseph', 'Gonzalez', 'joseph.gonzalez@dominio.com'),
    ('Penelope', 'Nelson', 'penelope.nelson@dominio.com'),
    ('David', 'Carter', 'david.carter@dominio.com'),
    ('Grace', 'Mitchell', 'grace.mitchell@dominio.com'),
    ('Gabriel', 'Perez', 'gabriel.perez@dominio.com'),
    ('Lily', 'Roberts', 'lily.roberts@dominio.com'),
    ('Carter', 'Turner', 'carter.turner@dominio.com'),
    ('Aria', 'Phillips', 'aria.phillips@dominio.com'),
    ('John', 'Campbell', 'john.campbell@dominio.com'),
    ('Zoe', 'Parker', 'zoe.parker@dominio.com'),
    ('Grayson', 'Evans', 'grayson.evans@dominio.com'),
    ('Chloe', 'Edwards', 'chloe.edwards@dominio.com'),
    ('Isaac', 'Collins', 'isaac.collins@dominio.com'),
    ('Hannah', 'Stewart', 'hannah.stewart@dominio.com'),
    ('Lincoln', 'Sanchez', 'lincoln.sanchez@dominio.com'),
    ('Samantha', 'Morris', 'samantha.morris@dominio.com'),
    ('Christopher', 'Rogers', 'christopher.rogers@dominio.com'),
    ('Nova', 'Reed', 'nova.reed@dominio.com'),
    ('Jack', 'Cook', 'jack.cook@dominio.com'),
    ('Aurora', 'Morgan', 'aurora.morgan@dominio.com'),
    ('Nathan', 'Bell', 'nathan.bell@dominio.com'),
    ('Leah', 'Murphy', 'leah.murphy@dominio.com'),
    ('Connor', 'Bailey', 'connor.bailey@dominio.com'),
    ('Eleanor', 'Rivera', 'eleanor.rivera@dominio.com'),
    ('Mateo', 'Cooper', 'mateo.cooper@dominio.com'),
    ('Addison', 'Richardson', 'addison.richardson@dominio.com'),
    ('Luna', 'Cox', 'luna.cox@dominio.com'),
    ('Asher', 'Howard', 'asher.howard@dominio.com'),
    ('Aubrey', 'Ward', 'aubrey.ward@dominio.com'),
    ('Leo', 'Torres', 'leo.torres@dominio.com'),
    ('Hazel', 'Peterson', 'hazel.peterson@dominio.com'),
    ('Ryan', 'Gray', 'ryan.gray@dominio.com'),
    ('Zoey', 'Ramirez', 'zoey.ramirez@dominio.com'),
    ('Xavier', 'James', 'xavier.james@dominio.com'),
    ('Violet', 'Watson', 'violet.watson@dominio.com'),
    ('Gabriel', 'Brooks', 'gabriel.brooks@dominio.com'),
    ('Nora', 'Sanders', 'nora.sanders@dominio.com')
END$$
DELIMITER ;

CALL InserirAlunos();

-- Inserir 25 tipos de cursos
CALL InserirCurso('Introdução à Programação', 'Ciências da Computação');
CALL InserirCurso('Engenharia de Software', 'Ciências da Computação');
CALL InserirCurso('Cálculo Diferencial e Integral', 'Matemática');
CALL InserirCurso('Literatura Brasileira', 'Letras');
CALL InserirCurso('Física Quântica', 'Física');
CALL InserirCurso('História da Arte', 'Artes Visuais');
CALL InserirCurso('Gestão de Recursos Humanos', 'Administração');
CALL InserirCurso('Ecologia', 'Biologia');
CALL InserirCurso('Direito Constitucional', 'Direito');
CALL InserirCurso('Psicologia Organizacional', 'Psicologia');
CALL InserirCurso('Educação Infantil', 'Pedagogia');
CALL InserirCurso('Engenharia Mecânica', 'Engenharia');
CALL InserirCurso('Marketing Digital', 'Marketing');
CALL InserirCurso('Nutrição Esportiva', 'Nutrição');
CALL InserirCurso('Filosofia Antiga', 'Filosofia');
CALL InserirCurso('Geografia Política', 'Geografia');
CALL InserirCurso('Design de Interiores', 'Design');
CALL InserirCurso('Sociologia Urbana', 'Sociologia');
CALL InserirCurso('Música Clássica', 'Música');
CALL InserirCurso('Bioquímica', 'Química');
CALL InserirCurso('Engenharia Elétrica', 'Engenharia');
CALL InserirCurso('Contabilidade Financeira', 'Contabilidade');
CALL InserirCurso('Arquitetura Moderna', 'Arquitetura');
CALL InserirCurso('Economia Internacional', 'Economia');
CALL InserirCurso('Inglês Avançado', 'Línguas Estrangeiras');