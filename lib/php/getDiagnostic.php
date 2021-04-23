<?php
include "connection.php";

$result = array();
try{
    $sql = "SELECT * from users u INNER join diagnostics p ON (u.id = p.id_user) ORDER BY p.id_diagnostic DESC";
    $req = $db->query($sql);
    while ($a = $req->fetch()){
      $result[] = $a;
    }
}catch(PDOException $th){
}
  echo json_encode($result);

?>