<?php
  include 'connection_with_database.php';

$action = $_POST['action'];
//! ==============order=============================
//?-----------------------get all orders-------------------------
if($action == "GET_ORDERS"){
    $sql = "SELECT * FROM orders order by dateTime";
    $result = $db_conn->query($sql);
    $Array["orders"] = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            array_push($Array["orders"], $row);
        }
        echo json_encode($Array);
    }
}
//?-----------------------update orders------------------------

if($action == "UPDATE_ORDERS"){
  $id=$_POST['id'];
  $state ='working';
  
  $sql = "UPDATE `orders` SET `state`='$state' WHERE passcode=$id";
  $result = $db_conn->query($sql);
  
  if($result){
    echo json_encode(array('status'=>"success"));
}else{
    echo json_encode(array('status'=>"fail"));
    echo "Error : " . $db_conn->error;
}
}
//delete order
if($action == "DELETE_ORDERS"){
    $id=$_POST['id'];   
    $sql = "DELETE FROM `orders` WHERE passcode=$id";
    $result = $db_conn->query($sql);
    
    if($result){
      echo json_encode(array('status'=>"success"));
  }else{
      echo json_encode(array('status'=>"fail"));
      echo "Error : " . $db_conn->error;
  }
  }


?>