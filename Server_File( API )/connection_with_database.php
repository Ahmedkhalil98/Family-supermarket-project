<?php
$servername = "localhost";
$dbname = 'grocery_delivery_storage_db';
$username = "root";
$password = "";

  $db_conn = new mysqli($servername,$username,$password,$dbname);

  if ($db_conn -> connect_errno) {
    echo "Failed to connect to MySQL: " . $db_conn -> connect_error;
    exit();
  }

?>