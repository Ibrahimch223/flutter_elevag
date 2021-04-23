<?php
  $host = "localhost";
  $dbname = "id16515857_goldenelevage";
  $user = "id16515857_gelevage";
  $pass = "1M/(v-5_oSv07/}^";
  $password = "YES";

  try {
   $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
   // echo "Connecté";
  } catch (\Throwable $th){
   // echo "Erreur:".$th->getMessage();
  }
?>