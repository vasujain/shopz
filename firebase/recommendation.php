<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 3/1/15
 * Time: 3:43 AM
 */


define('FIREBASE_URL', "https://shopz.firebaseio.com/");
define('FIREBASE_TOKEN', "18neI3jkcqlkC0C7IXtay1E90HFUayhNAtvt6xId");
define('FIREBASE_DEFAULT_PATH', "/recommendations.json");

header('Content-Type: application/json');

$recommendation = new stdClass();
$recommendation->pid = $_GET['pid'];
$recommendation->recommendation = $_GET['recommendation'];

$firebaseJson = getFirebase();

if (!checkIfPidExists($firebaseJson, $recommendation->pid)) {
    //POST
    $recommendation = new stdClass();
    $recommendation->pid = $_GET['pid'];
    if($recommendation->recommendation == "yes") {

    }
    $recommendation->buyit = "no";//$_GET['recommendation'];
    $recommendation->forgetit = "no";//$_GET['recommendation'];
    $recommendation->comment = "dont get it";//$_GET['comment'];
    $postData = json_encode($recommendation);
    //postFirebase($recommendation);
} else {
    //PUT
    $recommendation->pid = "128";//$_GET['pid'];
    $recommendation->recommendation = "no";//$_GET['recommendation'];
    $recommendation->comment = "dont get it";//$_GET['comment'];
    $postData = json_encode($recommendation);
}

function getFirebase() {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($ch);
    curl_close($ch);
    if (empty($result)) die("Error: No response.");
    else {
        return $result;
    }
}

function postFirebase($postData) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    $result = curl_exec($ch);
    curl_close($ch);

    if (empty($result)) die("Error: No response.");
    else {
        var_dump($result);
    }
}

function putFirebase($postData) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH);
    curl_setopt($ch, CURLOPT_PUT, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    //curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
    $result = curl_exec($ch);
    curl_close($ch);

    if (empty($result)) die("Error: No response.");
    else {
        var_dump($result);
    }
}

function checkIfPidExists($firebaseJson, $pid) {
    header('Content-Type: application/json');
    $firebaseObject = json_decode($firebaseJson);
    foreach($firebaseObject as $fire) {
        if($fire->pid == $pid) {
            return true;
        }
    }
    return false;
}

//https://samplechat.firebaseio-demo.com/users/jack/name.json

//curl -X POST -d '{"user_id" : "jack", "text" : "Ahoy!"}' \
//https://samplechat.firebaseio-demo.com/message_list.json


//curl -X PATCH -d '{"last":"Jones"}' \
//https://samplechat.firebaseio-demo.com/users/jack/name/.json


//$recData = file_get_contents(FIREBASE_URL.FIREBASE_DEFAULT_PATH);


//header('Content-Type: application/json');
//print_r($recData);

// check if userid exists

