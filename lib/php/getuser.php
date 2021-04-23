<?php
include "connection.php";

  $req = $db->query("SELECT nom, email FROM users WHERE  id =?");
  $result=array();

  while ($row=$result->fetch_assec()){
      $result[]=$row;
  }

  echo json_encode($result);
?>
