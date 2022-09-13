<?php

include 'connection_with_database.php';

$action = $_POST['action'];

if($action == "SEARCH_PRODUCTS"){
    $searchWord= $_POST['searchWord'];
    $sql = "SELECT * FROM  `products` WHERE title like '%$searchWord%'";
    $result = $db_conn->query($sql); 
    $Array["products"] = array(); 
    if ($result->num_rows > 0) {   
        while($row = $result->fetch_assoc()) {
            array_push($Array["products"], $row); 
        }
        echo json_encode($Array);    
    }
}

?>