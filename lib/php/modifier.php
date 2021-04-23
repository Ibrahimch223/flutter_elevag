<?php
 include "connection.php";
 $id = $_POST->id;
 $name = $_POST->nom;
 $prenom = $_POST->prenom;
 $email = $_POST->email;
 $pass = sha1($_POST->pass);

 try{
     $stmt = $db->prepare("UPDATE users SET nom = ?, prenom = ?,email =? , password = ? WHERE id = ?");
     $result =  $stmt->execute(array($name, $prenom,$email,$pass, $id));

     if ($result) {
         $succes = 1;
         $msg = "Enregistré avec succès";
     } else {
         $succes = 0;
         $msg = "Erreur d'enregistrement";
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
