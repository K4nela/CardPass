CREATE DATABASE easypeasy;

USE easypeasy;

CREATE TABLE usuario(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);-- criei aqui uma tabela generalizando as pessoas que farao cadastro no app
  
    -- Inserindo usuários 
    INSERT INTO usuario ( nome, email, senha, endereco, telefone) VALUES
    ( 'João Silva', 'joao.silva@gmail.com', '1234', 'Rua A, 123', '61999999999'),
    ( 'Maria Souza', 'maria.souza@gmail.com', '1234', 'Rua B, 456', '61988888888'),
    ( 'Carlos Oliveira', 'carlos.oliveira@gmail.com', '1234', 'Rua C, 789', '61977777777'),
    ( 'Ana Pereira', 'ana.pereira@gmail.com', '1234', 'Rua D, 101', '61966666666');

CREATE TABLE responsavel(
    id_responsavel INT PRIMARY KEY,
    Foreign Key (id_responsavel) REFERENCES usuario(id)
);-- a pessoa pode ser um responsavel

    -- inserindo os usuários q são responsáveis 
    INSERT INTO responsavel (id_responsavel) VALUES
    (1),
    (2);

CREATE TABLE dependente(
    id_dependente INT PRIMARY KEY,
    id_responsavel INT NOT NULL,
    Foreign Key (id_dependente) REFERENCES usuario (id),
    Foreign Key (id_responsavel) REFERENCES responsavel (id_responsavel)
);-- a pessoa pode ser um dependente vinculado a um responsável

    -- inserindo os usuários q são responsáveis 
    INSERT INTO dependente (id_dependente ,id_responsavel) VALUES
    (3,1),
    (4,2);
    
CREATE TABLE administrador(
    id_admin INT PRIMARY KEY,
    FOREIGN KEY (id_admin) REFERENCES usuario(id)
);

CREATE TABLE listaDeDesejos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nomeItem VARCHAR (250),
    descricao VARCHAR (300),
    quantidade INT NOT NULL,
    nomeLoja VARCHAR (250),
    link VARCHAR (300)
);
    -- inserindo itens desejados à lista de desejos dos dependentes
        INSERT INTO listaDeDesejos (nomeItem, descricao, quantidade, nomeLoja, link) VALUES
    ('Blusa do Brasil', 'Tamanho: G', 2, 'Loja TeamShirt','https://shopee.com'),
    ('Óculos Bayoneta', 'Moledo preto', 1, 'Loja Óptica', 'https://firmo.com'),
    ('Chinelo Ortopedico', 'Chinelo tamanho 40', 1, 'Loja Calçados', 'https://shein.com'),
    ('Samgsung A15', 'Modelo 5G', 1, 'Loja Tech', 'https://mercadolivre.com');


CREATE TABLE pedidos(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_prod INT NOT NULL,
    id_depe INT NOT NULL,
    id_resp INT NOT NULL,
    dataPedido DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_prod) REFERENCES listaDeDesejos (id_produto),
    FOREIGN KEY (id_depe) REFERENCES dependente (id_dependente),
    FOREIGN KEY (id_resp) REFERENCES responsavel (id_responsavel)
);
    -- inserindo os pedidos, ligando os pedidos desejados pelos dependentes aos responsáveis
    INSERT INTO pedidos(id_prod, id_depe, id_resp, dataPedido)VALUES
    (1, 3, 1, NOW()),
    (2, 3, 1, NOW()),
    (3, 4, 2, NOW()),
    (4, 4, 2, NOW());

CREATE TABLE status (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    status ENUM('Pendente', 'Pago', 'Finalizado', 'Cancelado'),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
    -- inserindo o status dos pedidos através de id
    INSERT INTO status(id_status, status)VALUES
    (1,'Pendente'),
    (2,'Pendente'),
    (3,'Pendente'),
    (4,'Pendente');
    
CREATE TABLE historico(
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_status INT NOT NULL,
    id_pedido INT NOT NULL,
    dataH DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
    -- inserindo historico registrando o pedido e o seu status
    INSERT INTO historico(id_pedido, id_status, dataH)VALUES
    (1,1,NOW()),
    (2,2,NOW()),
    (3,NOW()),
    (4,NOW());
