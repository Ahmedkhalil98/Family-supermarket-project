<?php

define('MB' , 1048576); // const

function imageUpload($RequestImage){
$imageName =  $_FILES[$RequestImage]['name'];
$imageTmp  = $_FILES[$RequestImage]['tmp_name'];
$imageSize = $_FILES[$RequestImage]['size'];

global $imageError;
$allowExt = array("jpg","png","jpeg","gif");
$strToArray = explode(".",$imageName);

$ext = $strToArray[1];

$ext = strtolower($ext);
if(!empty($imageName) && !in_array($ext, $allowExt)){
$imageError[] = "Ext";
}
if($imageSize > 2 * MB){
    $imageError = 'size is big';
}
if(empty($imageError)){
    move_uploaded_file($imageTmp , "images/" . $imageName);
    return $imageName;

}else{
    return 'fail';
}

}


function deleteImage($imageName){
    if(file_exists("images/" . $imageName)){
        unlink("images/" . $imageName );

    }
}


?>