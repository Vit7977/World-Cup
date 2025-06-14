DROP DATABASE WorldCup;
CREATE DATABASE WorldCup;
USE WorldCup;

CREATE TABLE edicao(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome CHAR(4),
    sede VARCHAR(100),
    descricao VARCHAR(255)
);

CREATE TABLE grupo(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome CHAR(1)
);

CREATE TABLE pais(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    bandeira_url VARCHAR(1000),
    fk_grupo INT UNSIGNED
    FOREIGN KEY (fk_grupo) REFERENCES grupo(id)
);

CREATE TABLE posicao(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    sigla VARCHAR(3),
    descricao VARCHAR(50)
);

CREATE TABLE jogador(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_nasc DATE,
    foto_url VARCHAR(1000)
);
ALTER TABLE jogador ADD INDEX(id);

CREATE TABLE tecnico(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_nasc DATE,
    foto_url VARCHAR(1000)
);
ALTER TABLE tecnico ADD INDEX(id);

CREATE TABLE estadio(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    cap_pessoas INT UNSIGNED
);

CREATE TABLE jogo(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    fase ENUM("Grupos","Oitavas","Quartas","Semifinal","Final"),
    data DATE,
    fk_estadio INT UNSIGNED
    FOREIGN KEY (fk_estadio) REFERENCES estadio(id)
);
ALTER TABLE jogo ADD INDEX(id);

CREATE TABLE pais_em_grupo(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    status ENUM("Classificado", "Eliminado") NULL,
    fk_pais INT UNSIGNED, 
    fk_grupo INT UNSIGNED
    FOREIGN KEY (fk_pais) REFERENCES pais(id)
    FOREIGN KEY (fk_grupo) REFERENCES grupo(id)
);

CREATE TABLE pais_em_jogo(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    resultado ENUM("Vitoria", "Derrota", "Empate") NOT NULL,
    fk_pais INT UNSIGNED,
    fk_jogo INT UNSIGNED
);

CREATE TABLE jogador_em_pais(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    num_jogador INT,
    data_entrada DATE,
    data_saida DATE,
    fk_pais INT UNSIGNED,
    fk_jogador INT UNSIGNED,
    fk_posicao INT UNSIGNED
    FOREIGN KEY (fk_pais) REFERENCES pais(id)
    FOREIGN KEY (fk_jogador) REFERENCES jogador(id)
    FOREIGN KEY (fk_posicao) REFERENCES posicao(id)
);

CREATE TABLE gol(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tempo VARCHAR(6) NOT NULL,
    fk_jogador_em_pais INT UNSIGNED,
    fk_pais_em_jogo INT UNSIGNED
    FOREIGN KEY (fk_jogador_em_pais) REFERENCES jogador_em_pais(id)
    FOREIGN KEY (fk_pais_em_jogo) REFERENCES pais_em_jogo(id)
);

CREATE TABLE cartao(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tempo VARCHAR(6) NOT NULL,
    fk_jogador_em_pais INT UNSIGNED,
    fk_pais_em_jogo INT UNSIGNED
     FOREIGN KEY (fk_jogador_em_pais) REFERENCES jogador_em_pais(id)
    FOREIGN KEY (fk_pais_em_jogo) REFERENCES pais_em_jogo(id)
);