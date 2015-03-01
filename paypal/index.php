<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 2/27/15
 * Time: 1:47 AM
 */
require('Payment.php');

define("SANDBOX", "api.sandbox.paypal.com");
define("SB_CLIENT_ID", "AXIhSP9bHSRCm1XLj2XZZqLlqdBysKPIsfKEoi3RM7TMuGqxx58QKG7dDHq9DvZaTzKwqt0CWhuSX7nN");
define("SB_CLIENT_SECRET", "ENG833uv6_SX7uK6tF3evma6gSBxGka4nCaymmq5jyq7QxIcp2BXsqcM1a2wzvU6VaZABAOfqbyx3C-1");
define("OAUTH_URL", "https://api.sandbox.paypal.com/v1/oauth2/token");
define("PAYMENTS_URL", "https://api.sandbox.paypal.com/v1/payments/payment");

createPayment();
//header('Location: '
//$paymentJson = createPaymentObject

function getAccessToken() {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, OAUTH_URL);
    curl_setopt($ch, CURLOPT_USERPWD, SB_CLIENT_ID.":".SB_CLIENT_SECRET);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($ch);
    curl_close($ch);

    if(empty($result))die("Error: No response.");
    else {
        $accessToken = json_decode($result);
        return ($accessToken->access_token);
    }
}

function createPayment() {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, PAYMENTS_URL);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Authorization: Bearer '. getAccessToken(),
        'Content-Type: application/json'
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, getPaymentObject());
    $payment = curl_exec($ch);
    return $payment;

}
function createPaymentObject() {
    $redirect_urls = array("return_url" => "http://example.com/your_redirect_url.html", "cancel_url" => "http://example.com/your_cancel_url.html");
    $intent = "sale";
    $transactions = array();
    $transaction = new stdClass();
    $transaction->amount->total = "769.47";
    $transaction->amount->currency = "USD";
    array_push($transactions, $transaction);
    $payer = array("payment_method" => "paypal");

    $payment = new Payment();
    $payment->setIntent($intent);
    $payment->setRedirectUrls($redirect_urls);
    $payment->setTransactions($transactions);
    $payment->setPayer($payer);
    header('Content-Type: application/json');
    return json_encode($payment);
}


