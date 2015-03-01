<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 2/25/15
 * Time: 10:46 PM
 */

$ApiUrl = "http://api.remix.bestbuy.com/v1/products(manufacturer=canon&salePrice%3C1000)?format=json&show=sku,name,salePrice&apiKey=kfujvmk2euy59qp6wu4mcn5t";
$content = file_get_contents($ApiUrl);
$a = json_decode($content);


htmlDisplay($a);
//echo($a->totalPages);

function htmlDisplay($a) {
    echo "<div style='color: gray'>";
    print_r(json_encode($a->totalPages));
    echo "</div>";

}

//var_dump($content);