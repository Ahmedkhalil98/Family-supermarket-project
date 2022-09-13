<?php

function  sendNotf($title , $msg , $fcm_id ,$p_id,$p_name){


$url ='https://fcm.googleapis.com/fcm/send';


$fields = array(
    'registration' => array(
        $fcm_id

    ),
    'priority' => 'high',
    'content_available' => true,
    'notification' => array(
        "body" => $msg,
        "title" => $title,
        "click_action" => "FLUTTER_NOTIFICATION_CLICK",
        "sound" => "default"
    ),
    'data' => array(
        'page_id' => $p_id,
        'page_name' => $p_name
    )

    );
    $fields = json_encode($fields);

    $headers = array(
        'Authorization: key=' ."AAAAKfMvYTM:APA91bEvhhJ2J3Zn1ox2HnF4WpCaFRbP_dH3QsJoMHqQk1yB9MpJTGTR1wqTVK60ssBkH4l7L0LE15AwCchfNPCOwyzeDFo__cHcd40QNt31Y0n2cGtcVzqo_FUN_73shcFMSyMLpSgE",
        'Content-Type: application/json'
    );

    $ch = curl_init();
    curl_setopt($ch ,CURLOPT_URL ,$url);
    curl_setopt($ch ,CURLOPT_POST , true);
    curl_setopt($ch ,CURLOPT_HTTPHEADER ,$headers);
    curl_setopt($ch ,CURLOPT_RETURNTRANSFER ,true);
    curl_setopt($ch ,CURLOPT_POSTFIELDS ,$fields);

    $result = curl_exec($ch);
    return $result;
    curl_close($ch);
    








}






?>