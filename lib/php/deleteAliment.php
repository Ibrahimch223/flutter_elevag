<?php

include "connection.php";

$idp = json_decode($_POST["id_aliments"]);
$isok = false;
try{
  for($i = 0; $i < count($idp); $i++) {
     $req = $db->prepare("DELETE FROM aliment WHERE id_aliment=?");
     $req->execute(array($idp[$i]));
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