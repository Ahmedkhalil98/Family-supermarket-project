<?php
  include 'connection_with_database.php';
  include 'imageupload.php';


$action =htmlspecialchars(strip_tags($_POST['action']));


//? -------------get list of slider----------------
if( $action == 'GET_SLIDER_USER'){
      $sql = "SELECT * FROM sliders WHERE showToUser=1";
  $result = $db_conn->query($sql);
  
  $sliderArray["slider"] = array();
  
  if ($result->num_rows > 0) {
    
      while($row = $result->fetch_assoc()) {
          array_push($sliderArray["slider"], $row);
      }
      echo json_encode($sliderArray);
  }
}
if( $action == 'GET_SLIDER_ADMIN'){
  $sql = "SELECT * FROM sliders";
$result = $db_conn->query($sql);

$sliderArray["slider"] = array();

if ($result->num_rows > 0) {

  while($row = $result->fetch_assoc()) {
      array_push($sliderArray["slider"], $row);
  }
  echo json_encode($sliderArray);
}
}
  
  //?-----------------add new slider to database----------------
  if( $action == "ADD_SLIDER"){
    $title=htmlspecialchars(strip_tags($_POST['title']));  
    $imageName= imageUpload('file');

    if($imageName != 'fail'){
       $sql ="INSERT INTO `sliders`( `title`, `imageurl`) 
    VALUES ('$title','$imageName')";
   
    $result = $db_conn->query($sql);   
    if($result){
        echo json_encode(array('status' => "success"));
    }else{
        echo json_encode(array('status' => "fail"));
    }
    }else{
      echo json_encode(array('status' => "fail"));
    }
    
   
  }
//?--------------------------update slider-------------------------
  if( $action == "UPDATE_SLIDER"){
    $title=htmlspecialchars(strip_tags($_POST['title']));
     
    $imageName= htmlspecialchars(strip_tags($_POST['imageName']));
    $id =htmlspecialchars(strip_tags($_POST['sliderId']));
    $sql = "UPDATE `sliders` SET `title`='$title' ,`imageurl`='$imageName' WHERE id =$id"  ;
    $result = $db_conn->query($sql);  
    if($result){
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));
        echo "Error : " . $db_conn->error;
    }
  }
  //?--------------delete slider-----------------
  if(isset($action) && $action == "DELETE_SLIDER"){
    $sliderId = htmlspecialchars(strip_tags($_POST['sliderId']));
    $imageName =htmlspecialchars(strip_tags($_POST['imageName']));
    $sql = "DELETE FROM sliders WHERE id='$sliderId'";
    $result = $db_conn->query($sql);  
    if($result){
      deleteImage($imageName);
        echo json_encode(array('status'=>"success"));
    }else{
        echo json_encode(array('status'=>"fail"));

    }
  }

  //?--------------hide and show slider-----------------
  if($action == "HIDE_SLIDER"){
  
    $id = htmlspecialchars(strip_tags($_POST['sliderId']));
    $showToUser= htmlspecialchars(strip_tags($_POST['showToUser']));
    $sql = "UPDATE sliders  SET showToUser='$showToUser' where id='$id'";  
    $result = $db_conn->query($sql);  
    $sArray["status"] = array();
    if($result){
      array_push($sArray["status"], 'success');
        echo json_encode($sArray);
        
    }else{
      array_push($sArray["status"], 'fail');
        echo json_encode($sArray);
    }
    
  }
  










  


  
  
  
  ?>