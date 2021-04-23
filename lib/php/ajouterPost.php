<?php
include "connection.php";

$post = json_decode($_POST["data"]);
$id_user = $post->id_user;
$matricule = $post->matricule;
$diagnostic=$post->diagnostic;
$traitement=$post->traitement;
$isok=false;
$msg = "";

try{
  $req = $db->prepare("INSERT INTO aliment(id_user, matricule, diagnostic, traitement) VALUES(?,?,?,?)");
  $req->execute(array($id_user, $matricule, $diagnostic, $traitement));
  if($req){
     $isok=true;
     $msg="Enregistré avec succès";
  }else{
    $msg="Echec d'enregistrement";
  }
 }catch(\Throwable $th){
   $msg="Echec d'enregistrement";
}
   echo json_encode([
           $isok,
           $msg
        ]);
?>