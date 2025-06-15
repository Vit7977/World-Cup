<?php 
require_once './DataBase/DataBase.php';
    class Pais{
        private $id;
        private $nome;
        private $bandeira;
        private $grupo;

        public function __construct($nome, $bandeira, $grupo){
            $this->nome = $nome;
            $this->bandeira = $bandeira;
            $this->grupo = $grupo;
        }

        public function getPais(){
            $cx = (new DataBase()->connect());
            $sql = "SELECT * FROM pais ORDER BY pais.nome;";
            $stmt = $cx->prepare($sql);
            
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        public function cadastrarPais($dados){
            $cx = (new DataBase()->connect());
            $sql = "INSERT INTO pais (nome, bandeira_url, fk_grupo) VALUES (:nome, :bandeira_url, :grupo_id);";
            $stmt = $cx->prepare($sql);

            try{
                $stmt->execute($dados);
                if($stmt->rowCount() <= 0){
                    echo "<script>alert('ERRO: Não foi possível cadastrar o país!')</script>";
                }
                echo "<script>alert('País cadastrado com sucesso!')</script>";
                
            }catch(PDOException $error){
                echo "<script>alert('ERRO ao cadastrar país: ".$error->getMessage()."')</script>";
            }
        }

        public function updatePais($dados): bool{
            $cx = (new DataBase()->connect());
            $sql = "UPDATE pais SET nome = :nome, bandeira_url = :bandeira_url, fk_grupo = :grupo_id WHERE id = :id;";
            $stmt = $cx->prepare($sql);

            try{
                $stmt->execute($dados);
                if($stmt->rowCount() <= 0){
                    echo "<script>alert('ERRO: Não foi possível atualizar país!')</script>";
                    return false;
                }
                echo "<script>alert('País atualizado com sucesso!')</script>";
                return true;
            }catch(PDOException $error){
                echo "<script>alert('ERRO ao atualizar país: ".$error->getMessage()."')</script>";
                return false;
            }
        }

        public function deletePais($id){
            $cx = (new DataBase()->connect());
            $sql = "DELETE FROM pais WHERE id = :id;";
            $stmt = $cx->prepare($sql);

            try{
                $stmt->execute([":id" => $id]);
                if($stmt->rowCount() <= 0){
                    echo "<script>alert('ERRO: Não foi possível excluir país!')</script>";
                }
                echo "<script>alert('País excluido com sucesso!')</script>";
            }catch(PDOException $error){
                echo "<script>alert('ERRO ao excluir país: ".$error->getMessage()."')</script>";
            }
        }
    }