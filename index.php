<?php

error_reporting(~0);
ini_set('display_errors', 1);

require 'bestbuy/BestBuy.php';
require 'macys/Macys.php';

header('Content-Type: application/json');

if (isset($_GET['store']) && isset($_GET['intent'])) {
    if ($_GET['store'] == 'bestbuy') {
        $bestbuy = new BestBuy();
        if ($_GET['intent'] == "products") {
            if (isset($_GET['search'])) {
                print_r($bestbuy->getProductData($_GET['search']));
            } else {
                print_r($bestbuy->getProductData());
            }
        } else if ($_GET['intent'] == "categories") {
            print_r($bestbuy->getCategories());
        } else if ($_GET['intent'] == "deals") {
            print_r($bestbuy->getDeals());
        } else {
            echo "Please check API Parameters. Contact API Dev for details.";
        }
    } else if ($_GET['store'] == 'macys') {
        $macys = new Macys();
        if ($_GET['intent'] == "products") {
            if (isset($_GET['search'])) {
                print_r($macys->searchCatalog($_GET['search']));
            } else {
                print_r($macys->searchCatalog());
            }
        } else if ($_GET['intent'] == "deals") {
            print_r($macys->getDeals());
        } else if ($_GET['intent'] == "categories") {
            print_r($macys->getCategories());
        } else {
            echo "Please check API Parameters. Contact API Dev for details.";
        }
    } else if ($_GET['store'] == 'all') {
        $bestbuy = new BestBuy();
        //print_r($bestbuy->getProductData());
    }
}


?>
