-- cria o banco
CREATE DATABASE easypeasy2;
USE easypeasy2;

-- tabela usuario
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);

INSERT INTO usuario (nome, email, senha, endereco, telefone) VALUES
('João Silva', 'joao.silva@gmail.com', '1234', 'Rua A, 123', '61999999999'),
('Maria Souza', 'maria.souza@gmail.com', '1234', 'Rua B, 456', '61988888888'),
('Carlos Oliveira', 'carlos.oliveira@gmail.com', '1234', 'Rua C, 789', '61977777777'),
('Ana Pereira', 'ana.pereira@gmail.com', '1234', 'Rua D, 101', '61966666666'),
('Maria Eduarda', 'maria.eduarda@gmail.com', '1234', 'Rua E, 102', '61955555555');

-- tabela administrador
CREATE TABLE administrador (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

INSERT INTO administrador (id_usuario) VALUES
(5);

-- tabela familiar
CREATE TABLE familiar (
    id_familiar INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

INSERT INTO familiar (id_usuario) VALUES
(1),
(2);

-- tabela idoso
CREATE TABLE idoso (
    id_idoso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

INSERT INTO idoso (id_usuario) VALUES
(3),
(4);

-- tabela monitora
CREATE TABLE monitora (
    id_familiar INT,
    id_idoso INT,
    PRIMARY KEY (id_familiar, id_idoso),
    FOREIGN KEY (id_familiar) REFERENCES familiar(id_familiar),
    FOREIGN KEY (id_idoso) REFERENCES idoso(id_idoso)
);

INSERT INTO monitora (id_familiar, id_idoso) VALUES 
(1, 1),
(2, 2),
(1, 2);

-- tabela listaDeDesejos
CREATE TABLE listaDeDesejos (
    id_lista INT AUTO_INCREMENT PRIMARY KEY,
    data_solicitacao DATE,
    id_idoso INT,
    FOREIGN KEY (id_idoso) REFERENCES idoso(id_idoso)
);

INSERT INTO listaDeDesejos (id_idoso, data_solicitacao) VALUES
(1, NOW()),
(1, NOW()),
(2, NOW()),
(2, NOW());

-- tabela itens
CREATE TABLE itens (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    nome_loja VARCHAR(100),
    descricao TEXT,
    quantidade INT,
    link VARCHAR(255)
);

INSERT INTO itens (nome_item, descricao, quantidade, nome_loja, link) VALUES
('Blusa do Brasil', 'Tamanho: G', 2, 'Loja TeamShirt', 'https://shopee.com'),
('Óculos Bayoneta', 'Modelo preto', 1, 'Loja Óptica', 'https://firmo.com'),
('Chinelo Ortopedico', 'Chinelo tamanho 40', 1, 'Loja Calçados', 'https://shein.com'),
('Samsung A15', 'Modelo 5G', 1, 'Loja Tech', 'https://mercadolivre.com');

-- tabela lista_itens
CREATE TABLE lista_itens (
    id_lista INT,
    id_item INT,
    PRIMARY KEY (id_lista, id_item),
    FOREIGN KEY (id_lista) REFERENCES listaDeDesejos(id_lista),
    FOREIGN KEY (id_item) REFERENCES itens(id_item)
);

INSERT INTO lista_itens (id_lista, id_item) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

-- tabela status
CREATE TABLE status (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(50) NOT NULL
);

INSERT INTO status (nome_status) VALUES
('Pendente'),
('Em andamento'),
('Concluído'),
('Cancelado');

-- tabela historico
CREATE TABLE historico (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    id_lista INT,
    id_status INT,
    FOREIGN KEY (id_lista) REFERENCES listaDeDesejos(id_lista),
    FOREIGN KEY (id_status) REFERENCES status(id_status)
);

INSERT INTO historico (id_lista, id_status, data) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW()),
(4, 4, NOW());
