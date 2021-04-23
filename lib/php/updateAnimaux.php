<?php
include "connection.php";

$id = $_POST["id_user"];
$type = $_POST["type"];
$result = array();
try{
    if($type == 1){
      $sql = "SELECT * from users u INTER join animaux p ON (u.id = p.id_user) WHERE u.id = ? ORDER BY p.id_animaux DESC";
          $req = $db->prepare($sql);
          $req->execute(array($id));
          while ($a = $req->fetch()){
            $result[] = $a;
          }
    }else if($type == 2){
      $post = json_decode($_POST["data"]);
      $id_animaux = $post->id_animaux;
      $espece = $post->espece;
      $matricule=$post->matricule;
      $isok=false;
      $msg = "";

      $sql= "UPDATE animaux SET espece=?, matricule=? WHERE id_animaux=?";
      $req = $db->prepare($sql);
      $req->execute(array($espece, $matricule, $id_animaux));
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