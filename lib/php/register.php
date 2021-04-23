<?php
  include "connection.php";

  $nom = $_POST['nom'];
  $prenom = $_POST['prenom'];
  $profession = $_POST['profession'];
  $email = $_POST['email'];
  $pass = sha1($_POST['pass']);

  try{
   if(isset($nom, $prenom, $profession, $email, $pass)){
      $req = $db->prepare("SELECT * FROM users WHERE email=?");
      $req->execute(array($email));
      $exist = $req->rowCount();
     if($exist == 0){
      $req = $db->prepare("INSERT INTO users VALUES(null,?,?,?,?,?)");
            $req->execute(array($nom, $prenom, $profession, $email, $pass));
            if($req){
             $succes = 1;
             $msg = "Enregistré avec succès";
     }else{
        $succes = 0;
        $msg = "Erreur d'enregistrement";
      }
      }else {
              $msg = "Email déjà existant";
              $succes = 0;
             }
   }else{
    $succes = 0;
    $msg = "Error empty data";
   }
  }
  catch (\Throwable $th){
    $succes = 0;
    $msg = "Erreur:".$th->getMessage();
    }
    echo json_encode([
      "data"=>[
       $msg,
       $succes
      ]
    ]);
?>