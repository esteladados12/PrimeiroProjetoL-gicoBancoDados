-- Listar todos os clientes: Mostrar nome e sobrenome ordenados alfabeticamente
SELECT
Fname as 'nome',
Lname as 'sobrenome'
from Clients
order by 'nome' asc; 

SELECT 
CONCAT(Fname, ' ', Lname) as nome_completo
from Clients
order by nome_completo



-- Produtos para crianças: Selecionar todos os produtos onde Classification_kids é verdadeiro.
select 
Pname as Produto, 
Category as Categoria
from Product
where 
Classification_kids = True;


-- Contagem de pedidos: Saber quantos pedidos foram realizados no total.
select 
count(*) from Orders


-- Estoque crítico: Mostrar produtos que possuem menos de 100 unidades em algum local de estoque.
select 
P.Pname as Produto,
PS.Quantity as Estoque,
PS.StorageLocation as Localização
from ProductStorage PS
JOIN StorageLocation SL on PS.idProductStorage = SL.idLocalStorage
JOIN Product P on SL.idLocalProduct = P.idProduto
WHERE 
PS.Quantity <100;


-- Status dos pedidos: Listar todos os pedidos que estão com o status 'Cancelado'.
SELECT
idOrder as Numero_pedido,
idOrderClient as ID_cliente,
OrderDescription as Motivo
from Orders
WHERE
OrderStatus = 'Cancelado';


> MÉDIA complexidade
-- Pedidos por Cliente: Listar o nome do cliente e a quantidade de pedidos que cada um já fez.
SELECT
CONCAT(Fname, ' ', Lname) as Cliente,
COUNT(O.idOrder) as Pedidos
from Clients as C 
JOIN Orders as O on C.idCliente = O.idOrderClient
GROUP BY C.idCliente, Fname
ORDER BY Pedidos desc;


-- Valor Total de Frete: Somar quanto cada cliente já pagou em frete (SendValue) acumulado.
SELECT
CONCAT(Fname, ' ', Lname) as Cliente,
SUM(O.SendValue) as Frete
from Clients as C 
JOIN Orders as O on C.idCliente = O.idOrderClient
GROUP BY C.idCliente, Fname
ORDER BY Frete desc;


-- Produtos e seus Fornecedores: Exibir o nome do produto e o nome social do fornecedor que o entrega.
SELECT 
P.Pname as Produto, 
P.Category as Categoria,
S.SocialName as Razao_Social,
S.CNPJ as CNPJ,
S.EmailSupplier as Email,
S.TelephoneNumber as Telefone
FROM
Product P
INNER JOIN
ProductSupplier PS ON P.idProduto = PS.idProductSupplierProduct 
INNER JOIN Supplier S ON PS.idProductSupplier = S.idSupplier 
ORDER BY Categoria;


-- Vendedores por Região: Contar quantos vendedores existem em cada cidade (Location).
SELECT
Location as Localização,
COUNT(idSeller) as Total_vendedores
FROM Seller
Group by Localização;


-- Produtos sem Estoque: Listar o nome dos produtos que aparecem na tabela de pedidos com o status 'Sem estoque'
SELECT
P.Pname as Produto,
P.Category as Categoria, 
PO.ProductOrderQuantity as Quantidade,
PO.idProductOrderProduct as Numero_Pedido
FROM Product P
INNER JOIN ProductOrder PO on P.idProduto = PO.idProductOrderProduct
WHERE 
PO.ProductOrderStatus = 'Sem estoque';


> ALTA complexidade
-- Ranking de Vendedores: Listar os vendedores que possuem a maior variedade de produtos distintos cadastrados
SELECT 
    S.SocialName AS Vendedor,
    COUNT(DISTINCT PS.idProduct) AS Variedade_Produtos,
    SUM(PS.ProductQuantity) AS Total_Itens_Estoque
FROM Seller S
LEFT JOIN ProductSeller PS ON S.idSeller = PS.idProductSeller
GROUP BY S.idSeller, S.SocialName
ORDER BY Total_Itens_Estoque DESC;


-- Localização Física de Pedidos: Para um pedido específico (ex: ID 1), mostrar o nome do produto e em qual prateleira/localização ele deve ser retirado no estoque.
SELECT
O.idOrder as Pedido,
P.Pname as Produto,
PS.StorageLocation as Localização,
SL.Location as Posição
from Orders O
INNER JOIN ProductOrder PO on O.idOrder = PO.idProductOrder
INNER JOIN Product P ON PO.idProductOrderProduct = P.idProduto
INNER JOIN StorageLocation SL ON P.idProduto = SL.idLocalProduct 
INNER JOIN ProductStorage PS ON SL.idLocalProduct = PS.idProductStorage
WHERE 
O.idOrder = 2;


-- Clientes "VIP" e seus produtos: Listar o nome dos clientes que gastaram mais de R$ 10,00 em frete e quais produtos eles costumam comprar.

SELECT
C.idCliente as ID_Cliente,
CONCAT(C.Fname, ' ', C.Lname) as Nome_Cliente,
SUM(O.SendValue) as Total_Frete,
GROUP_CONCAT(DISTINCT P.Pname SEPARATOR ', ') as Itens_Comprados
from Clients C
INNER JOIN Orders O on C.idCliente = O.idOrderClient
INNER JOIN ProductOrder PO on O.idOrder = PO.idProductOrder
INNER JOIN Product P on PO.idProductOrderProduct = P.idProduto
GROUP BY C.idCliente, C.Fname
HAVING Total_Frete > 10.00
ORDER BY Total_Frete DESC;


-- Cruzamento Fornecedor x Vendedor: Identificar se existe algum produto que é fornecido por um fornecedor específico (ex: 'Tech Global') mas que também é vendido por um vendedor terceiro (ex: 'TechStore SA').
SELECT 
P.Pname as Produto,
P.Category as Categoria,
S.SocialName as Fornecedor, 
SEL.SocialName as Vendedor_Terceiro
FROM Product P
INNER JOIN ProductSupplier PS on P.idProduto = PS.idProductSupplierProduct
INNER JOIN Supplier S on PS.idProductSupplier = S.idSupplier
INNER JOIN ProductSeller PSEL on P.idProduto = PSEL.idProduct
INNER JOIN Seller SEL on PSEL.idProductSeller = SEL.idSeller
ORDER BY Pname;

