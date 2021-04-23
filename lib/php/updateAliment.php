<?php
include "connection.php";

$id = $_POST["id_user"];
$type = $_POST["type"];
$result = array();
try{
    if($type == 1){
      $sql = "SELECT * from users u INTER join aliment p ON (u.id = p.id_user) WHERE u.id = ? ORDER BY u.id = ? ORDER BY p";
          $req = $db->prepare($sql);
          $req->execute(array($id));
          while ($a = $req->fetch()){
            $result[] = $a;
          }
    }else if($type == 2){
      $post = json_decode($_POST["data"]);
      $id_aliment = $post->id_aliment;
      $nom = $post->nom;
      $quantite=$post->quantite;
      $isok=false;
      $msg = "";

      $sql= "UPDATE animaux SET nom=?, quantite=? WHERE id_aliment=?";
      $req = $db->prepare($sql);
      $req->execute(array($nom, $quantite, $id_aliment));
      if($req){
       $isok = true;
       $result = [
         $isok,
         "Modifié avec succès"
       ];
      }
    }
}catch(PDOException $th){
}
  echo json_encode($result);

?>