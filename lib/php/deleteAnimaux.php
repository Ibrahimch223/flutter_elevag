<?php

include "connection.php";

$ida = json_decode($_POST["id_animals"]);
$isok = false;
try{
  for($i = 0; $i < count($ida); $i++) {
     $req = $db->prepare("DELETE FROM animaux WHERE id_animaux=?");
     $req->execute(array($ida[$i]));
  }
  $isok = true;
  $msg = "Supprimé avec succès";
}catch (PDOException $th) {
   $msg = "Echec de suppression";
}
 echo json_encode([
           $isok,
           $msg
        ]);
?>