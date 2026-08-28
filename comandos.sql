CREATE TABLE clientes(
	id serial PRIMARY KEY,
	nome VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL,
	cpf VARCHAR(11) UNIQUE NOT NULL,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE TABLE categorias(
	id serial PRIMARY KEY,
	nome VARCHAR(150) UNIQUE not null
)

CREATE TABLE produtos(
	id serial PRIMARY KEY,
	categoria_id int NOT NULL,
	nome VARCHAR(100) NOT NULL,
	preco numeric(10,2) NOT NULL CHECK(preco > 0),
	qtd_estoque int NOT NULL default 0 CHECK(qtd_estoque >= 0)
	
	)

    CREATE TABLE produto(
	id serial PRIMARY KEY,
	categoria_id int NOT NULL,
	nome VARCHAR(100) NOT NULL,
	preco numeric(10,2) NOT NULL CHECK(preco > 0),
	qtd_estoque int NOT NULL default 0 CHECK(qtd_estoque >= 0),

	CONSTRAINT fk_produtos_categoria
	FOREIGN key (categoria_id)
	REFERENCES categorias(id)
	on delete restrict
	
	
	)

    CREATE TABLE pedidos(
	id serial PRIMARY KEY,
	cliente_id INT NOT NULL,
	data_pedido TIMESTAMP DEFAULT current_timestamp,
	status varchar(20) DEFAULT 'pendente' CHECK (status in ('pendente' , 'pago' , 'enviado', 'cencelado')),

	constraint fk_pedido_cliente
	FOREIGN key (cliente_id)
	REFERENCES clientes(id)
	on delete cascade
	
	)

    CREATE TABLE itens_pedidos(
	pedido_id int not null,
	produto_id int not null,
	quantidade int not null check(quantidade > 0),
	preco_unitario numeric(10,2) not null check(preco_unitario > 0),

	primary key (pedido_id, produto_id),
	constraint fk_item_pedido FOREIGN key (pedido_id) references pedidos(id) on delete cascade,
	constraint fk_item_produto FOREIGN key (produto_id) references produtos(id) on delete restrict 	
)

insert into categorias(nome) VALUES
('Perifericos'),
('Monitores'),
('Hardwares')

SELECT * FROM categorias

INSERT INTO clientes(nome, email, cpf) VALUES
('Noah', 'noah@teste', '00011122233'),
('Vitor', 'vitor@teste', '99911122233'),
('Matheus', 'matheus@teste', '88811122233')

SELECT * FROM clientes

INSERT INTO produtos(categoria_id,nome,preco,qtd_estoque) VALUES
(1, 'Mouse RedRagon xto', 89.90, 97),
(1, 'teclado LogiTech', 120.00, 300),
(1, 'Mousepad Phillips', 39.99, 500),
(2, 'Monitor Phillips 24p 244hz', 899.90, 10),
(2, 'Monitor AOC 27p 75hz', 999.99, 150),
(2, 'Monitor Mancer 17p 240hz', 500.00, 600),
(3, 'Placa mae Asus A520', 450.90, 300),
(3, 'Memoria Ram DDR4 Reddragon 8GB', 580.90, 700),
(3, 'SSD 1TB Mancer', 800.50, 49)

SELECT * FROM produtos

INSERT INTO pedidos(cliente_id, status) VALUES
(1, 'pago'),
(1, 'enviado'),
(2, 'cencelado'),
(2, 'pago'),
(2, 'pendente'),
(3, 'cencelado'),
(3, 'pendente'),
(3, 'enviado')

INSERT INTO itens_pedidos (pedido_id, produto_id, quantidade, preco_unitario) VALUES 
(1, 1, 100, 300.00),
(1, 2, 50, 150.90),
(1, 3, 160, 250.00),
(2, 4, 100, 99.99),
(2, 5, 70, 1000.00),
(2, 6, 88, 450.00),
(3, 7, 54, 600.80),
(3, 8, 30, 900.99),
(3, 9, 25, 740.70)