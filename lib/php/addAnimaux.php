<?php
include "connection.php";

$post = json_decode( $_POST["data"]);
$id_user = $post->id_user;
$espece = $post->espece;
$matricule=$post->matricule;
$isok=false;
$msg = "";

try{
  $req = $db->prepare("INSERT INTO animaux(id_user, espece, matricule) VALUES(null,null,?,?,?)");
  $req->execute(array($id_user, $espece, $matricule));
  if($req){
     $isok=true;
     $msg="Ajouté avec succès";

  }else{
    $msg="Echec d'ajout";
  }
 }catch(\Throwable $th){
   $msg="Echec d'ajout";
}
   echo json_encode([
           $isok,
           $msg
        ]);
?>