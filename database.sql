-- Criação das Tabelas
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE
);

CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY AUTO_INCREMENT,
    valorTotal DECIMAL(10,2),
    estado VARCHAR(20) -- Ex: 'Pago', 'Pendente'
);

CREATE TABLE Locacao (
    idLocacao INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    idPagamento INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idPagamento) REFERENCES Pagamento(idPagamento)
);

-- Consulta de Inadimplência (Relatório)
SELECT c.nome, SUM(p.valorTotal) AS total_devido
FROM Cliente c
JOIN Locacao l ON c.idCliente = l.idCliente
JOIN Pagamento p ON l.idPagamento = p.idPagamento
WHERE p.estado = 'Pendente'
GROUP BY c.nome
ORDER BY c.nome ASC;