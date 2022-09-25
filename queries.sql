-- conecta ao banco
use oficina;

-- Dados dos Clientes
Select
	c.nome,
    c.tipo_cliente,
    c.numero_documento,
    c.endereco,
    c.telefone,
    c.email
from
  cliente c;