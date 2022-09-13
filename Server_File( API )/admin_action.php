<?php
  include 'connection_with_database.php';
  include 'imageupload.php';

  $action =$_POST['action'];
//ToDo: test for update image

  //! ============================for Category==============================
//?-----------add new Category to database--------------------
if($action == "ADD_CATEGORY"){
    $title= $_POST['title'];
    $imageName= imageUpload('file');    
    $sql = "INSERT INTO categories (title	, imageurl ) VALUES ('$title', '$imageName')";  
    $result = $db_conn->query($sql);    
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
//?---------------update single Category------------------------
  if($action == "UPDATE_CATEGORY"){
    $title= htmlspecialchars(strip_tags($_POST['title']));
    $imageName= htmlspecialchars(strip_tags($_POST['imageName']));
    $id = $_POST['id'];
    $sql = "UPDATE `categories`  SET `title`='$title'	, `imageurl` ='$imageName' where id=$id";   
    $result = $db_conn->query($sql);   
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
  //?------------------delete Category--------------------------
  if($action == "DELETE_CATEGORY"){
    $id = $_POST['id'];
    $imageName =htmlspecialchars(strip_tags($_POST['imageName']));
    $sql = "DELETE FROM categories WHERE id='$id'";
    $result = $db_conn->query($sql);  
    if($result){
      deleteImage($imageName);
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
//! ==============================Type========================
//?-----------add new Category to database--------------
if($action == "ADD_TYPE"){
    $typeName= $_POST['title'];
    $categoryId= $_POST['categoryId'];
   
    $sql = "INSERT INTO types (typeName, categoryId) VALUES ('$typeName', '$categoryId')";   
    $result = $db_conn->query($sql);   
    if($result){
        echo json_encode(array('status'=>"success"));     
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
//?-------------update single Category----------------
  if($action == "UPDATE_TYPE"){
    $typeName= $_POST['title'];
    $id = $_POST['id'];
    
    $sql = "UPDATE `types`  SET `typeName`='$typeName' where id=$id";  
    $result = $db_conn->query($sql);  
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
  //?--------------------delete Category-------------------
  if($action == "DELETE_TYPE"){
    $id = $_POST['id'];
    $sql = "DELETE FROM types WHERE id='$id'";
    $result = $db_conn->query($sql);  
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
  //! ============================Products==============================
//?-----------add new product to database--------------------
if($action == "ADD_PRODUCT"){
    $title= $_POST['title'];
    $imageName= imageUpload('file');
    $price = $_POST['price'];
    $unit = $_POST['unit'];
    $unitsize = $_POST['unitsize'];
    $typeid = $_POST['typeid'];
  
    $sql = "INSERT INTO `products` (title	, imageurl,price,unit,unitsize,typeId)
    VALUES ('$title', '$imageName','$price','$unit','$unitsize','$typeid')";    
    $result = $db_conn->query($sql);   
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
//?---------------update single Category------------------------
  if($action == "UPDATE_PRODUCT"){
    $title= $_POST['title'];
    $imageName= $_POST['file'];
    $price = $_POST['price'];
    $unit = $_POST['unit'];
    $unitsize = $_POST['unitsize'];
    $typeid = $_POST['typeid'];
    $id = $_POST['id'];
   
    $sql = "UPDATE `products` SET `title`='$title'	, `imageurl` ='$imageName',`price`='$price',
    `unit`='$unit' ,`unitsize`='$unitsize' , `typeId`='$typeid'  where id=$id";   
    $result = $db_conn->query($sql);  
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
  //?------------------delete Category--------------------------
  if($action == "DELETE_PRODUCT"){
    $id = $_POST['id'];
    $imageName =htmlspecialchars(strip_tags($_POST['imageName']));
    $sql = "DELETE FROM `products` WHERE id=$id";
    $result = $db_conn->query($sql); 
   
    if($result){
      deleteImage($imageName);
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }







?>