<?php
include "connection.php";

$result = array();
try{
    $sql = "SELECT * from users u INNER join animaux p ON (u.id = p.id_user) ORDER BY p.id_animaux DESC";
    $req = $db->query($sql);
    while ($a = $req->fetch()){
      $result[] = $a;
    }
}catch(PDOException $th){
}
  echo json_encode($result);

?>