USE PinskiDatabase;


-- Criando Dimensão Produto
CREATE VIEW dProduto AS
SELECT	
	p.id AS 'produto_id',
	p.descricao,
	c.id AS 'categoria_id',
	c.descricao AS categoria,
	p.tamanho,
	p.custoUnitario
FROM Produto p 
LEFT JOIN CategoriaProduto c
	ON p.categoria_id = c.id;


-- Criando Dimensão Cliente
CREATE VIEW dCliente AS
SELECT 
	c.id AS 'cliente_id',
	c.descricao,
	g.cidade,
	g.estado,
	g.uf,
	rb.Regiao
FROM Cliente c
LEFT JOiN Geografia g
	ON c.geografia_id = g.id
LEFT JOIN RegioesBrasil rb
	ON g.uf = rb.UF;


-- Criando Dimensão Vendedor
CREATE VIEW dVendedor AS
SELECT 
	v.id AS 'vendedor_id',
	v.descricao AS vendedor,
	s.descricao AS supervisor,
	s.gerente_id,
	s.gerente_descricao AS gerente
FROM Vendedor v
LEFT JOIN Supervisor s
	ON v.supervisor_id = s.id;


-- Criando Fato Vendas
CREATE VIEW fVendas AS
SELECT 
	v.[data],
	v.nfe,
	v.cliente_id,
	cv.vendedor_id,
	iv.produto_id,
	iv.item_quantidade,
	iv.valor_unitario,
	v.nf_desconto * iv.valor_bruto / v.valor_bruto as 'valor_desconto'
FROM Vendas v
LEFT JOIN ItensVendas iv
	ON v.id = iv.vendas_id
LEFT JOIN ClientesVendedores cv
	ON v.cliente_id = cv.cliente_id;

