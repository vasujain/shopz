<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 3/1/15
 * Time: 3:43 AM
 */

/**
 *
 * REST API
 * https://www.firebase.com/docs/rest/api/
 * https://shopz.firebaseio.com/
 *
 */

define('FIREBASE_URL', "https://shopz.firebaseio.com/");
define('FIREBASE_TOKEN', "18neI3jkcqlkC0C7IXtay1E90HFUayhNAtvt6xId");
define('FIREBASE_DEFAULT_PATH', "/recommendations");
    if(isset($_POST) && isset($_POST['flag'])) {
        $_GET['comment'] = $_POST['messageBox'];
        $_GET['flag'] = $_POST['flag'];
        if(!isset($_GET['pid'])) {
            echo "Error.. Invalid or Null Product Id passed";
            exit;
        }
    }
    if(isset($_GET['intent']) && ($_GET['intent'] == "pidDetails") && isset($_GET['pid'])) {
        getProductByID($_GET['pid']);
    }

    $recommendation = new stdClass();
    $recommendation->pid = $_GET['pid'];
    $flag = $_GET['flag'];

    $firebaseJson = getFirebase();

    $fb = checkIfPidExists($firebaseJson, $recommendation->pid);
    if ($fb == false) {
        //POST
        if($flag == "yes") {
            $recommendation->buyit = 1;
            $recommendation->forgetit = 0;
        } else if($flag == "no") {
            $recommendation->buyit = 0;
            $recommendation->forgetit = 1;
        }
        if($_GET['comment']) {
            $recommendation->comment = array($_GET['comment']);
        }
        $postData = json_encode($recommendation);
        postFirebase($postData);
    } else {
        //PUT
        if($flag == "yes") {
            $recommendation->buyit = $fb->value->buyit + 1;
            $recommendation->forgetit = $fb->value->forgetit;
        } else if($flag == "no") {
            $recommendation->forgetit = $fb->value->forgetit + 1;
            $recommendation->buyit = $fb->value->buyit;
        }
        if($_GET['comment']) {
            $reComments = array();
            $reComments = $fb->value->comment;
            array_push($reComments, $_GET['comment']);
            $recommendation->comment = $reComments;
        }
        $recommendation->pid = $fb->value->pid;
        $putData = json_encode($recommendation);
        putFirebase($putData, $fb->key);
    }

function getFirebase() {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH . ".json");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($ch);
    curl_close($ch);
    header('Content-Type: application/json');
    if (empty($result)) die("Error: No response.");
    else {
        return $result;
    }
}

function postFirebase($postData) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH . ".json");
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    $result = curl_exec($ch);
    curl_close($ch);

    header('Content-Type: application/json');
    if (empty($result)) die("Error: No response.");
    else {
        getProductByID($_GET['pid']);
    }
}

function putFirebase($putData, $key) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FIREBASE_URL . FIREBASE_DEFAULT_PATH . "/" . $key . ".json");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $putData);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
    $result = curl_exec($ch);
    curl_close($ch);

    header('Content-Type: application/json');
    if (empty($result)) die("Error: No response.");
    else {
        print_r($result);
    }
}

function checkIfPidExists($firebaseJson, $pid) {
    header('Content-Type: application/json');
    $firebaseObject = json_decode($firebaseJson);
    foreach($firebaseObject as $fireKey => $fireValue) {
        if($fireValue->pid == $pid) {
            $fire = new stdClass();
            $fire->key = $fireKey;
            $fire->value = $fireValue;
            return $fire;
        }
    }
    return false;
}

function getProductByID($id) {
    header('Content-Type: application/json');
    $firebaseJson = getFirebase();
    $firebaseObject = json_decode($firebaseJson);
    foreach($firebaseObject as $fireKey => $fireValue) {
        if($fireValue->pid == $id) {
            $fire = new stdClass();
            $fire->key = $fireKey;
            $fire->value = $fireValue;
            print_r(json_encode($fire));
            exit;
        }
    }
    $error = new stdClass();
    $error->id = "ERR_PID_NA";
    $error->message = "Product not found in the Database";
    print_r(json_encode($error));
    exit;

}



