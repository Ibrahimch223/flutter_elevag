<?php
include "connection.php";

$post = json_decode($_POST["data"]);
$id_user = $post->id_user;
$nom = $post->nom;
$quantite=$post->quantite;
$isok=false;
$msg = "";

try{
  $req = $db->prepare("INSERT INTO aliment(id_user, nom, quantite) VALUES(?,?,?)");
  $req->execute(array($id_user, $nom, $quantite));
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