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

    CREATE TABLE produtos(
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