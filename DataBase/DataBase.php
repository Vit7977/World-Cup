<?php 
    class DataBase{
        private $dbHost = "localhost";
        private $dbUser = "root";        
        private $dbPass = "";
        private $dbName = "WorldCup";
        public static $conn = null;

        private function __construct(){
            $this->dbHost;
            $this->dbUser;
            $this->dbPass;
            $this->dbName;
            if(self::$conn === null){
                self::$conn = $this->connect();
            }
        }
    
        public function connect():PDO{
            try {
                $conn = new PDO("mysql:host={$this->dbHost};dbname={$this->dbName}", $this->dbUser, $this->dbPass);
                $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
                return $conn;
            } catch (PDOException $e) {
                die("Falha na conexão: " . $e->getMessage());
            }
    }
}