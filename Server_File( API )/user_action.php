<?php
  include 'connection_with_database.php';

  $action =$_POST['action'];


  //Query for get all categories
  if($action == "GET_ALL_CATEGORIES"){
    $sql = "SELECT * FROM categories ";
    $result = $db_conn->query($sql);
    $Array["categories"] = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            array_push($Array["categories"], $row);
        }
        echo json_encode($Array);
    }
}

//Query to get types for one class Category

if($action == "GET_TYPES"){
    $category_id = $_POST['categoryId'];

    $sql = "SELECT * FROM types WHERE categoryId = $category_id ";
    $result = $db_conn->query($sql);
    $Array["types"] = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            array_push($Array["types"], $row);
        }
        echo json_encode($Array);
    }
}

//Query to get all  ducts of one type
if($action == "GET_PRODUCTS"){
    $type_id= $_POST['typeId'];
    $sql = "SELECT  id,  title,  imageurl, price, unit, unitsize                   
                                 FROM  products          
                                 WHERE typeId = $type_id";
    
    $result = $db_conn->query($sql); 
    $Array["products"] = array(); 
    if ($result->num_rows > 0) {   
        while($row = $result->fetch_assoc()) {
            array_push($Array["products"], $row); 
        }
        echo json_encode($Array);    
    }
}

//Query to add orders
if($action == "ADD_ORDERS"){
    $user_location= $_POST['userLocation'];
    $user_id= $_POST['userId'];
    $user_phone= $_POST['userPhone'];
    $user_lat_lng= $_POST['userLatLng'];
    $order_items= $_POST['orderItems'];
    $state= $_POST['state'];
    $datetime = $_POST['dateTime'];

    $sql = "INSERT INTO `orders`( `orderItems`, `userLocation`, `userId`, `userLatLng`, `userPhone`, `dateTime`, `state`)
     VALUES ('$order_items','$user_location','$user_id',
     '$user_lat_lng','$user_phone','$datetime','$state')";
    
    $result = $db_conn->query($sql); 
   
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"failde"));
        echo "Error : " . $db_conn->error;
    }
    

}

if($action == "GET_ORDERS"){
    $userId = $_POST['userid'];
    $sql = "SELECT * FROM orders WHERE userId = '$userId' ";
    $result = $db_conn->query($sql);
    $Array["orders"] = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            array_push($Array["orders"], $row);
        }
        echo json_encode($Array);
    }
    else{
        echo "Error : " . $db_conn->error;
    }
}
//?-----------------------update orders------------------------

if($action == "CANCEL_ORDERS"){
  $id=$_POST['id'];
  $state ='canceled';
  
  $sql = "UPDATE `orders` SET `state`='$state' WHERE passcode=$id";
  $result = $db_conn->query($sql);
  
  if($result){
    echo json_encode(array('status'=>"success"));
}else{
    echo json_encode(array('status'=>"fail"));
    echo "Error : " . $db_conn->error;
}
}




?>