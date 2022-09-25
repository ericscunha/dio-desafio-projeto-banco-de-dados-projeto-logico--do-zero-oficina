-- Persitência de dados no banco de dados
use ecommerce;

insert into cliente (nome, tipo_cliente, numero_documento, endereco, email, telefone)
	values ('Joao S. Santos', 'PF', '12345678901', 'Rua A', 'joao@email.com', '71999998888'),
           ('Maria B. Carvalho', 'PF', '13355678901', 'Rua B', 'maria@email.com', '79999776688'),
           ('Carlos A. Barbosa', 'PF', '17345676981', 'Rua do Meio', 'carlos@email.com', '82998795846'),
           ('Ventura SA', 'PJ', '123456789000145', 'Rua do Inácio', 'ventura@email.com', '799981234455');