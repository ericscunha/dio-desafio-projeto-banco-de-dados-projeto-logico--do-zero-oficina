-- Criação do banco de dados para o cenário de Oficina
DROP SCHEMA IF EXISTS `oficina` ;
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(12) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tipo_cliente` ENUM("PF", "PJ") NOT NULL,
  `numero_documento` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `unique_email` (`email` ASC) VISIBLE);

-- Tabela Veiculo
CREATE TABLE IF NOT EXISTS `veiculo` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NULL,
  `cor` VARCHAR(15) NULL,
  `ano` CHAR(4) NULL,
  `placa` VARCHAR(12) NOT NULL,
  `chassi` VARCHAR(45) NULL,
  `id_cliente` INT NOT NULL,
  `ultima_revisao` DATE NULL,
  PRIMARY KEY (`id_veiculo`),
  INDEX `fk_veiculo_cliente_idx` (`id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `unique_placa` (`placa` ASC) VISIBLE,
  CONSTRAINT `fk_veiculo_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Tabela Mecânico
CREATE TABLE IF NOT EXISTS `mecanico` (
  `id_mecanico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_mecanico`));

-- Tabela Equipe
CREATE TABLE IF NOT EXISTS `equipe` (
  `id_equipe` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_equipe`));

-- Tabela Ordem de Serviço
CREATE TABLE IF NOT EXISTS `ordem_servico` (
  `id_ordem_servico` INT NOT NULL AUTO_INCREMENT,
  `id_veiculo` INT NOT NULL,
  `id_equipe` INT NOT NULL,
  `tipo_servico` ENUM("Manutenção", "Revisão") NOT NULL DEFAULT 'Manutenção',
  `data_emissao` DATE NOT NULL,
  `data_final` DATE NULL,
  `valor` FLOAT NULL,
  `situacao` ENUM("Aberto", "Aprovado", "Em Andamento", "Concluído", "Fechado", "Cancelado") NULL DEFAULT 'Aberto',
  PRIMARY KEY (`id_ordem_servico`),
  INDEX `fk_os_veiculo_idx` (`id_veiculo` ASC) VISIBLE,
  INDEX `fk_os_equipe_idx` (`id_equipe` ASC) VISIBLE,
  CONSTRAINT `fk_os_veiculo`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `veiculo` (`id_veiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_equipe`
    FOREIGN KEY (`id_equipe`)
    REFERENCES `equipe` (`id_equipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Tabela Serviço
CREATE TABLE IF NOT EXISTS `servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`id_servico`));

-- Tabela Itens de Serviço da Ordem de Serviços
CREATE TABLE IF NOT EXISTS `itens_ordem_servico` (
  `id_ordem_servico` INT NOT NULL,
  `id_servico` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`, `id_servico`),
  INDEX `fk_itens_os_servico_idx` (`id_servico` ASC) VISIBLE,
  INDEX `fk_itens_os_ordem_servico_idx` (`id_ordem_servico` ASC) VISIBLE,
  CONSTRAINT `fk_itens_os_ordem_servico`
    FOREIGN KEY (`id_ordem_servico`)
    REFERENCES `ordem_servico` (`id_ordem_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_os_servico`
    FOREIGN KEY (`id_servico`)
    REFERENCES `servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Tabela de Peças
CREATE TABLE IF NOT EXISTS `peca` (
  `id_peca` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`id_peca`));

-- Tabela de Peças da Ordem de Serviço
CREATE TABLE IF NOT EXISTS `ordem_servico_pecas` (
  `id_ordem_servico` INT NOT NULL,
  `id_peca` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`, `id_peca`),
  INDEX `fk_os_pecas_peca_idx` (`id_peca` ASC) VISIBLE,
  INDEX `fk_os_pecas_oderm_servico_idx` (`id_ordem_servico` ASC) VISIBLE,
  CONSTRAINT `fk_os_pecas_oderm_servico`
    FOREIGN KEY (`id_ordem_servico`)
    REFERENCES `ordem_servico` (`id_ordem_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_pecas_peca`
    FOREIGN KEY (`id_peca`)
    REFERENCES `peca` (`id_peca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Tabela Equipe de Mecânicos
CREATE TABLE IF NOT EXISTS `equipe_mecanicos` (
  `id_equipe` INT NOT NULL,
  `id_mecanico` INT NOT NULL,
  PRIMARY KEY (`id_equipe`, `id_mecanico`),
  INDEX `fk_equipe_mecanicos_mecanico_idx` (`id_mecanico` ASC) VISIBLE,
  INDEX `fk_equipe_mecanicos_equipe_idx` (`id_equipe` ASC) VISIBLE,
  CONSTRAINT `fk_equipe_mecanicos_equipe`
    FOREIGN KEY (`id_equipe`)
    REFERENCES `equipe` (`id_equipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_mecanicos_mecanico`
    FOREIGN KEY (`id_mecanico`)
    REFERENCES `mecanico` (`id_mecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
show tables;