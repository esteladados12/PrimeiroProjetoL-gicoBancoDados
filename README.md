# Banco de Dados para E-commerce 🛒

Este repositório contém a modelagem do **projeto lógico de banco de dados para o cenário de e-commerce**. O foco principal deste projeto foi garantir a **Integridade de Dados** e a escalabilidade através de relacionamentos bem definidos e restrições técnicas (Constraints).

## 📌 Sobre o Projeto

O objetivo foi construir um banco de dados que suporte um modelo de **Marketplace**, onde múltiplos vendedores e fornecedores podem interagir com um catálogo central de produtos.

### Diferenciais Técnicos:
- **Uso estratégico de Constraints**;
- **Uso rigoroso de `FOREIGN KEYS`** para evitar registros "órfãos" (como pedidos sem clientes).

## 🗺️ Modelo Er (Diagrama)

Abaixo, a representação visual das tabelas e seus relacionamentos:

![Diagrama do Banco de Dados]<img width="2026" height="1328" alt="Image" src="https://github.com/user-attachments/assets/1bbdeb1a-869f-4d61-a0ba-db0f633cbe42" />
> 🔗 [Visualize o diagrama interativo no dbdiagram.io](https://dbdiagram.io/d/699ca133bd82f5fce28f5568)

---

## 🏗️ Estrutura das Tabelas (Schema)

As tabelas foram divididas em quatro núcleos principais:

1.  **Núcleo de Clientes e Vendas**: Tabelas `Clients` e `Orders`.
2.  **Núcleo de Produtos**: Tabela `Product`, que atua como o centro do ecossistema.
3.  **Núcleo de Logística**: Tabelas `ProductStorage` e `StorageLocation`.
4.  **Núcleo de Marketplace**: Tabelas `Seller`, `Supplier` e suas conexões com produtos.

### Exemplo de Implementação (SQL)
Para garantir a qualidade dos indicadores de negócio, utilizamos regras como:
```sql
Primary Keys (PK): Todas as tabelas possuem IDs autoincrementais (ex: idCliente, idOrder), garantindo que cada registro seja único e indexado para performance;

Unique Constraints: *Clientes: CPF é único, impedindo cadastros duplicados; e Vendedores/Fornecedores: CNPJ e CPF são únicos, garantindo a rastreabilidade fiscal de cada lojista; 

Foreign Keys (FK): conectam as tabelas e impedem ações que gerariam dados "órfãos":
fk_orders_client: Garante que um pedido sempre aponte para um cliente real;
ProductOrder: Tabela de associação que conecta Product e Orders, garantindo que um item vendido exista no catálogo;
StorageLocation: Vincula produtos a locais de armazenamento existentes, impedindo erros de inventário;

Consistência de dados:
Pname (nome do produto), SocialName e TelephoneNumber são obrigatórios (not null);
OrderStatus: Todo novo pedido inicia automaticamente como 'Em processamento' (default);
SendValue: Valor de frete padrão definido como 10 caso não seja informado (default);
